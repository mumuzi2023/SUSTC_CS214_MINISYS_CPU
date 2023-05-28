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


module TEST_FOR_SIG_LED(ori_clk,line_pad,row_pad,high_led,value_led,led,tx);

input ori_clk;
input [3:0]row_pad;
output [3:0]line_pad;
output [7:0]high_led,value_led;
output [23:0]led;
output tx;

wire cpu_clk,uart_clk,clk_1k_hz;
wire[3:0]n1,n2,n3,n4,n5,n6,n7,n8;
wire[15:0] o_4;
cpuclk cpuclk1(.clk_in1(ori_clk),.single_cycle_cpu_clk(cpu_clk),.uart_clk(uart_clk));
clk_1k clk_1k1(.uart_clk(uart_clk),.clk_1k_hz(clk_1k_hz));
keypad_n keypad1(.line(line_pad),.row(row_pad),.clk(uart_clk),.o1(n1));
uart_tx(.sys_clk(ori_clk),.uart_data({n6,n5}),.uart_txd(tx));
pad_decode pad_decode1(.clk(clk_1k_hz),.in(n1),.o1(n5),.o2(n6),.o3(n7),.o4(n8),.rst(0),.o_4(o_4));
//sig_led_num_4 sig_led
//(
//.clk(clk_1k_hz),
//.rst(0),
//.n(16'b0000101010101010),
//.sigctrl(sigctrl),
//.high(high_led),
//.value(value_led)
//);
sig_led sig_led(.clk(clk_1k_hz),.n1(n1),.n2(n2),.n3(n3),.n4(n4),.n5(n5),.n6(n6),.n7(n7),.n8(n8),.high(high_led),.value(value_led));
assign led=24'b111111111111111111111111;
endmodule
