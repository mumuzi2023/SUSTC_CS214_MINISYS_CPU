`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/25 09:57:09
// Design Name: 
// Module Name: pad_decode
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


module pad_decode(clk,in,o1,o2,o3,o4);
input clk;
input[3:0]in;
output reg[3:0]o1,o2,o3,o4;
reg [8:0] cnt=0;
reg [3:0] last;
reg b;

always@(posedge clk) begin
    if(last!=in||last==10) begin cnt<=0;last<=in;b<=1;end
    else begin
        if(b==1)begin
            if(!cnt[8:8])cnt<=cnt+1;
            else begin b=0;o4<=o3;o3<=o2;o2<=o1;o1<=last;end
        end
        
    end
end
endmodule
