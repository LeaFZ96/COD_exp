`timescale 1ns / 1ps

module top2(
    input clk,
    input rst_n
);

wire [31:0] Instr, Data, ReadData, RD, RegOutA, RegOutB, RegIn, RegOut1, RegOut2, SignImm, SrcA, SrcB, ALUResult, ALUOut, PC, PCNext;
wire [5:0] Adr;
wire [4:0] WriteReg;
wire [2:0] ALUControl;
wire [1:0] PCSrc, ALUSrcB;
wire PCWrite, Branch, ALUSrcA, RegWrite, RegDst, Zero, MemtoReg, MemWrite, IRWrite, IorD, PCEn, ZBAnd;

assign ZBAnd = Branch & Zero;
assign PCEn = ZBAnd | PCWrite;

Control Con(clk, rst_n, Instr[31:26], Instr[5:0], MemtoReg, RegDst, IorD, PCSrc, ALUSrcA, ALUSrcB, IRWrite, MemWrite, PCWrite, Branch, RegWrite, ALUControl);

Ram2 Mem(
    .addra(Adr),
    .clka(clk),
    .wea(MemWrite),
    .dina(RegOutB),
    .douta(ReadData)
);

RegFile Reg(clk, rst_n, RegWrite, Instr[25:21], Instr[20:16], WriteReg, RegIn, RegOut1, RegOut2);

Ext E(Instr[15:0], SignImm);

ALU alu(SrcA, SrcB, ALUControl, Zero, ALUResult);

SrcB_MUX SBMUX(ALUSrcB, RegOutB, SignImm, SrcB);
MUX MA_MUX(MemtoReg, ReadData, ALUOut, RegIn);
MUX PA_MUX(ALUSrcA, RegOutA, PC, SrcA);
RD_MUX RDMUX(RegDst, Instr[20:16], Instr[15:11], WriteReg);
PC_MUX PCMUX(IorD, PC, ALUOut, Adr);
PC_JMUX PCJMUX(PCSrc, ALUResult, ALUOut, Instr[27:0], PC[31:28], PCNext);

pcc PCEN(clk, PCEn, PCNext, PC);
IR InsEN(IRWrite, ReadData, Instr);
CLK_EN RD1(clk, 1, RegOut1, RegOutA);
CLK_EN RD2(clk, 1, RegOut2, RegOutB);
CLK_EN ALUEN(clk, 1, ALUResult, ALUOut);

endmodule