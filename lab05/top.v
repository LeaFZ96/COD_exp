`timescale 1ns / 1ps

module top(
	input clk,
	input rst_n
);

wire [31:0] Instr, PC, PCPlus4, PCBOut, PCNext, SrcA, SrcB, Result, RD2, Signimm, WriteData, ALUResult, ReadData;
wire [4:0] WriteReg;
wire [2:0] ALUControl;
wire Jump, MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, PCSrc, Zero;

Control Con(Instr[31:26], Instr[5:0], Jump, MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, ALUControl);
Ram InsMem(
	.addrb(PC), 
	.clkb(clk),
	.doutb(Instr)
);
RegFile Reg(clk, rst_n, RegWrite, Instr[25:21], Instr[20:16], WriteReg, Result, SrcA, RD2);
Ext E(Instr[15:0], Signimm);
ALU Alu(SrcA, SrcB, ALUControl, Zero, ALUResult);
Ram DataMem(
	.addrb(ALUResult),
	.clkb(clk),
	.doutb(ReadData)
);
PC Pc(clk, rst_n, PCNext, PC);
PC_BMUX PBMUX(PCSrc, PCPlus4, Signimm, PCBOut);
PC_JMUX PJMUX(Jump, PCPlus4[31:28], Instr[27:0], PCBOut, PCNext);
PC_Plus4 PCPlus(PC, PCPlus4);
BA_AND And(Branch, Zero, PCSrc);
MA_MUX MAMUX(MemtoReg, ALUResult, ReadData, Result);
RD_MUX RDMUX(RegDst, Instr[15:11], Instr[20:15], WriteReg);
RI_MUX RIMUX(ALUSrc, RD2, Signimm, SrcB);

endmodule