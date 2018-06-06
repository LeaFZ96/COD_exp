`timescale 1ns / 1ps

module Hazard(
    input RegWrite_EM,
    input RegWrite_MW,
    input MemRead_DE,
    input Overflow,
    input Break,
    input [4:0] WriteReg_EM,
    input [4:0] WriteReg_MW,
    input [4:0] RT_DE,
    input [4:0] RS_DE,
    input [4:0] RT_FD,
    input [4:0] RS_FD,
    output reg [1:0] PCSrc,
    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB,
    output reg flush,
    output reg Stall_PC,
    output reg Stall_FD
);

always@(*) begin
    ForwardA = 0;
    ForwardB = 0;
    Stall_FD = 0;
    Stall_PC = 0;
    flush = 0;
    PCSrc = 0;
    if(RegWrite_EM && (WriteReg_EM != 0)) begin    // EX hazard
        if(RS_DE == WriteReg_EM)
            ForwardA = 2'b10;
        if(RT_DE == WriteReg_EM)
            ForwardB = 2'b10;
    end
    if(RegWrite_MW && (WriteReg_MW != 0) && !(RegWrite_EM && (WriteReg_EM != 0))) begin   // MEM hazard
        if((RS_DE == WriteReg_MW) && (RS_DE != WriteReg_EM))
            ForwardA = 2'b01;
        if((RT_DE == WriteReg_MW) && (RT_DE != WriteReg_EM))
            ForwardB = 2'b01;
    end
    if(MemRead_DE && ((RT_DE == RS_FD) || (RT_DE == RT_FD))) begin
        Stall_FD = 1;
        Stall_PC = 1;
    end
    if(Overflow) begin
        PCSrc = 2'b11;
        Stall_PC = 1;
        flush = 1;
    end
    if(Break) begin
        PCSrc = 2'b11;
        Stall_PC = 1;
        flush = 1;
    end
end

endmodule