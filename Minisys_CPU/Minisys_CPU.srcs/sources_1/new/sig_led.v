`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/23 22:41:29
// Design Name: 
// Module Name: sig_led
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


module sig_led(clk,n1,n2,n3,n4,n5,n6,n7,n8,high,value);
input clk;
input[3:0] n1,n2,n3,n4,n5,n6,n7,n8;
output[7:0] high,value;
reg [7:0]h,v;
wire[7:0]v1,v2,v3,v4,v5,v6,v7,v8;
num_gif num_gif1(n1,v1);
num_gif num_gif2(n2,v2);
num_gif num_gif3(n3,v3);
num_gif num_gif4(n4,v4);
num_gif num_gif5(n5,v5);
num_gif num_gif6(n6,v6);
num_gif num_gif7(n7,v7);
num_gif num_gif8(n8,v8);


assign high=h;
assign value=v;
always@(posedge clk)begin
    if(h==8'b00000001)begin
        v<=n7;
        h<=8'b00000010;
    end
    else if(h==8'b00000010)begin
        v<=n6;
        h<=8'b00000100;
    end
    else if(h==8'b00000100)begin
        v<=n5;
        h<=8'b00001000;
    end
    else if(h==8'b00001000)begin
        v<=n4;
        h<=8'b00010000;
    end
    else if(h==8'b00010000)begin
        v<=n3;
        h<=8'b00100000;
    end
    else if(h==8'b001000000)begin
        v<=n2;
        h<=8'b01000000;
    end
    else if(h==8'b01000000)begin
        v<=n1;
        h<=8'b10000000;
    end
    else begin
        v<=n8;
        h<=8'b00000001;
    end

end

endmodule
