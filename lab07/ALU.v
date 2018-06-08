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
reg [31:0] temp1, temp2;
always@(*) begin
	Overflow = 0;
    case(alu_op)
        0: alu_out = 0;
        1: begin 
			alu_out = alu_a + alu_b;
			temp1 = alu_a + alu_b;
			if(ins == 2'b01) begin
				if(alu_a > 0 && alu_b > 0 && ($signed(alu_a) + $signed(alu_b)) < 0) begin
					temp2 = alu_out;
				end
			end
		end
        2: begin
			alu_out = alu_a - alu_b;
			if(ins == 2'b10) begin
				if(alu_a > 0 && $signed(alu_b) < 0 && $signed(alu_out) < 0) begin
					Overflow = 1;
				end
			end
		end
        3: alu_out = alu_a & alu_b;
        4: alu_out = alu_a | alu_b;
        5: alu_out = alu_a ^ alu_b;
        6: alu_out = ~(alu_a | alu_b);
        7: alu_out = alu_a < alu_b ? 1: 0;
        8: alu_out = $signed(alu_a) < $signed(alu_b) ? 1: 0;
        default: alu_out = 0;
    endcase
    if(alu_out == 0)
        Zero = 1;
    else
        Zero = 0;
end

endmodule