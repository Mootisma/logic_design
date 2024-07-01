`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2023 12:43:58 PM
// Design Name: 
// Module Name: FA
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


module FA(
    input a,
    input b,
    input Cin,
    output s,
    output Cout
    );
    wire w1, w2, w3;
    HA HA_1 (.a(a), .b(b), .c(w1), .s(w2));
    HA HA_2 (.a(w2), .b(Cin), .c(w3), .s(s));
    assign Cout = w1 | w3;
endmodule
