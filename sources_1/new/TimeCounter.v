`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2023 06:51:13 PM
// Design Name: 
// Module Name: TimeCounter
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


module TimeCounter(
    input Inc,
    input R,
    input clk,
    output [7:0] Q
    );
    wire utcw;
	wire [7:0] QT;
	countU4DL c1 (.Up(Inc), .Dw(1'b0), .clk(clk), .LD(R), .UTC(utcw), .Q(QT[3:0]), .Din(4'b0000));
	countU4DL c2 (.Up(Inc&utcw), .Dw(1'b0), .clk(clk), .LD(R), .Q(QT[7:4]), .Din(4'b0000));
	assign Q = QT;
endmodule
