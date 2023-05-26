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


module sig_led_num_4(clk,rst,n,sigctrl,high,value);
input clk;
input rst;
input sigctrl;
input[15:0]n;
output reg[7:0] high;
output reg[7:0] value;

wire[3:0] n1,n2,n3,n4;
wire[7:0] high1,value1;
reg [3:0]n5=0,n6=0,n7=0,n8=0;
assign n1=n%10;
assign n2=(n/10)%10;
assign n3=(n/100)%10;
assign n4=(n/1000)%10;
sig_led sig_led1(clk,n1,n2,n3,n4,n5,n6,n7,n8,high1,value1);

//直接显示和输出显示区别开来，可以做到吗？

always@(negedge clk or posedge rst) begin
if(rst) begin
    high <= 8'h00;
    value <= 8'h00;
end
else begin
    if(sigctrl) begin
         high <= high1;
         value <= value1;
    end
    else begin
        high <= high;
        value <= value;  
    end     
end
end
endmodule
