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


module keypad_n(line,row,clk,o1);
output reg[3:0]line=4'b1110;
input[3:0]row;
input clk;
output[3:0]o1;
reg[3:0]v1;
assign o1=v1;
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
    if(now==1)begin
        if(!(row[0:0]*row[1:1]*row[2:2]*row[3:3]))begin
            if(!row[0:0]) v1<=1;
            else if(!row[1:1]) v1<=4;
            else if(!row[2:2]) v1<=7;
            else if(!row[3:3]) v1<=14;
        end
        else if(v1==1||v1==4||v1==7||v1==14) v1<=15;
    end
    else if(now==2)begin
        if(!(row[0:0]*row[1:1]*row[2:2]*row[3:3]))begin
            if(!row[0:0]) v1<=2;
            else if(!row[1:1]) v1<=5;
            else if(!row[2:2]) v1<=8;
            else if(!row[3:3]) v1<=0;
        end
        else if(v1==2||v1==5||v1==8||v1==0) v1<=15;
    end
    else if(now==3)begin
        if(!(row[0:0]*row[1:1]*row[2:2]*row[3:3]))begin
            if(!row[0:0]) v1<=3;
            else if(!row[1:1]) v1<=6;
            else if(!row[2:2]) v1<=9;
            else if(!row[3:3]) v1<=15;
        end
        else if(v1==3||v1==6||v1==9||v1==15) v1<=15;
    end

end

endmodule
