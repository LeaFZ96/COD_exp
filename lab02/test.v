`timescale 1ns / 1ps
`include "top.v"

module test;
	reg clk;
	reg rst_n;
	top uut (
		.clk(clk), 
		.rst_n(rst_n)
	);
	always #1 clk = ~clk;
	initial begin
		$dumpfile("test.vcd");
		$dumpvars;
		clk = 0;
		rst_n = 0;
		#2;
		rst_n = 1;
		repeat(500) @(posedge clk);
		$finish;
	end
endmodule

