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


module cpu_top(ori_clk,reset,iodone,switch_in,row_pad,high_led,value_led,led,led_test,line_pad,rx,tx,upg_rst);
input rx;
input upg_rst;
output reg tx;
input ori_clk;
input reset;
input iodone;
input[15:0] switch_in;
input[3:0] row_pad;
output [7:0]high_led,value_led;
output [15:0]led;
output [3:0]line_pad;
output [2:0] led_test;



wire cpu_clk;
wire uart_clk;

cpuclk cpuclk(
.clk_in1(ori_clk),
.single_cycle_cpu_clk(cpu_clk),
.uart_clk(uart_clk)
);
//=============LOW FREQ CLK======================
wire clk_1k_hz,clk_led;
clk_1k clk_1k1(
.uart_clk(uart_clk),
.clk_1k_hz(clk_1k_hz),
.clk_led(clk_led)
);
//===============================================
wire[31:0] ins_o;//from ifetch
wire[31:0] ins_i;//from program_rom
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
assign opcode = ins_o[31:26];
assign func = ins_o[5:0];
controller controller(
.Op(opcode),
.Func(func), 
.Alu_resultHigh(alu_result[31:10]),
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


wire[31:0] branch_base_addr;
wire[31:0] link_addr;
wire[31:0] cur_pc;
wire[31:0] addr_result;
wire zero;
wire[31:0] read_data_1;
wire[31:0] read_data_2;
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
.jr(jr),
.link_addr(link_addr), // from ifetch
.alu_result(alu_result),//write data
.memorio_data(readdata),//ReadData from memory
.read_data_1(read_data_1),
.read_data_2(read_data_2),
.immediate_ext(sign_ext)
);

wire[31:0] writedata;



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
wire uart_ctrl;
wire[15:0] ioread_data;
wire sigctrl;
wire led_tctrl;

//////avoid twitter
reg iodone_atwitter;
reg pre_iodone;
wire iodone_d;
button_decode bd1(
.clk(clk_1k_hz),
.in(iodone),
.out(iodone_d)
);

reg [1:0] clk;
reg clk_3;
always@(posedge cpu_clk)
begin
    if(reset)begin
        clk <= 2'b00;
        clk_3 <= 0;
    end
    if(clk == 2'b11)begin
        clk <= 2'b00;
        clk_3 <= !clk_3; 
    end
    else begin
        clk <= clk + 2'b01;
    end
end



always@(posedge clk_3)begin
    if(pre_iodone==1'b1 && iodone_d == 1'b0)begin
        iodone_atwitter<= 1'b1;
        pre_iodone <= iodone_d;
    end
    else begin
        iodone_atwitter <= 1'b0;
        pre_iodone <= iodone_d;
    end
end
////////

memorio memorio(
.iodone(iodone_atwitter),
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
.sigctrl(sigctrl),
.led_tctrl(led_tctrl),
.uart_ctrl(uart_ctrl)
);

wire[15:0] switch_data;
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
wire [7:0]vvv;
//====================数码管======================
sig_led_num_4 sig_led
(
.clk(clk_led),
.cpuclk(cpu_clk),
.rst(reset),
.n(writedata[15:0]),
.sigctrl(sigctrl),
.high(high_led),
.value(value_led),
.v(vvv)
);
//===================================================
//=================led_light=========================
led_light led_light(
.clk(cpu_clk),
.rst(reset),
.ledctrl(ledctrl),
.wdata(writedata[15:0]),
.led_light(led)
);

led_testcase led_t(
.clk(cpu_clk),
.rst(reset),
.led_tctrl(led_tctrl),
.wdata(writedata[2:0]),
.led_light(led_test)
);

switch switch(
.clk(cpu_clk),
.rst(reset),
.switchctrl(switchctrl),
.switch_data(switch_data),
.switch_i(switch_in)
);
//========================INIT_UART============================
wire upg_clk_w,upg_wen_w;// output clk,(unknown?)
wire[14:0] upg_adr_w;//output address,first address is the bit for chosen data_m or program_m
wire[31:0] upg_dat_w;//output data
wire upg_done_w;//finish bit
wire tx_1;
wire tx_2;
reg uart_state;
always@(*)begin
if(upg_rst)uart_state<=1;
else if(upg_done_w)uart_state<=0;
end
always@(*)begin
if(uart_state)tx<=tx_1;
else tx<=tx_2;
end
//assign tx=uart_state?tx_1;tx_2;

//========================MY_UART==============================
uart_tx(
.sys_clk(ori_clk),
.uart_data(writedata[7:0]),
.uart_txd(tx_2),
.uart_ctrl(uart_ctrl)
);
//=============================================================

//========================UART=================================


uart_bmpg_0 uart(
.upg_clk_i(uart_clk),//输入时钟，用于对齐信号输入，来自clk
.upg_rst_i(upg_rst),//重置信号，用于重置uart，来自重置按钮
.upg_rx_i(rx),//uart 信号接收器,来自外界，来自电脑
.upg_clk_o(upg_clk_w),//uart 输出使用时钟频率，输出至m_ram and p_ram
.upg_wen_o(upg_wen_w),//写内存信号，输出至m_ram and p_ram
.upg_adr_o(upg_adr_w),//地址，输出至m_ram and p_ram
.upg_dat_o(upg_dat_w),//数据，输出至m_ram and p_ram
.upg_done_o(upg_done_w),//输出信号，告诉mem输出完毕，输出至m_ram and p_ram
.upg_tx_o(tx_1));//uart 输出信号，向电脑反馈接收完毕，输出至外界，电脑
//==============================================================

//===============================DATA_MEM============================
data_memory_uart mem(
.ram_clk_i(cpu_clk),//done
.ram_wen_i(memwrite),//done
.ram_adr_i(alu_result[15:2]),//done
.ram_dat_i(writedata),//done
.ram_dat_o(memory_data),//done
.upg_rst_i(upg_rst),//maybe is also reset
.upg_clk_i(upg_clk_w),//done
.upg_wen_i(upg_wen_w&upg_adr_w[14]),//done
.upg_adr_i(upg_adr_w[13:0]),//done
.upg_dat_i(upg_dat_w),//done
.upg_done_i(upg_done_w));//done
//===================================================================
//===============================PROGRAM_MEM=========================
program_rom prgrom(
.rom_clk_i(cpu_clk),
.rom_adr_i(cur_pc[15:2]),
.Instruction_o(ins_i),
.upg_rst_i(upg_rst),
.upg_clk_i(upg_clk_w),
.upg_wen_i(upg_wen_w&!upg_adr_w[14]),
.upg_adr_i(upg_adr_w[13:0]),
.upg_dat_i(upg_dat_w),
.upg_done_i(upg_done_w)
);


endmodule
