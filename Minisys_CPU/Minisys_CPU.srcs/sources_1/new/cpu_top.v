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
wire memtoreg;
wire regwrite;
wire alusrc;
wire memwrite;
wire sftmd;
wire[1:0] aluop;

controller controller(
.Op(opcode),
.Func(func), 
.Jr(jr),
.Jal(jal),
.Branch(branch),
.nBranch(nbranch),
.RegDST(regdst),
.MemtoReg(memtoreg),
.RegWrite(regwrite), 
.MemWrite(memwrite), 
.ALUSrc(alusrc),
.Sftmd(sftmd), 
.ALUop(aluop)
);

wire[31:0] ins_o;//from ifetch
wire[31:0] ins_i;//from program_rom
wire[31:0] branch_base_addr;
wire[31:0] link_addr;
wire[31:0] cur_pc;
wire[31:0] addr_result;
wire zero;
wire read_data_1;
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

decoder decoder();
execute execute();
program_rom();
uart_bmpg_0 uart();

endmodule
