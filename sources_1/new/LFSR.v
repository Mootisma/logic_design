`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2023 06:51:13 PM
// Design Name: 
// Module Name: LFSR
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


module LFSR(
    input clk,
    output [7:0] rnd
    );
    wire [7:0] ehe;
	wire d;
	assign d = rnd[0] ^ rnd[5] ^ rnd[6] ^ rnd[7];
	FDRE #(.INIT(1'b0)) Q0_FF (.C(clk), .CE(1'b1), .D(d), .Q(ehe[0]));
	FDRE #(.INIT(1'b0)) Q1_FF (.C(clk), .CE(1'b1), .D(ehe[0]), .Q(ehe[1]));
	FDRE #(.INIT(1'b0)) Q2_FF (.C(clk), .CE(1'b1), .D(ehe[1]), .Q(ehe[2]));
	FDRE #(.INIT(1'b0)) Q3_FF (.C(clk), .CE(1'b1), .D(ehe[2]), .Q(ehe[3]));
	FDRE #(.INIT(1'b0)) Q4_FF (.C(clk), .CE(1'b1), .D(ehe[3]), .Q(ehe[4]));
	FDRE #(.INIT(1'b0)) Q5_FF (.C(clk), .CE(1'b1), .D(ehe[4]), .Q(ehe[5]));
	FDRE #(.INIT(1'b0)) Q6_FF (.C(clk), .CE(1'b1), .D(ehe[5]), .Q(ehe[6]));
	FDRE #(.INIT(1'b1)) Q7_FF (.C(clk), .CE(1'b1), .D(ehe[6]), .Q(ehe[7]));
	assign rnd = ehe;
endmodule
