`timescale 1ns / 1ps

module top(
	input clk,
	input rst_n
);

wire [31:0] rrout, a, b, c, res, rwd;
wire [7:0] rradd, rwadd;
wire [5:0] wAddr;
wire [4:0] alu_op;
wire wEna;

control con(clk, rst_n, c, rrout, alu_op, rradd, rwadd, wAddr, a, b, rwd, res, rwe, wEna);
ram rr(
	.clka(clk),
	.addra(rwadd),
	.dina(res),
	.addrb(rradd), 
	.clkb(clk),
	.wea(rwe),
	.doutb(rrout)
);
regfile r(clk, rst_n, wAddr, rwd, wEna);
alu alu1(a, b, alu_op, c);

endmodule