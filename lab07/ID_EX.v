`timescale 1ns / 1ps

module ID_EX(
    input clk,
    input rst_n,
    input flush,
    input MemtoReg_ID,
    input MemWrite_ID,
    input MemRead_ID,
    input Branch_ID,
    input ALUSrc_ID,
    input RegDst_ID,
    input RegWrite_ID,
    input [1:0] ALUOF_ID,
    input [2:0] BranchSt_ID,
    input [3:0] ALUControl_ID,
    input [31:0] PCPlus4_ID,
    input [31:0] ReadRs_ID,
    input [31:0] ReadRt_ID,
    input [31:0] Signimm_ID,
    input [4:0] RS_ID,
    input [4:0] RT_ID,
    input [4:0] RD_ID,
    output reg MemtoReg_EX,
    output reg MemWrite_EX,
    output reg MemRead_EX,
    output reg Branch_EX,
    output reg ALUSrc_EX,
    output reg RegDst_EX,
    output reg RegWrite_EX,
    output reg [1:0] ALUOF_EX,
    output reg [2:0] BranchSt_EX,
    output reg [3:0] ALUControl_EX,
    output reg [31:0] PCPlus4_EX,
    output reg [31:0] ReadRs_EX,
    output reg [31:0] ReadRt_EX,
    output reg [31:0] Signimm_EX,
    output reg [4:0] RS_EX,
    output reg [4:0] RT_EX,
    output reg [4:0] RD_EX
);

always@(posedge clk or negedge rst_n) begin
    if(~rst_n || flush) begin
        MemtoReg_EX <= 0;
        MemWrite_EX <= 0;
        MemRead_EX <= 0;
        Branch_EX <= 0;
        ALUSrc_EX <= 0;
        RegDst_EX <= 0;
        RegWrite_EX <= 0;
        BranchSt_EX <= 0;
        ALUControl_EX <= 0;
        PCPlus4_EX <= 0;
        ReadRs_EX <= 0;
        ReadRt_EX <= 0;
        Signimm_EX <= 0;
        RS_EX <= 0;
        RT_EX <= 0;
        RD_EX <= 0;
        ALUOF_EX <= 0;
    end
    else begin
        MemtoReg_EX <= MemtoReg_ID;
        MemWrite_EX <= MemWrite_ID;
        MemRead_EX <= MemRead_ID;
        Branch_EX <= Branch_ID;
        ALUSrc_EX <= ALUSrc_ID;
        RegDst_EX <= RegDst_ID;
        RegWrite_EX <= RegWrite_ID;
        BranchSt_EX <= BranchSt_ID;
        ALUControl_EX <= ALUControl_ID;
        PCPlus4_EX <= PCPlus4_ID;
        ReadRs_EX <= ReadRs_ID;
        ReadRt_EX <= ReadRt_ID;
        Signimm_EX <= Signimm_ID;
        RS_EX <= RS_ID;
        RT_EX <= RT_ID;
        RD_EX <= RD_ID;
        ALUOF_EX <= ALUOF_ID;
    end
end

endmodule