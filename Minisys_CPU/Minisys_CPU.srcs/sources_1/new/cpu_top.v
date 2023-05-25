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


module cpu_top(ori_clk,reset);
input ori_clk;
input reset;


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
///////////////////////////////////////////////////////////////////////
controller controller(
.Op(opcode),
.Func(func), 
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
wire read_data_1;
wire read_data_2;
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

wire sign_ext;
wire alu_result;
wire memory_data;
wire readdata;
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

wire writedata;
data_memory data_memory(
.clock(cpu_clk),
.memWrite(memwrite),
.address(alu_result),
.writeData(writedata),/////////////////////////////////////////////
.readData(memory_data)
);


wire shamt = ins_o[10:6];
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
wire ioread_data;
memorio memorio(
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
.switchctrl(switchctrl)
);

wire switch_data;
ioreader ioreader(
.reset(reset),// reset
.ioread(ioread),//from ctrl
.switchctrl(switchctrl),//if it is switch input
.ioread_data_switch(switch_data),  //data from switch
.ioread_data(ioread_data)//finally choose ioread_data
);


//writedata[15:0] for led

program_rom program_rom(
.rom_clk_i(), // ROM clock
.rom_adr_i(cur_pc),// From IFetch
.Instruction_o(ins_i), // To IFetch
// UART Programmer Pinouts
.upg_rst_i(), // UPG reset (Active High)
.upg_clk_i(), // UPG clock (10MHz)
.upg_wen_i(), // UPG write enable
.upg_adr_i(), // UPG write address
.upg_dat_i(), // UPG write data
.upg_done_i() // 1 if program finished
);

uart_bmpg_0 uart(

);

endmodule
