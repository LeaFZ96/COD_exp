`timescale 1ns / 1ps

module top(
	input clk,
	input rst_n,
	input break,
	input continue
);

wire [31:0] Instr_IF, Instr_ID;
wire [31:0] PC, PCPlus4_IF, PCPlus4_ID;
wire [31:0] PCBOut_EX, PCBOut_MEM, PCJOut, PCNext;
wire [31:0] ReadRs_ID, ReadRs_EX;
wire [31:0] ReadRt_ID, ReadRt_EX, ReadRt_MEM;
wire [31:0] ReadData_MEM, ReadData_WB;
wire [31:0] Signimm_ID, Signimm_EX;
wire [31:0] ALUOut_EX, ALUOut_MEM, ALUOut_WB;
wire [31:0] ALUSrcA, ALUSrcB;
wire [31:0] WriteData_WB;

wire [4:0] RS_EX, RT_EX, RD_EX;
wire [4:0] WriteReg_EX, WriteReg_MEM, WriteReg_WB;

wire [3:0] ALUControl_ID, ALUControl_EX;
wire [2:0] BranchSt_ID, BranchSt_EX;
wire [1:0] ForwardA, ForwardB;
wire [1:0] PCSrc;
wire [1:0] ALUOF_ID, ALUOF_EX;

wire flush, Stall_PC, Stall_FD, Jump, JumpR;

wire MemtoReg_ID, MemtoReg_EX, MemtoReg_MEM, MemtoReg_WB;
wire MemWrite_ID, MemWrite_EX, MemWrite_MEM;
wire MemRead_ID, MemRead_EX, MemRead_MEM;
wire Branch_ID, Branch_EX, Branch_MEM;
wire ALUSrc_ID, ALUSrc_EX;
wire RegDst_ID, RegDst_EX;
wire RegWrite_ID, RegWrite_EX, RegWrite_MEM, RegWrite_WB;
wire Zero_EX, Zero_MEM, B_Zero;
wire Overflow_EX, Overflow_MEM, Overflow_WB;


Hazard hazard(
    .RegWrite_EM(RegWrite_MEM),
    .RegWrite_MW(RegWrite_WB),
    .MemRead_DE(MemRead_EX),
	.Break(break),
	.Overflow(Overflow_WB),
    .WriteReg_EM(WriteReg_MEM),
    .WriteReg_MW(WriteReg_WB),
    .RT_DE(RT_EX),
    .RS_DE(RS_EX),
    .RT_FD(RT_ID),
    .RS_FD(RS_ID),
	.PCSrc(PCSrc)
    .ForwardA(ForwardA),
    .ForwardB(ForwardB),
	.flush(flush),
    .Stall_PC(Stall_PC),
    .Stall_FD(Stall_FD)
);

// 	IF
PC Pc(
	.clk(clk), 
	.rst_n(rst_n),
	.Stall(Stall_PC),
	.Continue(continue),
	.PCSrc(PCSrc),
	.PCPlus4(PCPlus4_IF),
	.PCJOut(PCJOut),
	.PCBOut(PCBOut_MEM),
	.PCNext(PCNext)
);

PC_Plus4 PCPlus(PC, PCPlus4_IF);

IF_ID FD(
	.clk(clk),
	.rst_n(rst_n),
	.flush(flush),
	.stall(Stall_FD),
	.PCPlus4_IF(PCPlus4_IF),
	.Instr_IF(Instr_IF),
	.PCPlus4_ID(PCPlus4_ID),
	.Instr_ID(Instr_ID)
);

//	ID
Control Con(
	.opcode(Instr_ID[31:26]), 
	.funct(Instr_ID[5:0]), 
	.RD(Instr_ID[20:16]),
	.Jump(Jump), 
	.JumpR(JumpR),
	.MemtoReg(MemtoReg_ID), 
	.MemWrite(MemWrite_ID), 
	.MemRead(MemRead_ID),
	.Branch(Branch_ID), 
	.ALUSrc(ALUSrc_ID), 
	.RegDst(RegDst_ID), 
	.RegWrite(RegWrite_ID), 
	.ALUOF(ALUOF_ID),
	.BranchSt(BranchSt_ID),
	.ALUControl(ALUControl_ID)
);

PC_JMUX PCJ(
	.Jump(Jump),
	.JumpR(JumpR),
	.PCPlus4(PCPlus4_ID),
	.Instr(Instr_ID[25:0]),
	.ReadRs_ID(ReadRs_ID),
	.PCSrc(PCSrc),
	.PCJOut(PCJOut)
);

RegFile Reg(
	.clk(clk), 
	.rst_n(rst_n), 
	.RegWrite(RegWrite_WB), 
	.rAddr0(Instr_ID[25:21]), 
	.rAddr1(Instr_ID[20:16]), 
	.wAddr(WriteReg_WB), 
	.wDin(WriteData_WB), 
	.rDout0(ReadRs_ID), 
	.rDout1(ReadRt_ID)
);

Ext E(Instr_ID[15:0], Signimm_ID);

ID_EX DE(
	.clk(clk),
	.rst_n(rst_n),
	.flush(flush),
	.MemtoReg_ID(MemtoReg_ID),
	.MemWrite_ID(MemWrite_ID),
	.MemRead_ID(MemRead_ID),
	.Branch_ID(Branch_ID),
	.ALUSrc_ID(ALUSrc_ID),
	.RegDst_ID(RegDst_ID),
	.RegWrite_ID(RegWrite_ID),
	.ALUOF_ID(ALUOF_ID),
	.BranchSt_ID(BranchSt_ID),
	.ALUControl_ID(ALUControl_ID),
	.PCPlus4_ID(PCPlus4_ID),
	.ReadRs_ID(ReadRs_ID),
	.ReadRt_ID(ReadRt_ID),
	.Signimm_ID(Signimm_ID),
	.RS_ID(Instr_ID[25:21]),
	.RT_ID(Instr_ID[20:16]),
	.RD_ID(Instr_ID[15:11]),
	.MemtoReg_EX(MemtoReg_EX),
	.MemWrite_EX(MemWrite_EX),
	.MemRead_EX(MemRead_EX),
	.Branch_EX(Branch_EX),
	.ALUSrc_EX(ALUSrc_EX),
	.RegDst_EX(RegDst_EX),
	.ALUOF_EX(ALUOF_EX),
	.RegWrite_EX(RegWrite_EX),
	.BranchSt_EX(BranchSt_EX),
	.ALUControl_EX(ALUControl_EX),
	.PCPlus4_EX(PCPlus4_EX),
	.ReadRs_EX(ReadRs_EX),
	.ReadRt_EX(ReadRt_EX),
	.Signimm_EX(Signimm_EX),
	.RS_EX(RS_EX),
	.RT_EX(RT_EX),
	.RD_EX(RD_EX)
);

//	EX
MUX alumux(
	.data0(ReadRt_EX),
	.data1(Signimm_EX),
	.ctrl(ALUSrc_EX),
	.dataout(ALUInB)
);

ForwardMUX fmuxa(
	.ALUSec(ForwardA),
	.ALU_DE(ReadRs_EX),
	.ALU_EM(ALUOut_MEM),
	.ALU_MW(WriteData_WB),
	.ALUSrc(ALUSrcA)
);

ForwardMUX fmuxb(
	.ALUSec(ForwardB),
	.ALU_DE(ALUInB),
	.ALU_EM(ALUOut_MEM),
	.ALU_MW(WriteData_WB),
	.ALUSrc(ALUSrcB)
);

ALU alu(
	.alu_a(ALUSrcA),
	.alu_b(ALUSrcB),
	.alu_op(ALUControl_EX),
	.ins(ALUOF_EX),
	.Overflow(Overflow_EX),
	.Zero(Zero_EX),
	.alu_out(ALUOut_EX)
);

RD_MUX RDMUX(RegDst_EX, RT_EX, RD_EX, WriteReg_EX);

assign PCBOut_EX = PCPlus4_EX + (Signimm_EX << 2);

EX_MEM EM(
	.clk(clk),
	.rst_n(rst_n),
	.flush(flush),
	.MemtoReg_EX(MemtoReg_EX),
	.MemWrite_EX(MemWrite_EX),
	.MemRead_EX(MemRead_EX),
	.Branch_EX(Branch_EX),
	.RegWrite_EX(RegWrite_EX),
	.Zero_EX(Zero_EX),
	.BranchSt_EX(BranchSt_EX),
	.ALUOut_EX(ALUOut_EX),
	.ReadRt_EX(ReadRt_EX),
	.PCBranch_EX(PCBOut_EX),
	.WriteReg_EX(WriteReg_EX),
	.Overflow_EX(Overflow_EX),
	.MemtoReg_MEM(MemtoReg_MEM),
	.MemWrite_MEM(MemWrite_MEM),
	.MemRead_MEM(MemRead_MEM),
	.Branch_MEM(Branch_MEM),
	.RegWrite_MEM(RegWrite_MEM),
	.Zero_MEM(Zero_MEM),
	.BranchSt_MEM(BranchSt_MEM),
	.ALUOut_MEM(ALUOut_MEM),
	.ReadRt_MEM(ReadRt_MEM),
	.PCBranch_MEM(PCBOut_MEM),
	.WriteReg_MEM(WriteReg_MEM),
	.Overflow_MEM(Overflow_MEM)
);

//  MEM
Ram Mem(
	.a(Add),
	.clk(clk),
	.spo(ReadData_MEM),
	.we(MemWrite_MEM),
	.d(RD2)
);

BranchSec BS(
	.Branch(Branch_MEM),
	.ALUOut(ALUOut_MEM),
	.BranchSt(BranchSt_MEM),
	.PCSrc(PCSrc),
);

MEM_WB MW(
	.clk(clk),
	.rst_n(rst_n),
	.RegWrite_MEM(RegWrite_MEM),
	.MemtoReg_MEM(MemtoReg_MEM),
	.ReadData_MEM(ReadData_MEM),
	.ALUOut_MEM(ALUOut_MEM),
	.WriteReg_MEM(WriteReg_MEM),
	.Overflow_MEM(Overflow_MEM),
	.RegWrite_WB(RegWrite_WB),
	.MemtoReg_WB(MemtoReg_WB),
	.ReadData_WB(ReadData_WB),
	.ALUOut_WB(ALUOut_WB),
	.Overflow_WB(Overflow_WB),
	.WriteReg_WB(WriteReg_WB)
);

// WB
MUX mux(ALUOut_WB, ReadData_WB, MemtoReg_WB, WriteData_WB);

endmodule