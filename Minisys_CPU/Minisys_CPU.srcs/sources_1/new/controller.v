`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/17 15:00:11
// Design Name: 
// Module Name: controller
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

module controller(Op,Func,Jr,Jal,Branch,nBranch,RegDST,MemtoReg,RegWrite,MemWrite,ALUSrc,Sftmd,ALUop,I_format);
input[5:0] Op; // instruction[31:26], opcode
input[5:0] Func; // instructions[5:0], funct
output Jr ; // 1 indicates the instruction is "jr", otherwise it's not "jr" output Jmp; // 1 indicate the instruction is "j", otherwise it's not
output Jal; // 1 indicate the instruction is "jal", otherwise it's not
output Branch; // 1 indicate the instruction is "beq" , otherwise it's not
output nBranch; // 1 indicate the instruction is "bne", otherwise it's not
output RegDST; // 1 indicate destination register is "rd"(R),otherwise it's "rt"(I)
output MemtoReg; // 1 indicate read data from memory and write it into register
output RegWrite; // 1 indicate write register(R,I(lw)), otherwise it's not
output MemWrite; // 1 indicate write data memory, otherwise it's not
output ALUSrc; // 1 indicate the 2nd data is immidiate (except "beq","bne")
output Sftmd; // 1 indicate the instruction is shift instruction
output[1:0] ALUop;
output I_format; 
/* if the instruction is R-type or I_format, ALUOp is 2'b10;
if the instruction is"beq" or "bne", ALUOp is 2'b01£»
if the instruction is"lw" or "sw", ALUOp is 2'b00£»
*/
wire R_format;
assign R_format = (Op==6'b000000)? 1'b1:1'b0; 
assign I_format = (Op[5:3] == 3'b001) ? 1'b1:1'b0;
wire lw,sw;
assign lw = (Op==6'b100011)? 1'b1:1'b0; 
assign sw = (Op==6'b101011)? 1'b1:1'b0; 

assign Jr = (Op==6'b000000 && Func == 6'b001000)? 1'b1:1'b0;
assign Jal = (Op==6'b000011)? 1'b1:1'b0;
assign Branch =  (Op==6'b000100)? 1'b1:1'b0;
assign nBranch =  (Op==6'b000101)? 1'b1:1'b0;

assign RegDST = R_format && (~I_format && ~lw); 
assign MemtoReg = lw;
assign RegWrite = (I_format || lw || Jal  || R_format) && ~Jr;
assign MemWrite = lw;/////////////////////remain to checklw;
assign ALUSrc = (I_format || lw || sw);
assign Sftmd = (Op == 6'b000000 && Func[5:3] == 3'b000)? 1'b1:1'b0;
assign ALUop = {(R_format || I_format),(Branch || nBranch)};

endmodule
