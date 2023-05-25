`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/24 14:34:21
// Design Name: 
// Module Name: execute_sim
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


module execute_sim();

reg [31:0] Read_data_1; //the source of Ainput
reg [31:0] Read_data_2; //one of the sources of Binput
reg [31:0] Sign_extend; //one of the sources of Binput
// from IFetch
reg [5:0] Opcode; //instruction[31:26]
reg[5:0] Function_opcode; //instructions[5:0]
reg[4:0] Shamt; //instruction[10:6], the amount of shift bits
reg[31:0] PC_plus_4; //pc+4
reg[1:0] ALUOp; //{ (R_format || I_format) , (Branch || nBranch) }
reg ALUSrc; // 1 means the 2nd operand is an immediate (except beq,bne)
reg I_format; // 1 means I-Type instruction except beq, bne, LW, SW
reg Sftmd; // 1 means this is a shift instruction

wire [31:0] ALU_Result; // the ALU calculation result
wire Zero; // 1 means the ALU_reslut is zero, 0 otherwise
wire[31:0] Addr_Result; // the calculated instruction address

execute execute(Read_data_1,Read_data_2,Sign_extend,Opcode,Function_opcode,Shamt,PC_plus_4,ALUOp,ALUSrc,I_format,Sftmd,ALU_Result,Zero,Addr_Result);

initial begin
#0
Read_data_1 = 32'h00000001;
Read_data_2 = 32'h00000004;
Sign_extend = 32'h00000008;

Opcode = 6'b000000;
Function_opcode = 6'b000000;

Shamt = 5'b00010;
PC_plus_4 = 32'hFFFFFFFC;
ALUOp = 2'b10;
ALUSrc = 1'b0;
I_format = 1'b0;
Sftmd = 1'b1;

end

endmodule
