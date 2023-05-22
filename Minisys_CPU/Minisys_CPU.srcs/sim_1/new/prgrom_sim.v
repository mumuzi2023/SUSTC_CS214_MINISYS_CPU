`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/18 22:39:51
// Design Name: 
// Module Name: prgrom_sim
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


module prgrom_sim( ); //a reference for the testbench ?
reg[31:0] PC;
reg clock=1'b0;
wire [31:0] Instruction;
prgrom instmem(.clka(clock),.addra(PC[15:2]),.douta(Instruction));
always #5 clock = ~clock;
initial begin
clock = 1'b0;
#2 PC = 32'h0000_0000;
repeat(5) begin
#10 PC = PC+4;
#10 $finish;
end
end
endmodule
