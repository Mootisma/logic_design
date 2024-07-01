`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2/26/2023
// Design Name: 
// Module Name: topL6W23
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
module topL6W23(
	input clkin,
	input btnC,
	input btnD,
	input btnU,
	input btnL,
	input btnR,
	input [15:0] sw,
	output dp,
	output [3:0] an,
	output [15:0] led,
	output [6:0] seg,
	output Hsync,
	output Vsync,
	output [3:0] vgaRed,
	output [3:0] vgaBlue,
	output [3:0] vgaGreen
	);
	// rgb low outside the active region
	wire frame, frame2, clk, digsel;
	wire [15:0] xw, yw;
	labVGA_clks not_so_slow (.clkin(clkin), .greset(btnU), .clk(clk), .digsel(digsel));
	// button stabilizers
	wire BetOnC, BetOnYou, Buttonelle, Buttonnaire, ButAndy;
	FDRE BTNC_FF (.C(clk), .CE(1'b1), .D(btnC), .Q(BetOnC));
	FDRE BTNU_FF (.C(clk), .CE(1'b1), .D(btnU), .Q(BetOnYou));
	FDRE BTNL_FF (.C(clk), .CE(1'b1), .D(btnL), .Q(Buttonelle));
	FDRE BTNR_FF (.C(clk), .CE(1'b1), .D(btnR), .Q(Buttonnaire));
	FDRE BTND_FF (.C(clk), .CE(1'b1), .D(btnD), .Q(ButAndy));
	//
	//
	pixels icantuseemojis (.clk(clk), .xcoord(xw), .ycoord(yw));
	sync icantusesymbols (.clk(clk), .xcoord(xw), .ycoord(yw), .Hsync(Hsync), .Vsync(Vsync), .frame(frame), .frame2(frame2));
	//
	wire CHILL1, game, RECRUITED1, PINK_SLUG1, resetp, FROZEN1;//CHILL
	wire CHILL2, RECRUITED2, PINK_SLUG2, resetp2, FROZEN2;
	wire CHILL3, RECRUITED3, PINK_SLUG3, resetp3, FROZEN3;
	wire CHILL4, RECRUITED4, PINK_SLUG4, resetp4, FROZEN4;
	wire CHILL5, RECRUITED5, PINK_SLUG5, resetp5, FROZEN5;
	wire s2f, s3f, s4f, s5f, s1f;
	assign game = s1f | s2f | s3f | s4f | s5f;
	wire [15:0] px, py;
	player_state ddddd (.btnL(Buttonelle), .btnR(Buttonnaire), .btnD(ButAndy), .game(game), .resetp(resetp | resetp2 | resetp3 | resetp4 | resetp5), .clk(clk), .frame(frame), .px(px), .py(py));
	//
	//
	//time counter state machine input
	wire [15:0] timer1w, timer2w, timer3w, timer4w, timer5w;//60 frames is 1 second
	wire rtimew, rtime2w, rtime3w, rtime4w, rtime5w, T11, T31, T21, T41, T51, T12, T32, T22, T42, T52, T13, T33, T23, T43, T53, T14, T34, T24, T44, T54, T15, T35, T25, T45, T55, T115;
	//TimeCounter BTR (.Inc(frame), .R(rtimew), .clk(clk), .Q(timew));
	wire [5:0] utcc, dtcc;
	counterUD16L #(.INIT(16'd0)) Timer1 (.Up(frame), .Dw(1'b0), .clk(clk), .LD(rtimew), .Din(16'd0), .Q(timer1w), .UTC(utcc[0]), .DTC(dtcc[0]));
	//assign T_HALF = timer1w == 16'd30;
	assign T11 = timer1w == 16'd60;//T1
	assign T115 = timer1w >= 16'd64;
	assign T21 = timer1w == 16'd120;
	assign T31 = timer1w == 16'd180;
	assign T41 = timer1w == 16'd240;
	assign T51 = timer1w == 16'd300;
	counterUD16L #(.INIT(16'd0)) Timer2 (.Up(frame), .Dw(1'b0), .clk(clk), .LD(rtime2w), .Din(16'd0), .Q(timer2w), .UTC(utcc[1]), .DTC(dtcc[1]));
	counterUD16L #(.INIT(16'd0)) Timer3 (.Up(frame), .Dw(1'b0), .clk(clk), .LD(rtime3w), .Din(16'd0), .Q(timer3w), .UTC(utcc[2]), .DTC(dtcc[2]));
	counterUD16L #(.INIT(16'd0)) Timer4 (.Up(frame), .Dw(1'b0), .clk(clk), .LD(rtime4w), .Din(16'd0), .Q(timer4w), .UTC(utcc[3]), .DTC(dtcc[3]));
	counterUD16L #(.INIT(16'd0)) Timer5 (.Up(frame), .Dw(1'b0), .clk(clk), .LD(rtime5w), .Din(16'd0), .Q(timer5w), .UTC(utcc[4]), .DTC(dtcc[4]));
	//
	assign T13 = timer3w == 16'd60;//T1
	assign T23 = timer3w == 16'd120;
	assign T33 = timer3w == 16'd180;
	//assign T43 = timer3w == 16'd240;
	//assign T53 = timer3w == 16'd300;
	assign T14 = timer4w == 16'd60;//T1
	assign T24 = timer4w == 16'd120;
	assign T34 = timer4w == 16'd180;
	assign T44 = timer4w >= 16'd240;
	//assign T54 = timer4w == 16'd300;
	assign T15 = timer5w == 16'd60;//T1
	assign T25 = timer5w == 16'd120;
	assign T35 = timer5w == 16'd180;
	//assign T45 = timer5w == 16'd240;
	assign T55 = timer5w >= 16'd300;
	assign T12 = timer2w == 16'd60;//T1
	assign T22 = timer2w == 16'd120;
	assign T32 = timer2w == 16'd180;
	//assign T42 = timer2w == 16'd240;
	//assign T52 = timer2w == 16'd300;
	//
	// score counter
	wire incsc, resetsc, incsc2, resetsc2, incsc3, resetsc3, incsc4, resetsc4, incsc5, resetsc5;
	wire [15:0] score, selectoroutput;
	counterUD16L #(.INIT(16'd0)) SCORE (.Up(incsc | incsc2 | incsc3 | incsc4 | incsc5), .clk(clk), .LD(resetsc | resetsc2 | resetsc3 | resetsc4 | resetsc5), .Din(16'd0), .Q(score));
	//
	wire [7:0] lfsrout;
	LFSR hi2 (.clk(clk), .rnd(lfsrout));
	// +1, shift 5 left
	//
	wire [3:0] width, position, width2, position2, width3, position3, width4, position4, width5, position5;
	wire loadtarget1w, loadtarget2w, loadtarget1w2, loadtarget2w2, loadtarget1w3, loadtarget2w3, loadtarget1w4, loadtarget2w4, loadtarget1w5, loadtarget2w5;
	target walmart (.D(lfsrout[3:0]), .CE(loadtarget1w), .clk(clk), .Q(width));
	target walmart2 (.D(lfsrout[3:0]), .CE(loadtarget1w2), .clk(clk), .Q(width2));
	target walmart3 (.D(lfsrout[3:0]), .CE(loadtarget1w3), .clk(clk), .Q(width3));
	target walmart4 (.D(lfsrout[7:4]), .CE(loadtarget1w4), .clk(clk), .Q(width4));
	target walmart5 (.D(lfsrout[3:0]), .CE(loadtarget1w5), .clk(clk), .Q(width5));
	target depot (.D(lfsrout[7:4]), .CE(loadtarget2w), .clk(clk), .Q(position));
	target depot2 (.D(lfsrout[7:4]), .CE(loadtarget2w2), .clk(clk), .Q(position2));
	target depot3 (.D(lfsrout[7:4]), .CE(loadtarget2w3), .clk(clk), .Q(position3));
	target depot4 (.D(lfsrout[3:0]), .CE(loadtarget2w4), .clk(clk), .Q(position4));
	target depot5 (.D(lfsrout[7:4]), .CE(loadtarget2w5), .clk(clk), .Q(position5));
	wire [15:0] lfsrwidth, lfsrposition, lfsrwidth2, lfsrposition2, lfsrwidth3, lfsrposition3, lfsrwidth4, lfsrposition4, lfsrwidth5, lfsrposition5;
	wire [2:0] fart, fart2, fart3, fart4, fart5;
	assign fart = 3'd0 + width[1:0] + 3'd1;
	assign lfsrwidth = {8'b0, fart, 5'b0};
	assign lfsrposition = {7'b0, position[3:0], 5'b0} + 16'd12;
	//
	assign fart2 = 3'd0 + width2[1:0] + 3'd1;
	assign lfsrwidth2 = {8'b0, fart2, 5'b0};
	assign lfsrposition2 = {7'b0, position2[3:0], 5'b0} + 16'd12;
	//
	assign fart3 = 3'd0 + width3[1:0] + 3'd1;
	assign lfsrwidth3 = {8'b0, fart3, 5'b0};
	assign lfsrposition3 = {7'b0, position3[3:0], 5'b0} + 16'd12;
	//
	assign fart4 = 3'd0 + width4[1:0] + 3'd1;
	assign lfsrwidth4 = {8'b0, fart4, 5'b0};
	assign lfsrposition4 = {7'b0, position4[3:0], 5'b0} + 16'd12;
	//
	assign fart5 = 3'd0 + width5[1:0] + 3'd1;
	assign lfsrwidth5 = {8'b0, fart5, 5'b0};
	assign lfsrposition5 = {7'b0, position5[3:0], 5'b0} + 16'd12;
	//
	//
	
	//
	wire [15:0] sy, sx,  sy2, sx2,  sy3, sx3,  sy4, sx4,  sy5, sx5;
	wire CHILL_BUT_REAL, CHILL_BUT_REAL2, CHILL_BUT_REAL3, CHILL_BUT_REAL4, CHILL_BUT_REAL5;
	ship_state ship1 (.freeze(s2f| s3f| s4f| s5f), .exitchill(T115), .pxcoord(px), .pycoord(py), .clk(clk), .frame(frame), .frame2(frame2), .T1(T11), .T2(T21), .T3(T31), .btnC(BetOnC), .width(lfsrwidth), .position(lfsrposition), .sx(sx), .sy(sy), .rtimew(rtimew), .incsc(incsc), .resetsc(resetsc), .loadtarget1(loadtarget1w), .loadtarget2(loadtarget2w), .resetp(resetp), .CHILL(CHILL1), .PLAYER_CONTACT(s1f), .PINK_SLUG(PINK_SLUG1), .RECRUITED(RECRUITED1), .CHILL_BUT_REAL(CHILL_BUT_REAL) /*, .FROZEN(FROZEN1)*/ );
	ship_state ship2 (.freeze(s1f| s3f| s4f| s5f), .exitchill(T22), .pxcoord(px), .pycoord(py), .clk(clk), .frame(frame), .frame2(frame2), .T1(T12), .T2(T22), .T3(T32), .btnC(BetOnC), .width(lfsrwidth2), .position(lfsrposition2), .sx(sx2), .sy(sy2), .rtimew(rtime2w), .incsc(incsc2), .resetsc(resetsc2), .loadtarget1(loadtarget1w2), .loadtarget2(loadtarget2w2), .resetp(resetp2), .CHILL(CHILL2), .PLAYER_CONTACT(s2f), .PINK_SLUG(PINK_SLUG2), .RECRUITED(RECRUITED2), .CHILL_BUT_REAL(CHILL_BUT_REAL2)/*, .FROZEN(FROZEN1)*/ );
	ship_state ship3 (.freeze(s2f| s1f| s4f| s5f), .exitchill(T33), .pxcoord(px), .pycoord(py), .clk(clk), .frame(frame), .frame2(frame2), .T1(T13), .T2(T23), .T3(T33), .btnC(BetOnC), .width(lfsrwidth3), .position(lfsrposition3), .sx(sx3), .sy(sy3), .rtimew(rtime3w), .incsc(incsc3), .resetsc(resetsc3), .loadtarget1(loadtarget1w3), .loadtarget2(loadtarget2w3), .resetp(resetp3), .CHILL(CHILL3), .PLAYER_CONTACT(s3f), .PINK_SLUG(PINK_SLUG3), .RECRUITED(RECRUITED3), .CHILL_BUT_REAL(CHILL_BUT_REAL3)/*, .FROZEN(FROZEN1)*/ );
	ship_state ship4 (.freeze(s2f| s3f| s1f| s5f), .exitchill(T44), .pxcoord(px), .pycoord(py), .clk(clk), .frame(frame), .frame2(frame2), .T1(T14), .T2(T24), .T3(T34), .btnC(BetOnC), .width(lfsrwidth4), .position(lfsrposition4), .sx(sx4), .sy(sy4), .rtimew(rtime4w), .incsc(incsc4), .resetsc(resetsc4), .loadtarget1(loadtarget1w4), .loadtarget2(loadtarget2w4), .resetp(resetp4), .CHILL(CHILL4), .PLAYER_CONTACT(s4f), .PINK_SLUG(PINK_SLUG4), .RECRUITED(RECRUITED4), .CHILL_BUT_REAL(CHILL_BUT_REAL4)/*, .FROZEN(FROZEN1)*/ );
	ship_state ship5 (.freeze(s2f| s3f| s4f| s1f), .exitchill(T55), .pxcoord(px), .pycoord(py), .clk(clk), .frame(frame), .frame2(frame2), .T1(T15), .T2(T25), .T3(T35), .btnC(BetOnC), .width(lfsrwidth5), .position(lfsrposition5), .sx(sx5), .sy(sy5), .rtimew(rtime5w), .incsc(incsc5), .resetsc(resetsc5), .loadtarget1(loadtarget1w5), .loadtarget2(loadtarget2w5), .resetp(resetp5), .CHILL(CHILL5), .PLAYER_CONTACT(s5f), .PINK_SLUG(PINK_SLUG5), .RECRUITED(RECRUITED5), .CHILL_BUT_REAL(CHILL_BUT_REAL5)/*, .FROZEN(FROZEN1)*/ );
	//
	/*assign led[0] = CHILL1;
	assign led[1] = CHILL2;
	assign led[2] = CHILL3;
	assign led[3] = CHILL4;
	assign led[4] = CHILL5;
	assign led[5] = (s1f);
	assign led[6] = (s2f);
	assign led[7] = (s3f);
	assign led[8] = (s4f);
	assign led[9] = (s5f);
	assign led[10] = PINK_SLUG1;
	assign led[11] = PINK_SLUG2;
	assign led[12] = PINK_SLUG3;
	assign led[13] = PINK_SLUG4;
	assign led[14] = PINK_SLUG5;*/
	
	//.sxcoord(sx), .sycoord(sy), .width(lfsrwidth), .CHILL(CHILL), .PINK_SLUG(PINK_SLUG), .RECRUITED(RECRUITED), .flash(timer1w[6]), .flash2(timer1w[5]), .flash3(timer1w[4]), 
	VGA ldgfkj (.sxcoord1(sx), .sycoord1(sy), .width1(lfsrwidth), .CHILL1(CHILL1), .PINK_SLUG1(PINK_SLUG1), .RECRUITED1(RECRUITED1), /*.flash1(timer1w[6]), */.flash21(timer1w[5]), .flash31(timer1w[4]), .sxcoord2(sx2), .sycoord2(sy2), .width2(lfsrwidth2), .CHILL2(CHILL2), .PINK_SLUG2(PINK_SLUG2), .RECRUITED2(RECRUITED2), /*.flash2(timer2w[6]), */.flash22(timer2w[5]), .flash32(timer2w[4]), .sxcoord3(sx3), .sycoord3(sy3), .width3(lfsrwidth3), .CHILL3(CHILL3), .PINK_SLUG3(PINK_SLUG3), .RECRUITED3(RECRUITED3), /*.flash3(timer3w[6]), */.flash23(timer3w[5]), .flash33(timer3w[4]), .sxcoord4(sx4), .sycoord4(sy4), .width4(lfsrwidth4), .CHILL4(CHILL4), .PINK_SLUG4(PINK_SLUG4), .RECRUITED4(RECRUITED4), /*.flash4(timer4w[6]), */.flash24(timer4w[5]), .flash34(timer4w[4]), .sxcoord5(sx5), .sycoord5(sy5), .width5(lfsrwidth5), .CHILL5(CHILL5), .PINK_SLUG5(PINK_SLUG5), .RECRUITED5(RECRUITED5),/* .flash5(timer5w[6]),*/ .flash25(timer5w[5]), .flash35(timer5w[4]), .s1f(s1f), .s2f(s2f), .s3f(s3f), .s4f(s4f), .s5f(s5f), .CHILL_BUT_REAL(CHILL_BUT_REAL), .CHILL_BUT_REAL2(CHILL_BUT_REAL2), .CHILL_BUT_REAL3(CHILL_BUT_REAL3), .CHILL_BUT_REAL4(CHILL_BUT_REAL4), .CHILL_BUT_REAL5(CHILL_BUT_REAL5), /* .FROZEN1(FROZEN1), .FROZEN2(FROZEN2), .FROZEN3(FROZEN3), .FROZEN4(FROZEN4), .FROZEN5(FROZEN5),*/ .game(game), .pxcoord(px), .pycoord(py), .xcoord(xw), .ycoord(yw), .vgaRed(vgaRed), .vgaBlue(vgaBlue), .vgaGreen(vgaGreen) );
	//
	assign an[3] = 1'b1;
	assign an[2] = 1'b1;
	assign dp = 1'b1;
	//
	wire [3:0] ringcountout;
	RingCounter pick (.Advance(digsel), .clk(clk), .Q(ringcountout));
	//wire [15:0] selectorinput;
	//assign selectorinput = {dcin, 4'b0000, P1Score, P2Score};
	Selector baba (.N(score), .sel(ringcountout), .H(selectoroutput));
	hex7seg booie (.n(selectoroutput), .seg(seg));
	assign an[1] = ~ringcountout[1];
	assign an[0] = ~ringcountout[0];
endmodule
