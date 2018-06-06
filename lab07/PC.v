`timescale 1ns / 1ps

module PC(
    input clk,
    input rst_n,
    input Stall,
    input [1:0] PCSrc,
    input [31:0] PCPlus4,
    input [31:0] PCJOut,
    input [31:0] PCBOut,
    output reg [31:0] PCNext
);

always@(posedge clk or negedge rst_n) begin
    if(~rst_n)
        PCNext <= 0;
    else if(~Stall) begin
        if(PCSrc == 2'b01)
            PCNext <= PCBOut;
        else if(PCSrc == 2'b10)
            PCNext <= PCJOut;
        else
            PCNext <= PCPlus4;
    end
end

endmodule