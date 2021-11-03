`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/27 13:16:43
// Design Name: 
// Module Name: fskdemodule
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


module FSKdemodule(
    clk,
    cin,
    cout
    );
    input clk;
    input cin;
    output cout;
    wire[7:0] cin;
    reg cout;
    reg[5:0] clk_cnt;
    reg[7:0] clk_cnt_256;
    reg[7:0] cin_cnt;
    reg sample;
    initial sample=1'b0;
    initial clk_cnt=6'b0;
    initial clk_cnt_256=8'b0;
    initial cin_cnt=8'b0;
    initial cout<=0;
    always @(posedge clk)
    begin
        if (clk_cnt_256==255) 
            begin
                clk_cnt_256<=0;
                cin_cnt<=0;
            end
        else
            begin
                clk_cnt_256<=clk_cnt_256+1;
            end
        if(clk_cnt==63)
            begin
                clk_cnt<=0;
                sample<=1'b1;
            end
        else
            begin
                clk_cnt<=clk_cnt+1;
                sample<=1'b0;
            end
    end
    always @(posedge sample)
    begin
        if(cin>=100 && cin<=200)
            cin_cnt<=cin_cnt+1;
        else
            cin_cnt<=cin_cnt;
    end
    always @(cin_cnt or clk_cnt_256)
    begin
        if(clk_cnt_256==255)
            cout<=(cin_cnt>=1)?1:0;
    end
endmodule
