`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/23 23:05:20
// Design Name: 
// Module Name: clk_1k
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


module clk_1k(uart_clk,clk_1k_hz,clk_led);
input uart_clk;
output clk_1k_hz,clk_led;
reg [19:0] clk;
always@(posedge uart_clk)
begin
    clk<=clk+1;
end
assign clk_1k_hz=clk[9:9];
assign clk_led=clk[14:14];
endmodule
