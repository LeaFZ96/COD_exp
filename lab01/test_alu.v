`timescale 1ns / 1ps
`include "alu.v"

module test;
    reg [31:0] a;
    reg [31:0] b;
    reg [4:0]  op;
    wire [31:0] out;
    alu uut (
        .alu_a(a),
        .alu_b(b),
        .alu_op(op),
        .alu_out(out)
    );

    initial begin
		$dumpfile("test_alu.vcd");
		$dumpvars;
        op = 0;
        a = 0;
        b = 0;
        #100;
        op = 0;
        a = 3;
        b = 2;
		#100;
        op = 1;
        a = 10;
        b = 7;
        #100;
        op = 2;
        a = 5;
        b = 8;
        #100;
        op = 3;
        a = 11;
        b = 19;
        #100;
        op = 4;
        a = 18;
        b = 23;
        #100;
        op = 5;
        a = 24;
        b = 16;
        #100;
        op = 6;
        a = 13;
        b = 31;
        #100;
		$finish;

    end
endmodule
