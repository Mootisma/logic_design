`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2023 04:25:33 PM
// Design Name: 
// Module Name: player_state
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


module player_state(
    //input xcoord,
    //input ycoord,
    input btnL,
    input btnR,
    input btnD,
    input game,
    input resetp,
    input clk,
    input frame,
    output [15:0] px,
    output [15:0] py
    );
    wire [15:0] pxcoord, pycoord;
    wire LEFT, RIGHT, UP, DOWN, dontcare;
    counterUD16L #(.INIT(16'd315)) X (.Up(RIGHT), .Dw(LEFT), .clk(clk), .LD(resetp), .Din(16'd315), .Q(pxcoord), .UTC(dontcare), .DTC(dontcare));
    counterUD16L #(.INIT(16'd344)) Y (.Up(DOWN), .Dw(UP), .clk(clk), .LD(resetp), .Din(16'd344), .Q(pycoord), .UTC(dontcare), .DTC(dontcare));
    assign LEFT = (btnL & ~btnR & (pxcoord > 16'd8) & (pycoord == 16'd344) & frame)&~game;// left border
    assign RIGHT = (btnR & ~btnL & (pxcoord+16'd15 <= 16'd630) & (pycoord == 16'd344) & frame)&~game;//right border
    assign DOWN = (btnD & pycoord <= 16'd455 & frame)&~game;//above the border
    assign UP = (~btnD & pycoord >= 16'd345 & frame)&~game;//on the grass
    // 8 <-> 631-16
    // 8 \/\ 471-16
    // 607 447
    assign px = pxcoord;
    assign py = pycoord;
endmodule
