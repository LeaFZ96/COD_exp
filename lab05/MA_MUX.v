`timescale 1ns / 1ps

module MA_MUX(
    input MemtoReg,
    input [31:0] ALUResult,
    input [31:0] ReadData,
    output reg [31:0] Result
)

assign Result = MemtoReg? ReadData: ALUResult;

endmodule