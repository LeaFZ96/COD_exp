`timescale 1ns / 1ps

module ALU(
    input [31:0] alu_a,
    input [31:0] alu_b,
    input [3:0] alu_op,
    input [1:0] ins,
    output reg Overflow,
    output reg Zero,
    output reg [31:0] alu_out
);

parameter A_NOP = 3'h00;
parameter A_ADD = 3'h01;
parameter A_SUB = 3'h02;
parameter A_AND = 3'h03;
parameter A_OR = 3'h04;
parameter A_XOR = 3'h05;
parameter A_NOR = 3'h06;
parameter A_SLTU = 3'h07;
parameter A_SLT = 3'h08;

always@(*) begin
    case(alu_op)
        A_NOP: alu_out = 0;
        A_ADD: alu_out = alu_a + alu_b;
        A_SUB: alu_out = alu_a - alu_b;
        A_AND: alu_out = alu_a & alu_b;
        A_OR: alu_out = alu_a | alu_b;
        A_XOR: alu_out = alu_a ^ alu_b;
        A_NOR: alu_out = ~(alu_a | alu_b);
        A_SLTU: alu_out = alu_a < alu_b ? 1: 0;
        A_SLT: alu_out = $signed(alu_a) < $signed(alu_b) ? 1: 0;
        default: alu_out = 0;
    endcase
    if(alu_out == 0)
        Zero = 1;
    else
        Zero = 0;
    case(ins)
        2'b01: begin    // add or addi
            if(alu_a > 0 && alu_b > 0 && $signed(alu_out) < 0)
                Overflow = 1;
        end
        2'b10: begin    // sub
            if(alu_a > 0 && $signed(alu_b) < 0 && $signed(alu_out) < 0)
                Overflow = 1;
        end
        default: Overflow = 0;
    endcase
end

endmodule