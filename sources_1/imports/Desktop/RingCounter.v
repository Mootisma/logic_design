`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2023 06:51:13 PM
// Design Name: 
// Module Name: RingCounter
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


module RingCounter(
    input Advance,
    input clk,
    output [3:0] Q
    );
    wire [3:0] D;
    FDRE #(.INIT(1'b1)) Q0_FF (.C(clk), .CE(Advance), .D(D[3]), .Q(D[0]));
    FDRE #(.INIT(1'b0)) Q1_FF (.C(clk), .CE(Advance), .D(D[0]), .Q(D[1]));
    FDRE #(.INIT(1'b0)) Q2_FF (.C(clk), .CE(Advance), .D(D[1]), .Q(D[2]));
    FDRE #(.INIT(1'b0)) Q3_FF (.C(clk), .CE(Advance), .D(D[2]), .Q(D[3]));
    assign Q = D;
endmodule
