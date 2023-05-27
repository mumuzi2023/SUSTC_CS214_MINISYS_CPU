`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/22 21:05:42
// Design Name: 
// Module Name: cpu_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cpu_top(ori_clk,reset,iodone,switch_in,row_pad,high_led,value_led,led,line_pad,rx,tx,upg_rst);
input rx;
input upg_rst;
output tx;
input ori_clk;
input reset;
input iodone;
input[15:0] switch_in;
input[3:0] row_pad;
output [7:0]high_led,value_led;
output [15:0]led;
output [3:0]line_pad;

wire cpu_clk;
wire uart_clk;

cpuclk cpuclk(
.clk_in1(ori_clk),
.single_cycle_cpu_clk(cpu_clk),
.uart_clk(uart_clk)
);

wire[5:0] opcode;
wire[5:0] func;
wire jr;
wire jmp;
wire jal;
wire branch;
wire nbranch;
wire regdst;
wire memoriotoreg;
wire regwrite;
wire alusrc;
wire memread;
wire memwrite;
wire ioread;
wire iowrite;
wire sftmd;
wire[1:0] aluop;
wire I_format;
wire[31:0] alu_result;

controller controller(
.Op(opcode),
.Func(func), 
.ALU_resultHigh(alu_result[31:10]),
.Jr(jr),
.Jmp(jmp),
.Jal(jal),
.Branch(branch),
.nBranch(nbranch),
.RegDST(regdst),
.MemorIOtoReg(memoriotoreg),
.RegWrite(regwrite), 
.MemRead(memread),
.MemWrite(memwrite),
.IORead(ioread),
.IOWrite(iowrite), 
.ALUSrc(alusrc),
.Sftmd(sftmd), 
.ALUop(aluop),
.I_format(I_format)
);

wire[31:0] ins_o;//from ifetch
wire[31:0] ins_i;//from program_rom
wire[31:0] branch_base_addr;
wire[31:0] link_addr;
wire[31:0] cur_pc;
wire[31:0] addr_result;
wire zero;
wire[31:0] read_data_1;
wire[31:0]  read_data_2;
ifetch ifetch(
.Instruction_o(ins_o),
.branch_base_addr(branch_base_addr), 
.link_addr(link_addr),
.cur_pc(cur_pc),          
.Instruction_i(ins_i),       
.clock(cpu_clk),
.reset(reset),
.Addr_result(addr_result),
.Zero(zero),              
.Read_data_1(read_data_1),
.Branch(branch),
.nBranch(nbranch),
.Jmp(jmp),
.Jal(jal),
.Jr(jr)
);


wire[31:0] sign_ext;
wire[31:0] memory_data;
wire[31:0] readdata;

decoder decoder(
.instruction(ins_o),
.clock(cpu_clk),
.reset(reset),
.RegWrite(regwrite),
.RegDST(regdst),// 1 indicate destination register is "rd"(R),otherwise it's "rt"(I)
.MemorIOtoReg(memoriotoreg),
.jal(jal),//jal need to write address to $ra
.link_addr(link_addr), // from ifetch
.alu_result(alu_result),//write data
.memorio_data(readdata),//ReadData from memory
.read_data_1(read_data_1),
.read_data_2(read_data_2),
.immediate_ext(sign_ext)
);

wire[31:0] writedata;
data_memory data_memory(
.clock(cpu_clk),
.memWrite(memwrite),
.address(alu_result),
.writeData(writedata),/////////////////////////////////////////////
.readData(memory_data)
);


wire[4:0] shamt = ins_o[10:6];
execute execute(
.Read_data_1(read_data_1), //the source of Ainput
.Read_data_2(read_data_2), //one of the sources of Binput
.Sign_extend(sign_ext),//one of the sources of Binput
// from IFetch
.Opcode(opcode), //instruction[31:26]
.Function_opcode(func), //instructions[5:0]
.Shamt(shamt), //instruction[10:6], the amount of shift bits
.PC_plus_4(branch_base_addr), //pc+4
// from Controller
.ALUOp(aluop), //{ (R_format || I_format) , (Branch || nBranch) }
.ALUSrc(alusrc), // 1 means the 2nd operand is an immediate (except beq,bne)
.I_format(I_format),// 1 means I-Type instruction except beq, bne, LW, SW
.Sftmd(sftmd), // 1 means this is a shift instruction
.ALU_Result(alu_result), // the ALU calculation result
.Zero(zero), // 1 means the ALU_reslut is zero, 0 otherwise
.Addr_Result(addr_result)
);

wire ledctrl;
wire switchctrl;
wire padctrl;
wire[31:0] ioread_data;
wire sigctrl;

memorio memorio(
.iodone(iodone),
.address(alu_result),
.memread(memread),
.memwrite(memwrite),
.ioread(ioread),
.iowrite(iowrite),
.memory_data(memory_data),
.ioread_data(ioread_data),
.oridata(read_data_2),
.readdata(readdata),
.writedata(writedata),
.ledctrl(ledctrl),
.switchctrl(switchctrl),
.padctrl(padctrl),
.sigctrl(sigctrl)
);

wire switch_data;
wire[15:0] pad_data;

ioreader ioreader(
.reset(reset),// reset
.ioread(ioread),//from ctrl
.switchctrl(switchctrl),//if it is switch input
.padctrl(padctrl),
.ioread_data_switch(switch_data),  //data from switch
.ioread_data_pad(pad_data),
.ioread_data(ioread_data)//finally choose ioread_data
);
//=============LOW FREQ CLK======================
wire clk_1k_hz;
clk_1k clk_1k1(
.uart_clk(uart_clk),
.clk_1k_hz(clk_1k_hz)
);
//===============================================
//===================PAD=========================
wire[3:0]n1,n2,n3,n4,n5,n6,n7,n8;
keypad_n keypad1(
.line(line_pad),
.row(row_pad),
.clk(uart_clk),
.o1(n1));
//about the keypad
pad_decode pad_decode1(
.clk(clk_1k_hz),
.in(n1),
.padctrl(padctrl),
.o1(n5),
.o2(n6),
.o3(n7),
.o4(n8),
.rst(reset),
.o_4(pad_data));
//================================================
//====================数码管======================
sig_led_num_4 sig_led
(
.clk(clk_1k_hz),
.rst(reset),
.n(writedata),
.sigctrl(sigctrl),
.high(high_led),
.value(value_led)
);
//===================================================
//=================led_light=========================
led_light led_light(
.clk(cpu_clk),
.rst(reset),
.ledctrl(ledctrl),
.wdata(writedata),
.led_light(led)
);

switch switch(
.clk(cpu_clk),
.rst(reset),
.switchctrl(switchctrl),
.switch_data(switch_data),
.switch_i(switch_in)
);

////writedata[15:0] for led
//program_rom program_rom(
//.rom_clk_i(), // ROM clock
//.rom_adr_i(cur_pc),// From IFetch
//.Instruction_o(ins_i), // To IFetch
//// UART Programmer Pinouts
//.upg_rst_i(), // UPG reset (Active High)
//.upg_clk_i(), // UPG clock (10MHz)
//.upg_wen_i(), // UPG write enable
//.upg_adr_i(), // UPG write address
//.upg_dat_i(), // UPG write data
//.upg_done_i() // 1 if program finished
//);
//========================UART=================================
wire upg_clk_w,upg_wen_w;// output clk,(unknown?)
wire[14:0] upg_adr_w;//output address,first address is the bit for chosen data_m or program_m
wire[31:0] upg_dat_w;//output data
wire upg_done_w;//finish bit

uart_bmpg_0 uart(
.upg_clk_i(uart_clk),//输入时钟，用于对齐信号输入，来自clk
.upg_rst_i(upg_rst),//重置信号，用于重置uart，来自重置按钮
.upg_rx_i(rx),//uart 信号接收器,来自外界，来自电脑
.upg_clk_o(upg_clk_w),//uart 输出使用时钟频率，输出至m_ram and p_ram
.upg_wen_o(upg_wen_w),//写内存信号，输出至m_ram and p_ram
.upg_adr_o(upg_adr_w),//地址，输出至m_ram and p_ram
.upg_dat_o(upg_dat_w),//数据，输出至m_ram and p_ram
.upg_done_o(upg_done_w),//输出信号，告诉mem输出完毕，输出至m_ram and p_ram
.upg_tx_o(tx));//uart 输出信号，向电脑反馈接收完毕，输出至外界，电脑
//==============================================================
//===============================MEM============================
wire ram_wen_w;//链接controller
wire[31:0] ram_adr_w;//链接ALU的alu_result
wire[31:0] ram_dat_i_w;//链接decoder的read_data_2
wire[31:0] ram_dat_o_w;//
data_memory_uart mem(
.ram_clk_i(cpu_clk),
.ram_wen_i(ram_wen_w),
.ram_adr_i(ram_adr_w),
.ram_dat_i(ram_dat_i_w),
.ram_dat_o(ram_dat_o_w),
.upg_rst_i(upg_rst),
.upg_clk_i(upg_clk_w),
.upg_wen_i(upg_wen_w&upg_adr_w[14]),
.upg_adr_i(upg_adr_w),
.upg_dat_i(upg_dat_w),
.upg_done_i(upg_done_w));

endmodule
