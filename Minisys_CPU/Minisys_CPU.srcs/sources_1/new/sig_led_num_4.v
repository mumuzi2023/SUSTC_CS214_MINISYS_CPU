`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/26 20:19:54
// Design Name: 
// Module Name: sig_led_num_4
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


module sig_led_num_4(clk,cpuclk,rst,n,sigctrl,high,value);
input cpuclk;
input clk;
input rst;
input sigctrl;
input[15:0] n;
output [7:0] high;
output [7:0] value;
wire[3:0] n1,n2,n3,n4;
reg [15:0]nn;
//wire[7:0] value1;
reg [3:0]n5=0,n6=0,n7=0,n8=0;
assign n1=nn%10;
assign n2=(nn/10)%10;
assign n3=(nn/100)%10;
assign n4=(nn/1000)%10;
sig_led sig_led1(clk,n1,n2,n3,n4,n5,n6,n7,n8,high,value);

//直接显示和输出显示区别开来，可以做到吗？

always@(posedge cpuclk or posedge rst) begin
if(rst) begin
    nn <= 16'h0000;
end
else begin
    if(sigctrl) begin
         nn <= n;
    end
    else begin
        nn <= nn;  
    end     
end
end

endmodule
