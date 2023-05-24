`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/18 22:24:34
// Design Name: 
// Module Name: ifetch
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


module ifetch(Instruction_o, branch_base_addr, link_addr, cur_pc,Instruction_i,clock, reset, Addr_result, Read_data_1, Branch, nBranch, Jmp, Jal, Jr, Zero);
output[31:0] Instruction_o; // the instruction fetched from this module to Decoder and Controller
output[31:0] branch_base_addr; // (pc+4) to ALU which is used by branch type instruction
output[31:0] link_addr; // (pc+4) to Decoder which is used by jal instruction
output[31:0] cur_pc; // current PC value
input[31:0] Instruction_i; // instruction from program memory
//from CPU TOP
input clock, reset; // Clock and reset
// from ALU
input[31:0] Addr_result; // the calculated address from ALU
input Zero; // while Zero is 1, it means the ALUresult is zero
// from Decoder
input[31:0] Read_data_1; // the address of instruction used by jr instruction
// from Controller
input Branch; // while Branch is 1,it means current instruction is beq
input nBranch; // while nBranch is 1,it means current instruction is bnq
input Jmp; // while Jmp 1, it means current instruction is jump
input Jal; // while Jal is 1, it means current instruction is jal
input Jr; // while Jr is 1, it means current instruction is jr

/*
it is just a scheme, the detail should be changed according to the actual implementation
*/

reg[31:0] PC,Next_PC;
always @* begin
if(((Branch == 1) && (Zero == 1 )) || ((nBranch == 1) && (Zero == 0))) // beq, bne condition satisfied
    // the calculated new value for PC, the address should times 2 due to the calculation in ALU
    Next_PC = Addr_result << 2;
else if(Jr == 1)
    // no right shift 2 bit while calculating, thus just assign it 
    Next_PC = Read_data_1; // the value of $31 register
else 
    // normal case add 4 to the next instruction
    Next_PC = PC + 32'h0000_0004; // PC+4
end

//branch_base_address shift right two bits when calculating

//program memory get instruction by PC in the posedge, so change PC in negedge to prevent conflicts.
always @(negedge clock) begin
if(reset == 1)
     PC <= 32'h0000_0000;
else begin
    // jmp and jal instruction, just generate the address with PC and instruction address.
    if((Jmp == 1) || (Jal == 1)) begin
        PC <= {PC[31:28],Instruction_i[27:0]<<2};
    end
    else begin
    //set PC to the next PC.
        PC <= Next_PC;
    end

end
end

// to decoder
assign link_addr = PC + 32'h00000004;
// to ALU
assign branch_base_addr = PC + 32'h00000004;
assign Instruction_o = Instruction_i;
assign cur_pc = PC;

endmodule