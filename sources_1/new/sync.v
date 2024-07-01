`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2023 05:17:12 PM
// Design Name: 
// Module Name: sync
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


module sync(
	input clk,
	input [15:0] xcoord,
	input [15:0] ycoord,
	output Hsync,
	output Vsync,
	output frame,
	output frame2
	);
	assign Hsync = ~(xcoord >= 16'd655 & xcoord <= 16'd750);
	assign Vsync = ~(ycoord >= 16'd489 & ycoord <= 16'd490);
	// 
	// Frame
    wire Q1, Q2;
    FDRE #(.INIT(1'b0)) Q0_FF (.C(clk), .CE(1'b1), .D(Vsync), .Q(Q1));
	FDRE #(.INIT(1'b0)) Q1_FF (.C(clk), .CE(1'b1), .D(Q1), .Q(Q2));
    assign frame = ~Q2&~Q1&Vsync;
    FDRE #(.INIT(1'b0)) ligma (.C(clk), .CE(1'b1), .D(frame), .Q(frame2));
endmodule
