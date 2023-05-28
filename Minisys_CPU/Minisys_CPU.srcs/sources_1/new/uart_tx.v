`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/28 19:14:03
// Design Name: 
// Module Name: uart_tx
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


module uart_tx(
	input 			sys_clk,	//50Mϵͳʱ��
	input	[7:0] 	uart_data,	//���͵�8λ������
	output reg 		uart_txd	//���ڷ���������

);
reg sys_rst_n=1,uart_tx_en=0;
parameter 	SYS_CLK_FRE=100_000_000;    //50Mϵͳʱ�� 
parameter 	BPS=12_800;                 //������9600bps���ɸ���
localparam	BPS_CNT=SYS_CLK_FRE/BPS;   //����һλ��������Ҫ��ʱ�Ӹ���

reg	uart_tx_en_d0;			//�Ĵ�1��
reg uart_tx_en_d1;			//�Ĵ�2��
reg tx_flag;				//���ͱ�־λ
reg [7:0]  uart_data_reg,d1;	//�������ݼĴ���
reg [15:0] clk_cnt;			//ʱ�Ӽ�����
reg [3:0]  tx_cnt;			//���͸���������
reg [2:0] cnt=0;
 
wire pos_uart_en_txd;		//ʹ���źŵ�������
//��׽ʹ�ܶ˵��������źţ�������־�����ʼ����
assign pos_uart_en_txd= uart_tx_en_d0 && (~uart_tx_en_d1);
//======================��⵽�źŸı俪ʼ===============
always @(posedge sys_clk)begin
    if (uart_data!=d1)begin cnt<=0;uart_tx_en<=1;end
    else if(cnt!=0) begin cnt<=cnt+1;end
    else begin uart_tx_en<=0;end
    d1<=uart_data;
end
//========================================================
always @(posedge sys_clk)begin
    begin
		uart_tx_en_d0<=uart_tx_en;
		uart_tx_en_d1<=uart_tx_en_d0;
	end	
end
//����ʹ�ܶ˵��������źţ����ߴ��俪ʼ��־λ�����ڵ�9�����ݣ���ֹλ���Ĵ���������У����ݱȽ��ȶ����ٽ����俪ʼ��־λ���ͣ���־�������
always @(posedge sys_clk)begin
    if(pos_uart_en_txd)begin
		uart_data_reg<=uart_data;
		tx_flag<=1'b1;
	end
	else if((tx_cnt==4'd9) && (clk_cnt==BPS_CNT/2))begin//�ڵ�9�����ݣ���ֹλ���Ĵ���������У����ݱȽ��ȶ����ٽ����俪ʼ��־λ���ͣ���־�������
		tx_flag<=1'b0;
		uart_data_reg<=8'd0;
	end
	else begin
		uart_data_reg<=uart_data_reg;
		tx_flag<=tx_flag;	
	end
end
//ʱ��ÿ����һ��BPS_CNT������һλ��������Ҫ��ʱ�Ӹ��������������ݼ�������1��������ʱ�Ӽ�����
always @(posedge sys_clk)begin
	if(tx_flag) begin
		if(clk_cnt<BPS_CNT-1)begin
			clk_cnt<=clk_cnt+1'b1;
			tx_cnt <=tx_cnt;
		end
		else begin
			clk_cnt<=16'd0;
			tx_cnt <=tx_cnt+1'b1;
		end
	end
	else begin
		clk_cnt<=16'd0;
		tx_cnt<=4'd0;
	end
end
//��ÿ�����ݵĴ���������У����ݱȽ��ȶ��������ݼĴ��������ݸ�ֵ��������
always @(posedge sys_clk)begin
	if(tx_flag)
		case(tx_cnt)
			4'd0:	uart_txd<=1'b0;
			4'd1:	uart_txd<=uart_data_reg[0];
			4'd2:	uart_txd<=uart_data_reg[1];
			4'd3:	uart_txd<=uart_data_reg[2];
			4'd4:	uart_txd<=uart_data_reg[3];
			4'd5:	uart_txd<=uart_data_reg[4];
			4'd6:	uart_txd<=uart_data_reg[5];
			4'd7:	uart_txd<=uart_data_reg[6];
			4'd8:	uart_txd<=uart_data_reg[7];
			4'd9:	uart_txd<=1'b1;
			default:;
		endcase
	else 	
		uart_txd<=1'b1;
end
endmodule