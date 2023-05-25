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


module decoder(instruction,clock,reset,RegWrite,RegDST,MemorIOtoReg,jal,link_addr,alu_result,memorio_data,read_data_1,read_data_2,immediate_ext);

input[31:0] instruction;
input clock;
input reset;
input RegWrite;
input RegDST;// 1 indicate destination register is "rd"(R),otherwise it's "rt"(I)
input MemorIOtoReg;
input jal;//jal need to write address to $ra
input link_addr; // from ifetch
input[31:0] alu_result;//write data
input[31:0] memorio_data;//ReadData from memory or io
output[31:0] read_data_1;
output[31:0] read_data_2;
output[31:0] immediate_ext;

wire[5:0] op = instruction[31:26];
wire[4:0] rs = instruction[25:21];
wire[4:0] rt = instruction[20:16];
wire[4:0] rd = instruction[15:11];

//check what opcode should be imme_Extend?
//here for andi and ori operation,the extended bit is zero, but for other operations, immediate is sign extension
wire[15:0] immediate= instruction[15:0];
wire[31:0] immediate_ext = (op == 6'b001100||op ==  6'b001101)?{{16{1'b0}},immediate}:{{16{instruction[15]}},immediate};

//the index of register should write
wire[4:0] write_idx = jal?5'b11111:(RegDST)?rd:rt;

//register file
reg [31:0] register[0:31];

integer i;
//read_data_1 is value of source register
assign read_data_1 = register[rs];
//read_data_2 is value of rt register(source register 2).
assign read_data_2 = register[rt];


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
               //if jal, record the link_addr(i.e. PC + 4) to $ra.
               //else check if it is lw(MemtoReg), if yes memory_data, no write alu_result into it.
               register[write_idx] <= (jal? link_addr:(MemorIOtoReg? memorio_data :alu_result));
         end
    end
end

endmodule
