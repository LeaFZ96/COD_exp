`timescale 1ns / 1ps

module RI_MUX(
    input ALUSrc,
    input [31:0] RegData,
    input [31:0] ImmData,
    output [31:0] SrcB
);

assign SrcB = ALUSrc? ImmData: RegData;

endmodule