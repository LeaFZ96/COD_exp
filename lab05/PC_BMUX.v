`timescale 1ns / 1ps

module PC_BMUX(
    input PCSrc,
    input [31:0] PCPlus4,
    input [31:0] imm,
    output reg [31:0] PCNext
)

always@(*) begin
    if (PCSrc)
        PCNext = PCPlus4 + (4 * imm);
    else
        PCNext = PCPlus4;
end

endmodule