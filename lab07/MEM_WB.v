`timescale 1ns / 1ps

module MEM_WB(
    input clk,
    input rst_n,
    input RegWrite_MEM,
    input MemtoReg_MEM,
    input [31:0] ReadData_MEM,
    input [31:0] ALUOut_MEM,
    input [4:0] WriteReg_MEM,
    input Overflow_MEM,
    output reg RegWrite_WB,
    output reg MemtoReg_WB,
    output reg [31:0] ReadData_WB,
    output reg [31:0] ALUOut_WB,
    output reg [4:0] WriteReg_WB,
    output reg Overflow_WB
);

always@(posedge clk or negedge rst_n) begin
    if(~rst_n || flush) begin
        RegWrite_WB <= 0;
        MemtoReg_WB <= 0;
        ReadData_WB <= 0;
        ALUOut_WB <= 0;
        WriteReg_WB <= 0;
        Overflow_WB <= 0;
    end
    else begin
        RegWrite_WB <= RegWrite_MEM;
        MemtoReg_WB <= MemtoReg_MEM;
        ReadData_WB <= ReadData_MEM;
        ALUOut_WB <= ALUOut_MEM;
        WriteReg_WB <= WriteReg_MEM; 
        Overflow_WB <= Overflow_MEM;
    end
end

endmodule