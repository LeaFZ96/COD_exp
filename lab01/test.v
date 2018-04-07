`timescale 1ns / 1ps
`include "top.v"

module test;
    reg [31:0] a;
    reg [31:0] b;
    wire [31:0] out;
    top uut (
        .a(a),
        .b(b),
        .out(out)
    );

    initial begin
		$dumpfile("test.vcd");
		$dumpvars;
        a = 0;
        b = 0;

        #100;
        a = 2;
        b = 2;
		#100;
		$finish;

    end
endmodule
