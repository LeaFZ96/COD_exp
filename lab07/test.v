`timescale 1ns / 1ps

module t;

	// Inputs
	reg clk;
	reg rst_n;
	reg brk;
	reg cont;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk),
		.rst_n(rst_n),
		.brk(brk),
		.cont(cont)
	);
	always #2 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst_n = 0;
		brk = 0;
		cont = 0;

		// Wait 100 ns for global reset to finish
		#1;
		rst_n = 1;
		
		#100;
		brk = 1;
		#4;
		brk = 0;
		#40;
		cont = 1;
		#4;
		cont = 0;
		
        
		// Add stimulus here

	end
      
endmodule

