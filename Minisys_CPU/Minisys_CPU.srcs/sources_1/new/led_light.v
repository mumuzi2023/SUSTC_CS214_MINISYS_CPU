`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/26 20:07:27
// Design Name: 
// Module Name: led_light
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

module led_light(clk,rst,ledctrl,wdata,led_light);
input clk,rst;
input ledctrl;// means that the current station is io write(io presentation)
input[15:0] wdata;// the data should be shown
output reg[15:0] led_light;// output of led

always@(negedge clk or posedge rst) begin
        if(rst) begin
            led_light <= 16'h0000;
//              led_light <= 16'hFFFF;
        end
		else begin
		    if(ledctrl)
                led_light <= wdata;
//                  led_light = 16'hFFFF;
            else
                led_light <= led_light;       
        end
end

/*
������߼�����store_data�洢ÿ��iowriteʱ�޸ĵ����ݣ�Ȼ����outmode��������ʲô����ʾ
*/

endmodule
