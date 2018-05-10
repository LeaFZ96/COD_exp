`timescale 1ns / 1ps

module SrcB_MUX(
    input [1:0] ALUSrcB,
    input [31:0] RegData,
    input [31:0] ImmData,
    output reg [31:0] SrcB
);

always@(ALUSrcB) begin
    case(ALUSrcB)
        2'b00:
            SrcB = RegData;
        2'b01:
            SrcB = 32'd1;
        default:
            SrcB = ImmData;
    endcase
end

endmodule