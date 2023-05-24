`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/24 11:03:30
// Design Name: 
// Module Name: TEST_FOR_SIG_LED
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


module TEST_FOR_SIG_LED(ori_clk,line_pad,row_pad,high_led,value_led);
input ori_clk;
input [3:0]line_pad,row_pad;
output [7:0]high_led,value_led;
wire cpu_clk,uart_clk,clk_1k_hz;
reg[3:0]n1=1,n2=2,n3=3,n4=4,n5=5,n6=6,n7=7,n8=8;
cpuclk cpuclk1(.clk_in1(ori_clk),.single_cycle_cpu_clk(cpu_clk),.uart_clk(uart_clk));
clk_1k clk_1k1(.uart_clk(uart_clk),.clk_1k_hz(clk_1k_hz));
//keypad keypad1(.line(line_pad),.row(row_pad),.clk(uart_clk),.o1(n1),.o2(n2),.o3(n3),.o4(n4),.o5(n5),.o6(n6),.o7(n7),.o8(n8));
sig_led sig_led(.clk(clk_1k_hz),.n1(n1),.n2(n2),.n3(n3),.n4(n4),.n5(n5),.n6(n6),.n7(n7),.n8(n8),.high(high_led),.value(value_led));

endmodule
