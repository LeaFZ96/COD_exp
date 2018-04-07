`timescale 1ns / 1ps
`include "alu.v"

module top(
  input signed  [31:0] a,
  input signed  [31:0] b,
  output        [31:0] out
);

wire [31:0] temp1, temp2, temp3;

alu alu1(a, b, 5'h1, temp1);
alu alu2(b, temp1, 5'h1, temp2);
alu alu3(temp1, temp2, 5'h1, temp3);
alu alu4(temp2, temp3, 5'h1, out);

endmodule // top
