`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/26 16:42:09
// Design Name: 
// Module Name: switch
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

module switch(clk, rst,switchctrl,switch_data, switch_i);
    input clk;
    input rst;
    input switchctrl;// from memorio
    input [15:0] switch_i;	//input from switch
    output reg[15:0] switch_data; // to ioreader
    
    
    always@(negedge clk or posedge rst) begin
        if(rst) begin
            switch_data <= 16'h0000;
        end
		else if(switchctrl) begin
			switch_data <= switch_i;
        end
		else begin
            switch_data <= switch_data;
        end
    end
endmodule
