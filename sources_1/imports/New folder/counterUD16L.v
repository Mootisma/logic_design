`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2023 04:15:57 PM
// Design Name: 
// Module Name: counterUD16L
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


module counterUD16L #(parameter [15:0] INIT = 16'd0) (
    //parameter [15:0] INIT = 16'd0;
    input Up,
    input Dw,
    input clk,
    input LD,
    input [15:0] Din,
    output [15:0] Q,
    output UTC,
    output DTC
    );
    //parameter [15:0] INIT = 16'd0;
    wire [3:0] utcc;
    wire [3:0] dtcc;
    countU4DL #(.INIT(INIT[3:0])) c1 (.Up(Up), .Dw(Dw), .clk(clk), .LD(LD), .UTC(utcc[0]), .DTC(dtcc[0]), .Q(Q[3:0]), .Din(Din[3:0]));
    countU4DL #(.INIT(INIT[7:4])) c2 (.Up(Up&utcc[0]), .Dw(Dw&dtcc[0]), .clk(clk), .LD(LD), .UTC(utcc[1]), .DTC(dtcc[1]), .Q(Q[7:4]), .Din(Din[7:4]));
    countU4DL #(.INIT(INIT[11:8])) c3 (.Up(Up&utcc[0]&utcc[1]), .Dw(Dw&dtcc[0]&dtcc[1]), .clk(clk), .LD(LD), .UTC(utcc[2]), .DTC(dtcc[2]), .Q(Q[11:8]), .Din(Din[11:8]));
    countU4DL #(.INIT(INIT[15:12])) c4 (.Up(Up&utcc[0]&utcc[1]&utcc[2]), .Dw(Dw&dtcc[0]&dtcc[1]&dtcc[2]), .clk(clk), .LD(LD), .UTC(utcc[3]), .DTC(dtcc[3]), .Q(Q[15:12]), .Din(Din[15:12]));
    assign UTC = &utcc;
    assign DTC = &dtcc;
endmodule
