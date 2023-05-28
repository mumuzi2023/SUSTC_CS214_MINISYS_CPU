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
这里的逻辑是用store_data存储每次iowrite时修改的数据，然后用outmode来控制用什么来显示
*/

endmodule
