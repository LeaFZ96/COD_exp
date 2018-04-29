`timescale 1ns / 1ps

module PC_Plus4(
    input [31:0] PC_in,
    output reg [31:0] PC_out
)

assign PC_out = PC_in + 4;

endmodule