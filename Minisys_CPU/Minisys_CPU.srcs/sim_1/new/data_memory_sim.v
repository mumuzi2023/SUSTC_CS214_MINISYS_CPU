`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/18 17:18:05
// Design Name: 
// Module Name: data_memory_sim
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


module data_memory_sim();

reg clock;
reg memWrite;
reg [31:0] addr;
reg [31:0] writeData;
wire [31:0] readData;

data_memory uram
(clock,memWrite,addr,writeData,readData);

always #50 clock = ~clock;

initial fork
#0
clock = 1'b0;
memWrite = 1'b0;
addr = 32'h0000_0010;
writeData = 32'ha000_0000;

//#100
//memWrite = 1'b1;
//#200
//writeData = 32'h0000_00f5;
//#400
//memWrite = 1'b0;
#180
addr = 32'h0000_0014;
//#400
//addr = 32'h0000_0004;
// ... to be completed
join

endmodule
