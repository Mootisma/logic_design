`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2023 06:51:13 PM
// Design Name: 
// Module Name: decoder4
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


module decoder4(
    input [3:0] D,
    output [15:0] C
    );
    wire [7:0] R;
//	decoder2 first (.Z(D[1:0]), .P(R[3:0]));
//	decoder2 second (.Z(D[3:2]), .P(R[7:4]));
//	assign C[0] = R[0] & R[4];
//	assign C[1] = R[0] & R[5];
//	assign C[2] = R[0] & R[6];
//	assign C[3] = R[0] & R[7];
//	assign C[4] = R[1] & R[4];
//	assign C[5] = R[1] & R[5];
//	assign C[6] = R[1] & R[6];
//	assign C[7] = R[1] & R[7];
//	assign C[8] = R[2] & R[4];
//	assign C[9] = R[2] & R[5];
//	assign C[10] = R[2] & R[6];
//	assign C[11] = R[2] & R[7];
//	assign C[12] = R[3] & R[4];
//	assign C[13] = R[3] & R[5];
//	assign C[14] = R[3] & R[6];
//	assign C[15] = R[3] & R[7];
    assign C[0] = ~D[0] & ~D[1] & ~D[2] & ~D[3];//0000
    assign C[1] = D[0] & ~D[1] & ~D[2] & ~D[3];//1000
    assign C[2] = ~D[0] & D[1] & ~D[2] & ~D[3];//0100
    assign C[3] = D[0] & D[1] & ~D[2] & ~D[3];//1100
    assign C[4] = ~D[0] & ~D[1] & D[2] & ~D[3];//0010
    assign C[5] = D[0] & ~D[1] & D[2] & ~D[3];//1010
    assign C[6] = ~D[0] & D[1] & D[2] & ~D[3];//0110
    assign C[7] = D[0] & D[1] & D[2] & ~D[3];//1110
    assign C[8] = ~D[0] & ~D[1] & ~D[2] & D[3];//0001
    assign C[9] = D[0] & ~D[1] & ~D[2] & D[3];//1001
    assign C[10] = ~D[0] & D[1] & ~D[2] & D[3];//0101
    assign C[11] = D[0] & D[1] & ~D[2] & D[3];//1101
    assign C[12] = ~D[0] & ~D[1] & D[2] & D[3];//0011
    assign C[13] = D[0] & ~D[1] & D[2] & D[3];//1011
    assign C[14] = ~D[0] & D[1] & D[2] & D[3];//0111
    assign C[15] = D[0] & D[1] & D[2] & D[3];//1111
endmodule
