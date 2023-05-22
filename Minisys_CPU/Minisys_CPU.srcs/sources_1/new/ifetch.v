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


module ifetch(Instruction, branch_base_addr, link_addr, clock, reset, Addr_result, Read_data_1, Branch, nBranch, Jmp, Jal, Jr, Zero);
output[31:0] Instruction; // the instruction fetched from this module to Decoder and Controller
output[31:0] branch_base_addr; // (pc+4) to ALU which is used by branch type instruction
output[31:0] link_addr; // (pc+4) to Decoder which is used by jal instruction
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

prgrom instmem(
        .clka(clock),         // input wire clka
        .addra(PC[15:2]),     // input wire [13 : 0] addra
        .douta(Instruction)         // output wire [31 : 0] douta
);



reg[31:0] PC,Next_PC;
always @* begin
if(((Branch == 1) && (Zero == 1 )) || ((nBranch == 1) && (Zero == 0))) // beq, bne condition satisfied
    Next_PC = Addr_result << 2;// the calculated new value for PC ,check out if the indexes omitted two bits.
else if(Jr == 1)
    Next_PC = Read_data_1 << 2; // the value of $31 register
else 
    Next_PC = PC + 32'h0000_0004; // PC+4
end

//link_address and branch_base_address shift right two bits when calculating

always @(negedge clock) begin ///////////////////////////check it is negedge or posedge
if(reset == 1)
     PC <= 32'h0000_0000;
else begin

    if((Jmp == 1) || (Jal == 1)) begin
        PC <= {PC[31:28],Instruction[27:0]<<2};
    end
    else begin
        PC <= Next_PC;
    end

end
end

assign link_addr = PC + 4;
assign branch_base_addr = PC + 4;

endmodule