`timescale 1ns / 1ps

module PC_MUX(
    input IorD,
    input [31:0] PC,
    input [31:0] Data,
    output reg [5:0] Addr
);

always@(*) begin
    if (IorD)
        Addr = Data[7:0] >> 2;
    else
        Addr = PC[5:0];
end

endmodule