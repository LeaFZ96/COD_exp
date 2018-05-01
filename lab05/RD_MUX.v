`timescale 1ns / 1ps

module RD_MUX(
    input RegDst,
    input [4:0] ins0,
    input [4:0] ins1,
    output [4:0] WriteReg
);

assign WriteReg = RegDst? ins1: ins0;

endmodule