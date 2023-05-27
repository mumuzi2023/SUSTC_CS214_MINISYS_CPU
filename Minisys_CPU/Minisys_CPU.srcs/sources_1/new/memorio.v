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


module memorio(iodone,address,memread,memwrite,ioread,iowrite,memory_data,ioread_data,oridata,readdata,writedata,ledctrl,sigctrl,switchctrl,padctrl);
input iodone;// io is done
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
output sigctrl;
output switchctrl;
output padctrl;

//address 32'hFFFFFC80 is the check address of memory
assign readdata = (ioread==1'b1)?((address == 32'hFFFFFC80)?((iodone==1'b0)?32'h00000000:32'h00000001):{16'h0000,ioread_data}):memory_data;
//here determine the format of memory input or io input if all 32 bits, it can be neglected.
assign writedata = (iowrite==1'b1)?oridata:oridata;

assign ledctrl = (iowrite == 1'b1)?1'b1:1'b0;
assign switchctrl = (ioread == 1'b1 && address == 32'hFFFFFC60)?1'b1:1'b0;// simply ioread, complicately it is not only ioread
assign padctrl = (ioread == 1'b1 && address == 32'hFFFFFC64)?1'b1:1'b0;
assign ledctrl = (iowrite == 1'b1 && address == 32'hFFFFFC68)?1'b1:1'b0;
assign sigctrl = (iowrite == 1'b1 && address == 32'hFFFFFC6C)?1'b1:1'b0;
endmodule
