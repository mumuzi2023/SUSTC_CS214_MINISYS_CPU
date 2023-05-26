`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/26 17:15:53
// Design Name: 
// Module Name: output_control
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


module output_control(clk,rst,iowrite,wdata,outmode,led_light);
input clk,rst;
input iowrite;// means that the current station is io write(io presentation)
input[15:0] wdata;// the data should be shown
input[1:0] outmode;// higher bit means led, lower bit means pad
output reg[15:0] led_light;// output of led

reg [15:0] store_data;
always@(negedge clk or posedge rst) begin
        if(rst) begin
            store_data <= 16'h0000;
        end
        else if(iowrite==1'b1)
            store_data = wdata;
		else begin
            store_data <= store_data;
        end
end

always@(negedge clk or posedge rst) begin
        if(rst) begin
            led_light <= 16'h0000;
        end
		else begin
		    if(outmode[0]==1'b1)
                led_light <= store_data;
            else
                led_light <= 16'h0000;       
        end
end

/*
这里的逻辑是用store_data存储每次iowrite时修改的数据，然后用outmode来控制用什么来显示
*/

endmodule
