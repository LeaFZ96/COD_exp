`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:20:56 11/23/2017 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(
	input clk,
	input rst,
	input [3:0] addr_a,
	output [3:0] sel,
	output [7:0] data
);

wire wen_c;
wire [3:0] addr_c, addr_b;
wire [15:0] q_a, q_b, data_c;

regfile a(clk, rst, addr_a, addr_b, addr_c, data_c, wen_c, q_a, q_b);
inc b(clk, rst, q_b, addr_b, addr_c, data_c, wen_c);
seg c(clk, rst, q_a, sel, data);


endmodule