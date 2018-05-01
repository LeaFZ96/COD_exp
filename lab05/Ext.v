`timescale 1ns / 1ps

module Ext(
    input [15:0] imm_in,
    output [31:0] imm_out
);

assign imm_out[15:0] = imm_in;
assign imm_out[31:16] = imm_in[15]? 16'hffff: 16'h0000;

endmodule