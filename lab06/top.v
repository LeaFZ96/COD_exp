`timescale 1ns / 1ps

module top(
	input clk,
	input rst_n
);

wire [31:0] Instr, PC, PCPlus4, PCBOut, PCNext, SrcA, SrcB, Result, RD2, Signimm, ALUResult, ReadData;
wire [4:0] WriteReg, Add;
wire [2:0] ALUControl;
wire Jump, MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, PCSrc, Zero;

Control Con(Instr[31:26], Instr[5:0], Jump, MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, ALUControl);
Ram InsMem(
	.a(PC[4:0]), 
	.clk(clk),
	.we(1'b0),
	.d(32'b0),
	.spo(Instr)
);
RegFile Reg(
	.clk(clk), 
	.rst_n(rst_n), 
	.RegWrite(RegWrite), 
	.rAddr0(Instr[25:21]), 
	.rAddr1(Instr[20:16]), 
	.wAddr(WriteReg), 
	.wDin(Result), 
	.rDout0(SrcA), 
	.rDout1(RD2)
);
Ext E(Instr[15:0], Signimm);
ALU Alu(SrcA, SrcB, ALUControl, Zero, ALUResult);
DMMv MV(ALUResult[6:0], Add);
Ram1 DataMem(
	.a(Add),
	.clk(clk),
	.spo(ReadData),
	.we(MemWrite),
	.d(RD2)
);
PC Pc(clk, rst_n, PCNext, PC);
PC_BMUX PBMUX(PCSrc, PCPlus4, Signimm, PCBOut);
PC_JMUX PJMUX(Jump, PCPlus4[31:28], Instr[27:0], PCBOut, PCNext);
PC_Plus4 PCPlus(PC, PCPlus4);
BA_AND And(Branch, Zero, PCSrc);
MA_MUX MAMUX(MemtoReg, ALUResult, ReadData, Result);
RD_MUX RDMUX(RegDst, Instr[20:16], Instr[15:11], WriteReg);
RI_MUX RIMUX(ALUSrc, RD2, Signimm, SrcB);

endmodule