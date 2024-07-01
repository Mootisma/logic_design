`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2023 06:51:13 PM
// Design Name: 
// Module Name: target
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


module target(
    input [3:0] D,
    input CE,
    input clk,
    output [3:0] Q
    );
    FDRE #(.INIT(1'b0)) Q0_FF (.C(clk), .CE(CE), .D(D[0]), .Q(Q[0]));
	FDRE #(.INIT(1'b0)) Q1_FF (.C(clk), .CE(CE), .D(D[1]), .Q(Q[1]));
	FDRE #(.INIT(1'b0)) Q2_FF (.C(clk), .CE(CE), .D(D[2]), .Q(Q[2]));
	FDRE #(.INIT(1'b0)) Q3_FF (.C(clk), .CE(CE), .D(D[3]), .Q(Q[3]));
endmodule
