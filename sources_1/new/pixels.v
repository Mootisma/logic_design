`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2/26/2023
// Design Name: 
// Module Name: pixels
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
module pixels(
	input clk,
	output [15:0] xcoord,
	output [15:0] ycoord
	);
	wire reset_x, reset_y;
	wire [15:0] xco, yco;
	assign reset_x = (16'd799 == xco);
	assign reset_y = (16'd524 == yco) & (16'd799 == xco);
	wire dontcare;
	counterUD16L X (.Up(1'b1), .Dw(1'b0), .clk(clk), .LD(reset_x), .Din(16'd0), .Q(xco), .UTC(dontcare), .DTC(dontcare));
	counterUD16L Y (.Up(reset_x), .Dw(1'b0), .clk(clk), .LD(reset_y), .Din(16'd0), .Q(yco), .UTC(dontcare), .DTC(dontcare));
	assign xcoord = xco;
	assign ycoord = yco;
endmodule