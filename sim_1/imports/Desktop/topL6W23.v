`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2/26/2023
// Design Name: 
// Module Name: topL6W23
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:// 
//////////////////////////////////////////////////////////////////////////////////
module topL6W23(
	input clkin,
	input [15:0] xcoord,
	input [15:0] ycoord,
	input btnC,
	input btnD,
	input btnU,
	input btnL,
	input btnR,
	input [15:0] sw,
	output dp,
	output [3:0] an,
	output [15:0] led,
	output [6:0] seg,
	output Hsync,
	output Vsync,
	output vgaRed[3:0],
	output vgaBlue[3:0],
	output vgaGreen[3:0]
	);
	// rgb low outside the active region
	wire x, y;
	pixels sඞs (.clk(clkin), .xcoord(x), .ycoord(y));
	assign vgaRed = {4{(x >= 16'd0 & x <= 16'd639 & y >= 16'd0 & y <= 16'd479)}};
	assign vgaGreen = {4{(x >= 16'd0 & x <= 16'd639 & y >= 16'd0 & y <= 16'd479)}};
	assign vgaBlue = {4{(x >= 16'd0 & x <= 16'd639 & y >= 16'd0 & y <= 16'd479)}};
endmodule
