`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/24 19:50:18
// Design Name: 
// Module Name: keypad_n
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


module keypad_n(line,row,clk,o1,o2,o3,o4,o5,o6,o7,o8);
output reg[3:0]line=4'b1110;
input[3:0]row;
input clk;
output[3:0]o1,o2,o3,o4,o5,o6,o7,o8;
reg[3:0]v1,v2,v3,v4,v5,v6,v7,v8;
assign o1=v1,o2=v2;
assign o3=v3;
assign o4=v4;
assign o5=v5;
assign o6=v6;
assign o7=v7;
assign o8=v8;
reg[9:0] clk_10=0;
reg[9:0] v=0;
reg[1:0] now=1;
always @(posedge clk)begin
clk_10<=clk_10+1;
end
always@(posedge clk_10[7:7])begin
    if(line==4'b1110) begin line<=4'b1101;now<=2;end
    else if(line==4'b1101) begin line<=4'b1011;now<=3;end
    else if(line==4'b1011) begin line<=4'b0111;now<=4;end
    else begin line<=4'b1110;now<=1;end
end
always@(posedge clk_10[2:2])begin
    if(now==1&&!row[0:0]) v1<=1;
    else if(now==2&&!row[0:0]) v1<=2;
    else if(now==3&&!row[0:0]) v1<=3;
    else if(now==1&&!row[1:1]) v1<=4;
    else if(now==2&&!row[1:1]) v1<=5;
    else if(now==3&&!row[1:1]) v1<=6;
    else if(now==1&&!row[2:2]) v1<=7;
    else if(now==2&&!row[2:2]) v1<=8;
    else if(now==3&&!row[2:2]) v1<=9;
    else if(now==2&&!row[3:3]) v1<=0;
    else if(v1-now==0||v1-now==3||v1-now==6||v1-now==9) v1<=10;
end

endmodule
