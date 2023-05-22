`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/17 14:58:39
// Design Name: 
// Module Name: data_memory
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


module data_memory(clock,memWrite,address,writeData,readData);
input clock;
input memWrite;
input[31:0] address;
input[31:0] writeData;
output[31:0] readData;
wire clk;
RAM ram (
.clka(clk), // input wire clka
.wea(memWrite), // input wire [0 : 0] wea
.addra(address[15:2]), // input wire [13 : 0] addra
.dina(writeData), // input wire [31 : 0] dina
.douta(readData) // output wire [31 : 0] douta
);
/*The 'clock' is from CPU-TOP, suppose its one edge has been used at the upstream module of data memory, such as IFetch, Why Data-Memroy DO NOT use the same edge as other module ? */
assign clk = !clock;

endmodule
