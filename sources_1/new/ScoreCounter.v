`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2023 06:51:13 PM
// Design Name: 
// Module Name: scorecounter
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


module scorecounter(
    input Inc,
    input Dec,
    input LD,
    input clk,
    output [3:0] Q
    );
    countU4DL SCORE (.Up(Inc), .Dw(Dec), .clk(clk), .LD(LD), .Q(Q), .Din(4'b0000));
endmodule
