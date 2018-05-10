`timescale 1ns / 1ps

module pcc(
    input clk,
    input EN,
    input [31:0] din,
    output reg [31:0] dout
);

initial begin
dout = -1;
end

always@(posedge clk) begin
    if (EN)
        dout <= din;
    else
        dout <= dout;
end

endmodule