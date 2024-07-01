`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2023 01:56:09 PM
// Design Name: 
// Module Name: ship_state
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


module ship_state(
    input [15:0] pxcoord,
    input [15:0] pycoord,
    input clk,
    input frame,
    input frame2,
    input T1,
    input T2,
    input T3,
    input [15:0] width,
    input [15:0] position,
    input btnC,
    input freeze,
    input exitchill,
    output [15:0] sx,
    output [15:0] sy,
    output rtimew,
    output incsc,
    output resetsc,
    output loadtarget1,
    output loadtarget2,
    output resetp,
    output CHILL,
    //output FALL,
    output PLAYER_CONTACT,
    //output GROUND_CONTACT,
    output PINK_SLUG,
    output RECRUITED,
    output CHILL_BUT_REAL
    //output FROZEN
    );
    wire UP, dontcare, resetY;
    wire [15:0] sxcoord, sycoord;
    counterUD16L #(.INIT(16'd10)) Y (.Up(UP), .Dw(1'b0), .clk(clk), .LD(resetY), .Din(16'd10), .Q(sycoord), .UTC(dontcare), .DTC(dontcare));
    assign sxcoord = position;
    //position at top left of wing
    //position_x + width for right wing of ship
    //position_x for left wing of ship
    //position_y to position_y + 9 for top and bottom of ship
    //position_y + 1 to + 8 for top and bottom of pink slug, position_x + width/2 + 4 for right side of pink slug, width/2 - 4 for left side of pink slug
    //wire CHILL, FALL, PLAYER_CONTACT, GROUND_CONTACT, PINK_SLUG, RECRUITED;
    wire FALL, GROUND_CONTACT;
    wire NEXT_CHILL, NEXT_FALL, NEXT_PLAYER_CONTACT, NEXT_GROUND_CONTACT, NEXT_PINK_SLUG, NEXT_RECRUITED, NEXT_FROZEN, NEXT_CHILL_BUT_REAL;
    //assign UP = (~( (sxcoord >= pxcoord)&(sxcoord+width<=(pxcoord+16'd15))&(sycoord >= pycoord)&(sycoord+16'd9<=(pycoord+16'd15)) ))& sycoord+16'd9 < 16'd360 & FALL & frame;
    assign UP = (FALL & (frame | frame2)) & ~freeze;
    wire PLAYER, PINKSLUGPLAYER;
    assign PLAYER = ( ((pxcoord+16'd15) >= sxcoord)&((pxcoord)<=(sxcoord+width))&((pycoord)<=(sycoord+16'd9)));
    assign PINKSLUGPLAYER = ( ((pxcoord+16'd15) >= (sxcoord + {1'b0, width[15:1]} - 16'd4))&((pxcoord)<=(sxcoord + {1'b0, width[15:1]} + 16'd4))&((pycoord)<=(sycoord+16'd9)));
    assign NEXT_CHILL_BUT_REAL = (CHILL_BUT_REAL & ~btnC);
    assign NEXT_CHILL = (CHILL & ~exitchill) | (PLAYER_CONTACT & btnC) | (freeze & btnC) | (CHILL_BUT_REAL & btnC);
    assign NEXT_FALL = ((CHILL & exitchill & ~freeze) | (PINK_SLUG & ~PINKSLUGPLAYER & T3 & ~freeze) | (RECRUITED & T1 & ~freeze) | (FALL & (sycoord < 350) & ~PLAYER))&~(freeze & btnC);
    assign NEXT_PLAYER_CONTACT = ((FALL & PLAYER ) | (GROUND_CONTACT & PLAYER & ~T1) | (PLAYER_CONTACT & ~btnC))&~(freeze & btnC);
    assign NEXT_GROUND_CONTACT = ((FALL & ~PLAYER & sycoord == 16'd350) | (GROUND_CONTACT & ~T1 & ~PLAYER))&~(freeze & btnC);
    assign NEXT_PINK_SLUG = ((GROUND_CONTACT & T1 & ~PLAYER & ~freeze) | (PINK_SLUG & ~PINKSLUGPLAYER & ~T3))&~(freeze & btnC);
    assign NEXT_RECRUITED = ((PINK_SLUG & PINKSLUGPLAYER & ~T3 & ~freeze) | (RECRUITED & ~T1))&~(freeze & btnC);
    //assign NEXT_FROZEN = freeze;
    FDRE #(.INIT(1'b1)) FF_CHILL_BUT_REAL (.C(clk), .CE(1'b1), .D(NEXT_CHILL_BUT_REAL), .Q(CHILL_BUT_REAL));
    FDRE #(.INIT(1'b0)) FF_CHILL (.C(clk), .CE(1'b1), .D(NEXT_CHILL), .Q(CHILL));
	FDRE #(.INIT(1'b0)) FF_FALL (.C(clk), .CE(1'b1), .D(NEXT_FALL), .Q(FALL));
	FDRE #(.INIT(1'b0)) FF_PLAYER_CONTACT (.C(clk), .CE(1'b1), .D(NEXT_PLAYER_CONTACT), .Q(PLAYER_CONTACT));
	FDRE #(.INIT(1'b0)) FF_GROUND_CONTACT (.C(clk), .CE(1'b1), .D(NEXT_GROUND_CONTACT), .Q(GROUND_CONTACT));
	FDRE #(.INIT(1'b0)) FF_PINK_SLUG (.C(clk), .CE(1'b1), .D(NEXT_PINK_SLUG), .Q(PINK_SLUG));
	FDRE #(.INIT(1'b0)) FF_RECRUITED (.C(clk), .CE(1'b1), .D(NEXT_RECRUITED), .Q(RECRUITED));
	//FDRE #(.INIT(1'b0)) FF_FROZEN (.C(clk), .CE(1'b1), .D(NEXT_FROZEN), .Q(FROZEN));
	assign incsc = (PINK_SLUG & PINKSLUGPLAYER);
	assign resetsc = (PLAYER_CONTACT & btnC);
	assign rtimew = (FALL & ~PLAYER & sycoord == 16'd350) | (GROUND_CONTACT & T1) | (PINK_SLUG & PINKSLUGPLAYER & ~T3) | (PLAYER_CONTACT & btnC) | (PLAYER_CONTACT & T2) | (PINK_SLUG & ~PINKSLUGPLAYER & T3) | (RECRUITED & T1) | (freeze) | (CHILL & btnC) | (CHILL_BUT_REAL & btnC);
	assign resetY = (PINK_SLUG & T3) | (RECRUITED & T1) | (CHILL & exitchill) | (PLAYER_CONTACT & btnC) | (CHILL & btnC);
	assign loadtarget1 = (CHILL & exitchill) | (PINK_SLUG & T3) | (RECRUITED & T1);
	assign loadtarget2 = (CHILL & exitchill) | (PINK_SLUG & T3) | (RECRUITED & T1);
	assign resetp = (PLAYER_CONTACT & btnC);
	assign sy = sycoord;
	assign sx = sxcoord;
endmodule
