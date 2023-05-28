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
    4'h0:result<=8'b11000000;
    4'h1:result<=8'b11111001;
    4'h2:result<=8'b10100100;
    4'h3:result<=8'b10110000;
    4'h4:result<=8'b10011001;
    4'h5:result<=8'b10010010;
    4'h6:result<=8'b10000010;
    4'h7:result<=8'b11111000;
    4'h8:result<=8'b10000000;
    4'h9:result<=8'b10011000;
    default result<=8'b11111111;
endcase
end
endmodule

