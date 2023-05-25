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

//* is reset a
module pad_decode(clk,in,o1,o2,o3,o4,rst);
input clk;
input rst;
input[3:0]in;
output reg[3:0]o1,o2,o3,o4;
reg [9:0] cnt=0;
reg [3:0] last;
reg b;

always@(posedge clk) begin
    if(rst)begin o1<=0;o2<=0;o3<=0;o4<=0;cnt<=0;last<=15;b<=1;end
    else if(last!=in||last==15) begin
        if(cnt!=0)cnt<=cnt-1;
        else begin cnt<=0;last<=in;b<=1;end
    end
    else begin
        if(b==1)begin
            if(!cnt[9:9])cnt<=cnt+1;
            else begin
                if(last==14)begin b=0;o4<=0;o3<=0;o2<=0;o1<=0;end
                else begin b=0;o4<=o3;o3<=o2;o2<=o1;o1<=last; end
            end
        end
        
    end
end
endmodule
