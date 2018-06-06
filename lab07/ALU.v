`timescale 1ns / 1ps

module ALU(
    input [31:0] alu_a,
    input [31:0] alu_b,
    input        [3:0]  alu_op,
    output reg Zero,
    output reg [31:0] alu_out
);

wire signed [31:0] alu_sa, alu_sb;
assign alu_sa = alu_a;
assign alu_sb = alu_b;

parameter A_NOP = 3'h00;  //空运�
parameter	A_ADD = 3'h01;	//符号�
parameter	A_SUB = 3'h02;	//符号�
parameter	A_AND = 3'h03;	//�
parameter	A_OR = 3'h04;	//�
parameter	A_XOR = 3'h05;	//异或
parameter	A_NOR = 3'h06;	//或非
parameter A_SLTU = 3'h07;
parameter A_SLT = 3'h08;

always@(*) begin
  case (alu_op)
    A_NOP: alu_out = 0;
    A_ADD: alu_out = alu_a + alu_b;
    A_SUB: alu_out = alu_a - alu_b;
    A_AND: alu_out = alu_a & alu_b;
    A_OR: alu_out = alu_a | alu_b;
    A_XOR: alu_out = alu_a ^ alu_b;
    A_NOR: alu_out = ~(alu_a | alu_b);
    A_SLTU: alu_out = alu_a < alu_b ? 1: 0;
    A_SLT: alu_out = alu_sa < alu_sb ? 1: 0;
    default: alu_out = 0;
  endcase
  if (alu_out == 0)
    Zero = 1;
  else
    Zero = 0;
end

endmodule