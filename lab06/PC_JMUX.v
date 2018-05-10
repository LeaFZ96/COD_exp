`timescale 1ns / 1ps

module PC_JMUX(
    input [1:0] PCSrc,
    input [31:0] ALUResult,
    input [31:0] ALUOut,
    input [27:0] Ins,
    input [3:0] PC,
    output reg [31:0] PCNext
);

always@(*) begin
    if (PCSrc == 2'b00)
        PCNext = ALUResult;
    else if (PCSrc == 2'b01)
        PCNext = ALUOut;
    else if (PCSrc == 2'b10) begin
        PCNext[25:0] = Ins[25:0];
        PCNext[31:28] = PC;
    end
end

endmodule