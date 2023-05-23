`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/22 21:47:53
// Design Name: 
// Module Name: IO_of_switch
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


module IO_of_switch(number_in,clk,finish,clear,number_out,ready);
input[7:0] number_in;// read from the switch
input clk;
input finish;// press of the button
input clear;//instruction to clear the output
output[7:0] number_out;// output
output ready;

reg[7:0] number_o;
reg r;
reg[7:0] counter;

wire counter_success_bit=counter[7:7];
assign number_out = number_o;
assign ready = r;

always @(posedge clk)begin
    if(!clear)begin//clear the output
        number_o<=2'b00000000;
        r<=2'b0;
        counter<=2'b00000000;
    end
    else if(finish&&!r)begin
        if (!counter_success_bit) begin
            counter<=counter+1;
        end
        else begin
            r<=2'b1;
            number_o<=number_in;
        end
    end
    else counter<=0;
end
endmodule
