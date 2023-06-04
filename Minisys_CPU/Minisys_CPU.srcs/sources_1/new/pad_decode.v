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
module pad_decode(clk,in,padctrl,o1,o2,o3,o4,o5,o6,o7,o8,rst,o_4);
input clk;//      时钟，输入，输出（单个数字），重置，输出【o1,o2,o3,o4]组合
input rst;// from cpu top
input padctrl;// from memorio
input[3:0]in;
output reg[15:0]o_4; //pad_data
output reg[3:0]o1,o2,o3,o4,o5,o6,o7,o8;
reg [9:0] cnt=0;
reg [3:0] last;
reg b;

always@(negedge clk or posedge rst) begin
        if(rst) begin
            o_4 <= 16'h0000;
        end
		else if(padctrl) begin
			o_4 <= o4*1000+o3*100+o2*10+o1;
        end
		else begin
            o_4 <=o_4;
        end
 end
 
always@(posedge clk) begin
    if(rst)begin o1<=0;o2<=0;o3<=0;o4<=0;o5<=0;o6<=0;o7<=0;o8<=0;cnt<=0;last<=15;b<=1;end
    else if(last!=in||last==15) begin
        if(cnt!=0)cnt<=cnt-1;
        else begin cnt<=0;last<=in;b<=1;end
    end
    else begin
        if(b==1)begin
            if(!cnt[9:9])cnt<=cnt+1;
            else begin
                if(last==14)begin b=0;o8<=0;o7<=0;o6<=0;o5<=0;o4<=0;o3<=0;o2<=0;o1<=0;end
                else begin b=0;o8<=o7;o7<=o6;o6<=o5;o5<=o4;o4<=o3;o3<=o2;o2<=o1;o1<=last; end
            end
        end
        
    end
end
endmodule
