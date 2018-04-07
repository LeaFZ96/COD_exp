`timescale 1ns / 1ps
`include "regfile.v"
`include "alu.v"
`include "control.v"

module top(
	input clk,
	input rst_n
);

wire [31:0] r0, a, b, c;
wire [5:0] rAddr, wAddr;
wire wEna;

control con(clk, rst_n, r0, rAddr, wAddr, a, b, wEna);
regfile r(clk, rst_n, rAddr, r0, wAddr, c, wEna);
alu alu1(a, b, 5'h1, c);

endmodule