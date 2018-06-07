`timescale 1ns / 1ps

module IF_ID(
    input clk,
    input rst_n,
    input flush,
    input stall,
    input [31:0] PCPlus4_IF,
    input [31:0] Instr_IF,
    output reg [31:0] PCPlus4_ID,
    output reg [31:0] Instr_ID
);

always@(posedge clk or negedge rst_n) begin
    if(~rst_n || flush) begin
        PCPlus4_ID <= 0;
        Instr_ID <= 0;
    end
    else if(~stall) begin
        PCPlus4_ID <= PCPlus4_IF;
        Instr_ID <= Instr_IF;
    end
end

endmodule