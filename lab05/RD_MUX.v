`timescale 1ns / 1ps

module RD_MUX(
    input RegDst,
    input [4:0] ins0,
    input [4:0] ins1,
    output reg [4:0] WriteReg
)

assign WriteReg = RegDst? ins0: ins1;
endmodule