`timescale 1ns / 1ps

module EX_MEM(
    input clk,
    input rst_n,
    input MemtoReg_EX,
    input MemWrite_EX,
    input Branch_EX,
    input RegWrite_EX,
    input Zero_EX,
    input [2:0] BranchSt_EX,
    input [31:0] ALUOut_EX,
    input [31:0] ReadRt_EX,
    input [31:0] PCBranch_EX,
    input [4:0] WriteReg_EX,
    output reg MemtoReg_MEM,
    output reg MemWrite_MEM,
    output reg Branch_MEM,
    output reg RegWrite_MEM,
    output reg Zero_MEM,
    output reg [2:0] BranchSt_MEM,
    output reg [31:0] ALUOut_MEM,
    output reg [31:0] ReadRt_MEM,
    output reg [31:0] PCBranch_MEM,
    output reg [4:0] WriteReg_MEM
);

always@(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        MemtoReg_MEM <= 0;
        MemWrite_MEM <= 0;
        Branch_MEM <= 0;
        RegWrite_MEM <= 0;
        Zero_MEM <= 0;
        BranchSt_MEM <= 0;
        ALUOut_MEM <= 0;
        ReadRt_MEM <= 0;
        PCBranch_MEM <= 0;
        WriteReg_MEM <= 0;
    end
    else begin
        MemtoReg_MEM <= MemtoReg_EX;
        MemWrite_MEM <= MemWrite_EX;
        Branch_MEM <= Branch_EX;
        RegWrite_MEM <= RegWrite_EX;
        Zero_MEM <= Zero_EX;
        BranchSt_MEM <= BranchSt_EX;
        ALUOut_MEM <= ALUOut_EX;
        ReadRt_MEM <= ReadRt_EX;
        PCBranch_MEM <= PCBranch_EX;
        WriteReg_MEM <= WriteReg_EX; 
    end
end

endmodule