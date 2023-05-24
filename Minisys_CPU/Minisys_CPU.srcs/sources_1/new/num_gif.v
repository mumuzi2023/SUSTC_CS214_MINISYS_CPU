`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/23 22:47:29
// Design Name: 
// Module Name: num_gif
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


module num_gif(
input [3:0] sw,
output reg [7:0] result
    );
always@*
begin
    case(sw)
    4'h0:result=8'b11111100;
    4'h1:result=8'b01100000;
    4'h2:result=8'b11011010;
    4'h3:result=8'b11110010;
    4'h4:result=8'b01100110;
    4'h5:result=8'b10110110;
    4'h6:result=8'b10111110;
    4'h7:result=8'b11100000;
    4'h8:result=8'b11111110;
    4'h9:result=8'b11100110;
    default result=8'b00000000;
endcase
end
endmodule

