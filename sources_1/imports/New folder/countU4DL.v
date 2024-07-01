`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2023 12:10:27 PM
// Design Name: 
// Module Name: countU4DL
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


module countU4DL #(parameter [3:0] INIT = 4'd0)(
    //parameter [3:0] INIT = 4'd0;
    input clk,
    input Up,// button U , +1
    input Dw,// button D , -1
    input LD,
    input [3:0] Din,
    output [3:0] Q,
    output UTC,
    output DTC
    );  
    wire [3:0] O;
    //
    assign O[0] = (LD & Din[0]) | (~LD & ((Up & ~Dw & (Q[0] ^ Up)) | (~Up & Dw & (Q[0] ^ Dw))));
    assign O[1] = (LD&Din[1])|(~LD&( (Up&~Dw& (Q[1]^(Up&Q[0]) )) | (~Up&Dw& (Q[1]^(Dw&~Q[0])) ) ));
    assign O[2] = (LD&Din[2])|(~LD&( (Up&~Dw& (Q[2]^(Up&Q[1]&Q[0]) )) | (~Up&Dw& (Q[2]^(Dw&~Q[1]&~Q[0]) )) ));
    assign O[3] = (LD&Din[3])|(~LD&( (Up&~Dw& (Q[3]^(Up&Q[2]&Q[1]&Q[0]) )) | (~Up&Dw&(Q[3]^ (Dw&~Q[2]&~Q[1]&~Q[0]) )) ));
    assign UTC = &Q;
    assign DTC = ~|Q;
    FDRE #(.INIT(INIT[0])) Q0_FF (.C(clk), .CE(LD|Up|Dw), .D(O[0]), .Q(Q[0]));
    FDRE #(.INIT(INIT[1])) Q1_FF (.C(clk), .CE(LD|Up|Dw), .D(O[1]), .Q(Q[1]));
    FDRE #(.INIT(INIT[2])) Q2_FF (.C(clk), .CE(LD|Up|Dw), .D(O[2]), .Q(Q[2]));
    FDRE #(.INIT(INIT[3])) Q3_FF (.C(clk), .CE(LD|Up|Dw), .D(O[3]), .Q(Q[3]));
    
endmodule
