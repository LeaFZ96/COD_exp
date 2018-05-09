`timescale 1ns / 1ps

module Control(
    input clk,
    input rst_n,
    input [5:0] op,
    input [5:0] funct,
    output reg MemtoReg,
    output reg RegDst,
    output reg IorD,
    output reg [1:0] PCSrc,
    output reg ALUSrcA,
    output reg [1:0] ALUSrcB,
    output reg IRWrite,
    output reg MemWrite,
    output reg PCWrite,
    output reg Branch,
    output reg RegWrite,
    output reg [2:0] ALUControl
)

parameter S0 = 4'd0;
parameter S1 = 4'd1;
parameter S2 = 4'd2;
parameter S3 = 4'd3;
parameter S4 = 4'd4;
parameter S5 = 4'd5;
parameter S6 = 4'd6;
parameter S7 = 4'd7;
parameter S8 = 4'd8;
parameter S9 = 4'd9;
parameter S10 = 4'd10;
parameter S11 = 4'd11;

reg [3:0] curr_state, next_state;

always@(posedge clk or negedge rst_n) begin
    if (~rst_n)
        curr_state <= S0;
    else
        curr_state <= next_state;
end

always@(curr_state) begin
    case(curr_state)
        S0:
            next_state = S1;
        S1:
            if (op == 6'h23 or op == 6'h2b)
                next_state = S2;
            else if (op == 6'h0) 
                next_state = S6;
            else if (op == 6'h7)
                next_state = S8;
            else if (op == 6'h8)
                next_state = S9;
            else if (op == 6'h2)
                next_state = S11;
            else
                next_state = S0;
        S2:
            if (op == 6'h23)
                next_state = S3;
            else
                next_state = S5;
        S3:
            next_state = S4;
        S6:
            next_state = S7;
        S9:
            next_state = S10;
        default:
            next_state = S0;
    endcase
end

always@(posedge clk or negedge rst_n) begin
    if (~rst_n or next_state == S0) begin
        IorD <= 0;
        ALUSrcA <= 0;
        ALUSrcB <= 2'b01;
        ALUControl <= 3'b001;
        PCSrc <= 0;
        IRWrite <= 1;
        MemWrite <= 0;
        PCWrite <= 1;
        Branch <= 0;
        RegWrite <= 0;
    end
    else if (next_state == S1) begin
        ALUSrcA <= 0;
        ALUSrcB <= 2'b11;
        ALUControl <= 3'b001;
    end
    else if (next_state == S2) begin
        ALUSrcA <= 1;
        ALUSrcB <= 2'b10;
        ALUControl <= 3'b001;
    end
    else if (next_state == S3) 
        IorD <= 1;
    else if (next_state == S4) begin
        RegDst <= 0;
        MemtoReg <= 1;
        RegWrite <= 1;
    end
    else if (next_state == S5) begin
        IroD <= 1;
        MemWrite <= 1;
    end
    else if (next_state == S6) begin
        ALUSrcA <= 1;
        ALUSrcB <= 2'b00;
        ALUControl <= 3'b001;
    end
    else if (next_state == S7) begin
        RegDst <= 1;
        MemtoReg <= 0;
        RegWrite <= 1;
    end
    else if (next_state == S8) begin
        ALUSrcA <= 1;
        ALUSrcB <= 0;
        ALUControl <= 3'b010;
        PCSrc <= 2'b01;
        Branch <= 1;
    end
    else if (next_state == S9) begin
        ALUSrcA <= 1;
        ALUSrcB <= 2'b10;
        ALUControl <= 3'b001;
    end
    else if (next_state == S10) begin
        RegDst <= 0;
        MemtoReg <= 0;
        RegWrite <= 1;
    end
    else if (next_state == S11) begin
        PCSrc <= 2'b10;
        PCWrite <= 1;
    end
end

endmodule