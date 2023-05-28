`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/28 13:45:34
// Design Name: 
// Module Name: button_decode
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


module button_decode(clk,in,out);
input clk;//      时钟，输入，输出（单个数字），重置，输出【o1,o2,o3,o4]组合
input in;
output reg out;
reg [9:0] cnt=0;


always@(posedge clk) begin
    if(in==0&&cnt>10'b0000000000)cnt<=cnt-1;
    else if(in==1&&cnt<10'b0000010000)cnt<=cnt+1;
    else if(cnt==10'b0000010000) out<=1;
    else if(cnt==10'b0000000000) out<=0;
    else cnt=10'b0000000000;
end
endmodule
