`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/24 18:48:16
// Design Name: 
// Module Name: memorio
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


module memorio(iodone,address,memread,memwrite,ioread,iowrite,memory_data,ioread_data,oridata,readdata,writedata,ledctrl,switchctrl);
input iodone;
input address;
input memread;
input memwrite;
input ioread;
input iowrite;
input[31:0] memory_data;
input[31:0] ioread_data;
input[31:0] oridata;
output[31:0] readdata;// finally choice of mem or io data
output[31:0] writedata;
output ledctrl;
output switchctrl;

//address 32'hFFFFFC80 is the check address of memory
assign readdata = (ioread==1'b1)?((address == 32'hFFFFFC80)?((iodone==1'b0)?32'h00000000:32'h00000001):{16'h0000,ioread_data}):memory_data;
assign writedata = (iowrite==1'b1)?{16'b0000000000000000,oridata[15:0]}:oridata;

assign ledctrl = (iowrite == 1'b1)?1'b1:1'b0;
assign switchctrl = (ioread == 1'b1)?1'b1:1'b0;// simply ioread, complicately it is not only ioread


endmodule
