`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2023 04:31:34 PM
// Design Name: 
// Module Name: VGA
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
/*  assign vgaRed = {4{(((xw >= 16'd0) & (xw <= 16'd639) & (yw >= 16'd0) & (yw <= 16'd479)))}};
	assign vgaGreen = {4{(xw >= 16'd0 & xw <= 16'd639 & yw >= 16'd0 & yw <= 16'd479)}};
	assign vgaBlue = {4{(xw >= 16'd0 & xw <= 16'd639 & yw >= 16'd0 & yw <= 16'd479)}};*/
/*	assign vgaRed = {4{(((xcoord >= 16'd0) & (xcoord <= 16'd639) & (ycoord >= 16'd0) & (ycoord <= 16'd479)))}};
	assign vgaGreen = {4{(xcoord >= 16'd0 & xcoord <= 16'd639 & ycoord >= 16'd0 & ycoord <= 16'd479)}};
	assign vgaBlue = {4{(xcoord >= 16'd0 & xcoord <= 16'd639 & ycoord >= 16'd0 & ycoord <= 16'd479)}};*/

module VGA(
    input [15:0] xcoord,
    input [15:0] ycoord,
    input [15:0] pxcoord,
    input [15:0] pycoord,
    input game,
    //
    input [15:0] sxcoord1,
    input [15:0] sycoord1,
    input [15:0] width1,
    input CHILL1,
    input RECRUITED1,
    input PINK_SLUG1,
    //input flash1,
    input flash21,
    input flash31,
    input s1f,
    //input FROZEN1,
    //input FROZEN21,
    //
    input [15:0] sxcoord2,
    input [15:0] sycoord2,
    input [15:0] width2,
    input CHILL2,
    input RECRUITED2,
    input PINK_SLUG2,
    //input flash2,
    input flash22,
    input flash32,
    input s2f,
    //input FROZEN2,
    //input FROZEN22,
    //
    input [15:0] sxcoord3,
    input [15:0] sycoord3,
    input [15:0] width3,
    input CHILL3,
    input RECRUITED3,
    input PINK_SLUG3,
    //input flash3,
    input flash23,
    input flash33,
    input s3f,
    //input FROZEN3,
    //input FROZEN23,
    //
    input [15:0] sxcoord4,
    input [15:0] sycoord4,
    input [15:0] width4,
    input CHILL4,
    input RECRUITED4,
    input PINK_SLUG4,
    //input flash4,
    input flash24,
    input flash34,
    input s4f,
    //input FROZEN4,
    //input FROZEN24,
    //
    input [15:0] sxcoord5,
    input [15:0] sycoord5,
    input [15:0] width5,
    input CHILL5,
    input RECRUITED5,
    input PINK_SLUG5,
    //input flash5,
    input flash25,
    input flash35,
    input s5f,
    //input FROZEN5,
    //input FROZEN25,
    input CHILL_BUT_REAL,
    input CHILL_BUT_REAL2,
    input CHILL_BUT_REAL3,
    input CHILL_BUT_REAL4,
    input CHILL_BUT_REAL5,
    //
    output [3:0] vgaRed,
	output [3:0] vgaBlue,
	output [3:0] vgaGreen
    );
    wire left_border, right_border, top_border, bottom_border, grass, ground;
    assign left_border = ( (xcoord >= 16'd0)&(xcoord<=16'd7)&(ycoord>=16'd0)&(ycoord<=16'd479) )&~(game&(flash21|flash22|flash23|flash24|flash25));
    assign right_border = ( (xcoord >= 16'd632)&(xcoord<=16'd639)&(ycoord>=16'd0)&(ycoord<=16'd479) )&~(game&(flash21|flash22|flash23|flash24|flash25));
    assign top_border = ( (ycoord >= 16'd0)&(ycoord<=16'd7)&(xcoord >= 16'd0)&(xcoord<=16'd639) )&~(game&(flash21|flash22|flash23|flash24|flash25));
    assign bottom_border = ( (ycoord >= 16'd472)&(ycoord<=16'd479)&(xcoord >= 16'd0)&(xcoord<=16'd639) )&~(game&(flash21|flash22|flash23|flash24|flash25));
    assign ground = ( (xcoord >= 16'd8)&(xcoord<=16'd631)&(ycoord>=16'd364)&(ycoord<=16'd471) );
    assign grass = ( (xcoord >= 16'd8)&(xcoord<=16'd631)&(ycoord>=16'd360)&(ycoord<=16'd363) );
    // 8 <-> 631-16
    // 8 \/\ 471-16
    wire player, ship1, pinkslug1, ship2, pinkslug2, ship3, pinkslug3, ship4, pinkslug4, ship5, pinkslug5;
    assign player = ( (xcoord >= pxcoord)&(xcoord<=(pxcoord+16'd15))&(ycoord >= pycoord)&(ycoord<=(pycoord+16'd15)) )&~(game&~(flash21|flash22|flash23|flash24|flash25));
    //
    assign ship1 = ((xcoord >= sxcoord1)&(xcoord<=(sxcoord1+width1))&(ycoord>=sycoord1)&(ycoord<=(sycoord1+16'd9)))&~CHILL1&~s1f&~player&~PINK_SLUG1&~RECRUITED1&~CHILL_BUT_REAL;
    assign ship2 = ((xcoord >= sxcoord2)&(xcoord<=(sxcoord2+width2))&(ycoord>=sycoord2)&(ycoord<=(sycoord2+16'd9)))&~CHILL2&~s2f&~player&~PINK_SLUG2&~RECRUITED2&~CHILL_BUT_REAL2;
    assign ship3 = ((xcoord >= sxcoord3)&(xcoord<=(sxcoord3+width3))&(ycoord>=sycoord3)&(ycoord<=(sycoord3+16'd9)))&~CHILL3&~s3f&~player&~PINK_SLUG3&~RECRUITED3&~CHILL_BUT_REAL3;
    assign ship4 = ((xcoord >= sxcoord4)&(xcoord<=(sxcoord4+width4))&(ycoord>=sycoord4)&(ycoord<=(sycoord4+16'd9)))&~CHILL4&~s4f&~player&~PINK_SLUG4&~RECRUITED4&~CHILL_BUT_REAL4;
    assign ship5 = ((xcoord >= sxcoord5)&(xcoord<=(sxcoord5+width5))&(ycoord>=sycoord5)&(ycoord<=(sycoord5+16'd9)))&~CHILL5&~s5f&~player&~PINK_SLUG5&~RECRUITED5&~CHILL_BUT_REAL5;
    //
    assign pinkslug1 = ( ((xcoord >= (sxcoord1 + {1'b0, width1[15:1]} - 16'd4))&(xcoord<=(sxcoord1 + {1'b0, width1[15:1]} + 16'd4))&(ycoord>=(sycoord1+16'd1))&(ycoord<=(sycoord1+16'd8)))&(~CHILL1&~s1f&~player&~CHILL_BUT_REAL))&~(RECRUITED1&~flash31);
    assign pinkslug2 = ( ((xcoord >= (sxcoord2 + {1'b0, width2[15:1]} - 16'd4))&(xcoord<=(sxcoord2 + {1'b0, width2[15:1]} + 16'd4))&(ycoord>=(sycoord2+16'd1))&(ycoord<=(sycoord2+16'd8)))&(~CHILL2&~s2f&~player&~CHILL_BUT_REAL2))&~(RECRUITED2&~flash32);
    assign pinkslug3 = ( ((xcoord >= (sxcoord3 + {1'b0, width3[15:1]} - 16'd4))&(xcoord<=(sxcoord3 + {1'b0, width3[15:1]} + 16'd4))&(ycoord>=(sycoord3+16'd1))&(ycoord<=(sycoord3+16'd8)))&(~CHILL3&~s3f&~player&~CHILL_BUT_REAL3))&~(RECRUITED3&~flash33);
    assign pinkslug4 = ( ((xcoord >= (sxcoord4 + {1'b0, width4[15:1]} - 16'd4))&(xcoord<=(sxcoord4 + {1'b0, width4[15:1]} + 16'd4))&(ycoord>=(sycoord4+16'd1))&(ycoord<=(sycoord4+16'd8)))&(~CHILL4&~s4f&~player&~CHILL_BUT_REAL4))&~(RECRUITED4&~flash34);
    assign pinkslug5 = ( ((xcoord >= (sxcoord5 + {1'b0, width5[15:1]} - 16'd4))&(xcoord<=(sxcoord5 + {1'b0, width5[15:1]} + 16'd4))&(ycoord>=(sycoord5+16'd1))&(ycoord<=(sycoord5+16'd8)))&(~CHILL5&~s5f&~player&~CHILL_BUT_REAL5))&~(RECRUITED5&~flash35);
    //
    //
    //
    assign vgaRed = {4{ ( left_border | right_border | top_border | bottom_border | pinkslug1 | player | pinkslug2 | pinkslug3 | pinkslug4 | pinkslug5) }};
    assign vgaGreen = {4{ (grass) | player | ground}};
    assign vgaBlue = {4{ (ground&~player) | ship1 | pinkslug1 | ship3 | pinkslug3 | ship4 | pinkslug4 | ship2 | pinkslug2 | ship5 | pinkslug5}};
endmodule
