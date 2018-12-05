`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2018 20:48:44
// Design Name: 
// Module Name: addbit
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


module addbit(a, b, ci, sum, co);

input a;
input b;
input ci;

output sum;
output co;

assign{co, sum} = a + b + ci;

endmodule
