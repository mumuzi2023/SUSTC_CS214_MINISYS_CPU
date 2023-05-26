`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/25 15:30:04
// Design Name: 
// Module Name: pad_for_cpu
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

//readme: please use 1k_hz clock!!!!!!!!!!!!
module pad_for_cpu(clk,pad_in,o1,o2,o3,o4,o5,o6,o7,o8,out4,out8,valid,r,ready);
input clk;
input[3:0]pad_in;
output[3:0]o1,o2,o3,o4,o5,o6,o7,o8;
output reg[15:0]out4;
output reg[31:0]out8;
input r;
input[3:0]valid;
output reg ready=1;
reg l_ready=1;
pad_decode pad_decode1(.clk(clk),.in(pad_in),.o1(o1),.o2(o2),.o3(o3),.o4(o4),.rst(0));
always@* begin
    
end

endmodule
