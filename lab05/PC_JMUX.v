`timescale 1ns / 1ps

module PC_JMUX(
    input Jump,
    input [3:0] PCPlus4,
    input [27:0] ins,
    input [31:0] PC_BMUX,
    output reg [31:0] PC_out
);

reg [27:0] temp;

always@(*) begin
    if (Jump) begin
        temp = ins;
        PC_out[27:0] = temp;
        PC_out[31:28] = PCPlus4;
    end
    else
        PC_out = PC_BMUX;
end

endmodule