`timescale 1ns / 1ps

module test;

	// Inputs
	reg clk;
	reg rst_n;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.rst_n(rst_n)
	);
	always #1 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst_n = 0;

		// Wait 100 ns for global reset to finish
		#2;
		rst_n = 1;
		repeat(500) @(posedge clk);
		// Add stimulus here

	end
      
endmodule

