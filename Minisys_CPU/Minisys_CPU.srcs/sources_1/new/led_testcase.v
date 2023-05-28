`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/28 11:06:43
// Design Name: 
// Module Name: led_testcase
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


module led_testcase(clk,rst,led_tctrl,wdata,led_light);

input clk,rst;
input led_tctrl;// means that the current station is io write(io presentation)
input[2:0] wdata;// the data should be shown
output reg[2:0] led_light;// output of led

always@(negedge clk or posedge rst) begin
        if(rst) begin
            led_light <= 3'b0000;
        end
		else begin
		    if(led_tctrl)
                led_light <= wdata;
//                  led_light = 16'hFFFF;
            else
                led_light <= led_light;       
        end
end

endmodule
