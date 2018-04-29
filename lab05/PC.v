`timescale 1ns / 1ps

module PC(
    input clk,
    input rst_n,
    input [31:0] PC_in,
    output reg [31:0] PC_out
)

always@(posedge clk or negedge rst_n) begin
    if (~rst_n)
        PC_out <= 0;
    else
        PC_out <= PC_in;
end

endmodule