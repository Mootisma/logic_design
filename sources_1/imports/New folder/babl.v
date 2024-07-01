`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2023 12:16:24 PM
// Design Name: 
// Module Name: Add8
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

//Build an 8-bit adder by first making a full adder module FA.
//Your full adder FA will have three inputs bits: a, b, Cin.
//It will have two outputs, s and Cout.
//Assemble 8 of your FA modules to make your 8-bit adder:
module Add8(
    input [7:0] A,
    input [7:0] B,
    input Cin,
    output [7:0] S,
    output Cout
    );
    wire [7:0] cr;
    FA a0 (.a(A[0]), .b(B[0]), .Cin(Cin), .s(S[0]), .Cout(cr[0]));
    FA a1 (.a(A[1]), .b(B[1]), .Cin(cr[0]), .s(S[1]), .Cout(cr[1]));
    FA a2 (.a(A[2]), .b(B[2]), .Cin(cr[1]), .s(S[2]), .Cout(cr[2]));
    FA a3 (.a(A[3]), .b(B[3]), .Cin(cr[2]), .s(S[3]), .Cout(cr[3]));
    FA a4 (.a(A[4]), .b(B[4]), .Cin(cr[3]), .s(S[4]), .Cout(cr[4]));
    FA a5 (.a(A[5]), .b(B[5]), .Cin(cr[4]), .s(S[5]), .Cout(cr[5]));
    FA a6 (.a(A[6]), .b(B[6]), .Cin(cr[5]), .s(S[6]), .Cout(cr[6]));
    FA a7 (.a(A[7]), .b(B[7]), .Cin(cr[6]), .s(S[7]), .Cout(Cout));
    //assign Cout = cr[7];
endmodule
