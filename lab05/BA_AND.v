`timescale 1ns / 1ps

module BA_AND(
    input Branch,
    input Zero,
    output reg PCSrc
)

assign PCSrc = Branch & Zero;

endmodule