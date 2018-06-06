`timescale 1ns / 1ps

module IR(
	input IRWrite,
	input [31:0] a,
	output reg [31:0] b
    );

always@(*)
	if (IRWrite)
		b = a;

endmodule