`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/23 17:56:40
// Design Name: 
// Module Name: keypad
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
//  1   2   3   a kp1 3  
//  4   5   6   b kp2 2   row[3:0]
//  7   8   9   c kp3 1  
//  *   0   #   d kp4 0  
// kp5 kp6 kp7 kp8
//  3   2   1   0
//    line[3:0]
module keypad(line,row,clk,o1,o2,o3,o4,o5,o6,o7,o8);
input [3:0] line,row;
input clk;
output[3:0] o1,o2,o3,o4,o5,o6,o7,o8;
reg [7:0]counter_s;//counter for add number
reg [7:0]counter_r;//counter for reset to 0//todo:
reg start;//0:active 1:stop,active when the 
wire counter_success_bit=counter_s[7:7];
wire counter_reset_bit=counter_r[7:7];//todo:
reg [3:0] n1,n2,n3,n4,n5,n6,n7,n8;
assign o1=n1;
assign o2=n2;
assign o3=n3;
assign o4=n4;
assign o5=n5;
assign o6=n6;
assign o7=n7;
assign o8=n8;

always @(posedge clk)begin
    if(line==0 && row==0)begin
        if(!counter_reset_bit) counter_r<=1+counter_r;
        else begin
            start<=1'b0;
            counter_s<=8'b00000000;
        end
    end
    else begin
        if(!counter_success_bit) counter_s<=1+counter_s;
        else if(!start)begin
            start<=1;
            counter_r<=8'b00000000;
            n1<=n2;
            n2<=n3;
            n3<=n4;
            n4<=n5;
            n5<=n6;
            n6<=n7;
            n7<=n8;
            if(line[3]&&row[3]) n8<=4'h1;
            else if(line[2]&&row[3]) n8<=4'h2;
            else if(line[1]&&row[3]) n8<=4'h3;
            else if(line[3]&&row[2]) n8<=4'h4;
            else if(line[2]&&row[2]) n8<=4'h5;
            else if(line[1]&&row[2]) n8<=4'h6;
            else if(line[3]&&row[1]) n8<=4'h7;
            else if(line[2]&&row[1]) n8<=4'h8;
            else if(line[1]&&row[1]) n8<=4'h9;
            else if(line[2]&&row[0]) n8<=4'h0;
            else n8<=4'hf;
        end
    end
end
endmodule
