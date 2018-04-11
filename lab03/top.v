`timescale 1ns / 1ps

module top(
	input clk,
	input rst_n
);

wire [31:0] rrout, a, b, c, res;
wire [5:0] rradd, wAddr, rwadd;
wire wEna;

control con(clk, rst_n, c, rrout, rradd, rwadd, wAddr, a, b, res, rwe, wEna);
ram rr(
	.clka(clk),
	.addra(rwadd),
	.dina(res),
	.addrb(rradd), 
	.clkb(clk),
	.wea(rwe),
	.doutb(rrout)
);
regfile r(clk, rst_n, wAddr, res, wEna);
alu alu1(a, b, 5'h1, c);

endmodule