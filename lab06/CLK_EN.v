`timescale 1ns / 1ps

module CLK_EN(
    input clk,
    input EN,
    input [31:0] din,
    output reg [31:0] dout
);

initial begin
dout = 0;
end

always@(posedge clk) begin
    if (EN)
        dout <= din;
    else
        dout <= dout;
end

endmodule