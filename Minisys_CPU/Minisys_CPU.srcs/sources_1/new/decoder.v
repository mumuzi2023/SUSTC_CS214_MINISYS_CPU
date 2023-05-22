`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/17 15:00:24
// Design Name: 
// Module Name: decoder
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


module decoder(instruction,clock,reset,RegWrite,RegDST,MemtoReg,jal,link_addr,alu_result,memory_data,read_data_1,read_data_2);

input[31:0] instruction;
input clock;
input reset;
input RegWrite;
input RegDST;// 1 indicate destination register is "rd"(R),otherwise it's "rt"(I)
input MemtoReg;
input jal;//jal need to write address to $ra
input link_addr; // from ifetch
input[31:0] alu_result;//write data
input[31:0] memory_data;//ReadData from memory
output[31:0] read_data_1;
output[31:0] read_data_2;

wire[5:0] op= instruction[31:26];
wire[4:0] rs= instruction[25:21];
wire[4:0] rt = instruction[20:16];
wire[4:0] rd= instruction[15:11];
wire[15:0] immediate= instruction[15:0];
wire[31:0] immediate_ext = (op == 6'b001100||op ==  6'b001101)?{{16{1'b0}},immediate}:{{16{instruction[15]}},immediate};
wire[4:0] write_idx = jal?5'b11111:(RegDST)?rd:rt;//the index of register should write

reg [31:0] register[0:31];//register file

integer i;
assign read_data_1 = register[rs];
assign read_data_2 = register[rt];
//check what opcode should be imme_Extend?
//here for andi and ori operation,the extended bit is zero, but for other operations, immediate is sign extensio 

// The reading should be done at any time while writing only happens on the posedge of the clock
// the next always block control the write 
always @(posedge clock)begin
    if(reset)begin
        for(i =0;i<32;i=i+1)begin
            register[i] <= 32'h00000000;
        end
    end
    else begin
    // data from alu_result or data from memory?
         if((RegWrite || jal) && write_idx != 0) begin
               register[write_idx] <= (jal? link_addr:(MemtoReg? memory_data :alu_result));
         end
    end
end

endmodule
