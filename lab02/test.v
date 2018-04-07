`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:38:25 11/29/2017
// Design Name:   top
// Module Name:   E:/Course/exp/lab06/test.v
// Project Name:  lab06
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg clk;
	reg rst;
	reg [3:0] addr_a;

	// Outputs
	wire [3:0] sel;
	wire [7:0] data;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.rst(rst), 
		.addr_a(addr_a), 
		.sel(sel), 
		.data(data)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		#1;
		rst = 1;
		#1;
		rst = 0;
		addr_a = 0;

		// Wait 100 ns for global reset to finish
		#100;
        addr_a = 4'b1010;
		// Add stimulus here

	end
	always #1 clk = ~clk;
      
endmodule

