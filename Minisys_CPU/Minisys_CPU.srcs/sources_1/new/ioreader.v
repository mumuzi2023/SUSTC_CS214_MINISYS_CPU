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


module ioreader(reset,ioread,switchctrl,ioread_data,ioread_data_switch);

input reset;// reset
input ioread;//from ctrl
input switchctrl;        //  从memorio经过地址高端线获得的拨码开关模块片选
input[15:0] ioread_data_switch;  //data from switch
output[15:0] ioread_data;    // to memorio
   
reg[15:0] ioread_data;
   
always @* begin
    if(reset == 1)
        ioread_data = 16'b0000000000000000;
    else if(ioread == 1) begin
        if(switchctrl == 1)
            ioread_data = ioread_data_switch;
        else   
            ioread_data = ioread_data;
    end
end
endmodule
