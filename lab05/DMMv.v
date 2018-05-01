`timescale 1ns / 1ps

module DMMv(
	input [6:0] ALUResult,
	output [4:0] Add
    );

assign Add = ALUResult >> 2;

endmodule
