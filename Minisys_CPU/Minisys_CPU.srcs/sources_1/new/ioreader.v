`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/24 20:30:04
// Design Name: 
// Module Name: ioreader
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


module ioreader(reset,ioread,switchctrl,padctrl,ioread_data_switch,ioread_data_pad,ioread_data);

input reset;// reset
input ioread;//from ctrl
input switchctrl;//from memorio
input padctrl; //from memorop 
input[15:0] ioread_data_switch;  //data from switch
input[15:0] ioread_data_pad;
output reg[15:0] ioread_data;    // to memorio
   

   
always @* begin
    if(reset == 1'b1)
        ioread_data = 16'b0000000000000000;
    else if(ioread == 1'b1) begin
        if(switchctrl == 1'b1)
            ioread_data = ioread_data_switch;
        else if(padctrl == 1'b1)
            ioread_data = ioread_data_pad;
        else   
            ioread_data = ioread_data;
    end
end
endmodule
