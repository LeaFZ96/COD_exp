`timescale 1ns / 1ps
`include "regfile.v"
`include "alu.v"
`include "control.v"

module top(
	input clk,
	input rst_n
);

wire [31:0] rrout, a, b, c;
wire [5:0] rradd, wAddr;
wire wEna;

control con(clk, rst_n, c, rrout, rradd, rwadd, wAddr, a, b, res, rwe, wEna);
ram rr(rwadd, res, rradd, clk, rwe, rrout);
regfile r(clk, rst_n, wAddr, res, wEna);
alu alu1(a, b, 5'h1, c);

endmodule