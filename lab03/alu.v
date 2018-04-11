`timescale 1ns / 1ps

module alu(
    input signed [31:0] alu_a,
    input signed [31:0] alu_b,
    input        [4:0]  alu_op,
    output       [31:0] alu_out
);

reg [31:0] temp;

parameter A_NOP = 5'h00;  //空运算
parameter	A_ADD = 5'h01;	//符号加
parameter	A_SUB = 5'h02;	//符号减
parameter	A_AND = 5'h03;	//与
parameter	A_OR = 5'h04;	//或
parameter	A_XOR = 5'h05;	//异或
parameter	A_NOR = 5'h06;	//或非

always@(*) begin
  case (alu_op)
    A_NOP: temp = alu_a;
    A_ADD: temp = alu_a + alu_b;
    A_SUB: temp = alu_a - alu_b;
    A_AND: temp = alu_a & alu_b;
    A_OR: temp = alu_a | alu_b;
    A_XOR: temp = alu_a ^ alu_b;
    A_NOR: temp = ~(alu_a | alu_b);
    default: temp = alu_a;
  endcase
end

assign alu_out = temp;

endmodule