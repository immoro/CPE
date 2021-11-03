`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/27 11:17:38
// Design Name: 
// Module Name: fsk
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

module FSK(
	input clk,//时钟信号
	output reg [7:0]sigOut,//输出已调信号
	output reg [7:0]carryWave1,//1对应的载波幅度
	output reg [7:0]carryWave0,//0对应的载波幅度
	output wire codeSource,//数字基带信号
	output reg codeClk=0,//用来控制数字基带信号的时钟
	output reg stClk=0//用来控制载波的时钟，数字基带时钟周期应为载波时钟的n倍
);
 
//分频器部分
reg [7:0]codeClkCount=0;//时钟计数器
reg [3:0]carryClkCount=0;//载波时钟计数器
always @(posedge clk)
begin
	//codeClk
	if(codeClkCount==127)
	begin
		codeClk=~codeClk;
		codeClkCount=0;
	end
	else
	begin
		codeClkCount=codeClkCount+1;
	end
	
	//carryClk
	if(carryClkCount==1)
	begin
		stClk=~stClk;
		carryClkCount=0;
	end
	else
	begin
		carryClkCount=carryClkCount+1;
	end
end
 
//数字基带信号，m序列发生器
reg [5:0]outReg=6'b010101;//序列寄存器初始化
reg mAdded;//m序列移位的辅助变量
assign codeSource=outReg[5];//输出变量为寄存器序列的最高位
always @(negedge codeClk)
begin
	//手动异或
	if(outReg[0]==outReg[5])
	begin
		mAdded=0;
	end
	else
	begin
		mAdded=1;
	end
	outReg=outReg<<1;//对寄存器左移
	outReg=outReg+mAdded;
end
 
//载波的产生
reg [7:0]waveCount=0;//载波幅度查询变量
always @(posedge stClk)
begin
	if(waveCount==63)
	begin
		waveCount=0;
	end
	else
	begin
		waveCount=waveCount+1;
	end
	
	//根据查询变量进行载波幅度查询
	case(waveCount)
		0:begin carryWave0<=0;carryWave1<=0; end
		1:begin carryWave0<=12;carryWave1<=25; end
		2:begin carryWave0<=25;carryWave1<=49; end
		3:begin carryWave0<=37;carryWave1<=71; end
		4:begin carryWave0<=49;carryWave1<=90; end
		5:begin carryWave0<=60;carryWave1<=106; end
		6:begin carryWave0<=71;carryWave1<=117; end
		7:begin carryWave0<=81;carryWave1<=125; end
		8:begin carryWave0<=90;carryWave1<=127; end
		9:begin carryWave0<=98;carryWave1<=125; end
		10:begin carryWave0<=106;carryWave1<=117; end
		11:begin carryWave0<=112;carryWave1<=106; end
		12:begin carryWave0<=117;carryWave1<=90; end
		13:begin carryWave0<=122;carryWave1<=71; end
		14:begin carryWave0<=125;carryWave1<=49; end
		15:begin carryWave0<=126;carryWave1<=25; end
		16:begin carryWave0<=127;carryWave1<=0; end
		17:begin carryWave0<=126;carryWave1<=-25; end
		18:begin carryWave0<=125;carryWave1<=-49; end
		19:begin carryWave0<=122;carryWave1<=-71; end
		20:begin carryWave0<=117;carryWave1<=-90; end
		21:begin carryWave0<=112;carryWave1<=-106; end
		22:begin carryWave0<=106;carryWave1<=-117; end
		23:begin carryWave0<=98;carryWave1<=-125; end
		24:begin carryWave0<=90;carryWave1<=-127; end
		25:begin carryWave0<=81;carryWave1<=-125; end
		26:begin carryWave0<=71;carryWave1<=-117; end
		27:begin carryWave0<=60;carryWave1<=-106; end
		28:begin carryWave0<=49;carryWave1<=-90; end
		29:begin carryWave0<=37;carryWave1<=-71; end
		30:begin carryWave0<=25;carryWave1<=-49; end
		31:begin carryWave0<=12;carryWave1<=-25; end
		32:begin carryWave0<=0;carryWave1<=0; end
		33:begin carryWave0<=-12;carryWave1<=25; end
		34:begin carryWave0<=-25;carryWave1<=49; end
		35:begin carryWave0<=-37;carryWave1<=71; end
		36:begin carryWave0<=-49;carryWave1<=90; end
		37:begin carryWave0<=-60;carryWave1<=106; end
		38:begin carryWave0<=-71;carryWave1<=117; end
		39:begin carryWave0<=-81;carryWave1<=125; end
		40:begin carryWave0<=-90;carryWave1<=127; end
		41:begin carryWave0<=-98;carryWave1<=125; end
		42:begin carryWave0<=-106;carryWave1<=117; end
		43:begin carryWave0<=-112;carryWave1<=106; end
		44:begin carryWave0<=-117;carryWave1<=90; end
		45:begin carryWave0<=-122;carryWave1<=71; end
		46:begin carryWave0<=-125;carryWave1<=49; end
		47:begin carryWave0<=-126;carryWave1<=25; end
		48:begin carryWave0<=-127;carryWave1<=0; end
		49:begin carryWave0<=-126;carryWave1<=-25; end
		50:begin carryWave0<=-125;carryWave1<=-49; end
		51:begin carryWave0<=-122;carryWave1<=-71; end
		52:begin carryWave0<=-117;carryWave1<=-90; end
		53:begin carryWave0<=-112;carryWave1<=-106; end
		54:begin carryWave0<=-106;carryWave1<=-117; end
		55:begin carryWave0<=-98;carryWave1<=-125; end
		56:begin carryWave0<=-90;carryWave1<=-127; end
		57:begin carryWave0<=-81;carryWave1<=-125; end
		58:begin carryWave0<=-71;carryWave1<=-117; end
		59:begin carryWave0<=-60;carryWave1<=-106; end
		60:begin carryWave0<=-49;carryWave1<=-90; end
		61:begin carryWave0<=-37;carryWave1<=-71; end
		62:begin carryWave0<=-25;carryWave1<=-49; end
		63:begin carryWave0<=-12;carryWave1<=-25; end
	endcase
end
 
//调制部分
always @(posedge stClk)
begin
	if(codeSource)
	begin
		sigOut=carryWave1;
	end
	else
	begin
		sigOut=carryWave0;
	end
end
 
endmodule
