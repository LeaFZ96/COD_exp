`timescale 1ns / 1ps

module Control(
	input [5:0] opcode,
	input [5:0] funct,
	output reg Jump,
	output reg MemtoReg,
	output reg MemWrite,
	output reg Branch,
	output reg ALUSrc,
	output reg RegDst,
	output reg RegWrite,
	output reg [2:0] ALUControl
);

always@(opcode or funct) begin
	case(opcode)
		6'h0:		// add
			case(funct)
				6'h20: begin
					Jump = 0;
					MemtoReg = 0;
					MemWrite = 0;
					ALUSrc = 0;
					RegDst = 1;
					RegWrite = 1;
					Branch = 0;
					ALUControl = 3'b001;
				end
				default: begin
					Jump = 0;
					MemtoReg = 0;
					MemWrite = 0;
					ALUSrc = 0;
					RegDst = 0;
					RegWrite = 0;
					Branch = 0;
					ALUControl = 0;
				end
			endcase
		6'h8: begin		// addi
			Jump = 0;
			MemtoReg = 0;
			MemWrite = 0;
			ALUSrc = 1;
			RegDst = 0;
			RegWrite = 1;
			Branch = 0;
			ALUControl = 3'b001;
		end 
		6'h23: begin 	// lw
			Jump = 0;
			MemtoReg = 1;
			MemWrite = 0;
			ALUSrc = 1;
			RegDst = 0;
			RegWrite = 1;
			Branch = 0;
			ALUControl = 3'b001;
		end
		6'h2b: begin 	// sw
			Jump = 0;
			MemtoReg = 0;
			MemWrite = 1;
			ALUSrc = 1;
			RegDst = 0;
			RegWrite = 0;
			Branch = 0;
			ALUControl = 3'b001;
		end
		6'h7: begin 	// bgtz
			Jump = 0;
			MemtoReg = 0;
			MemWrite = 0;
			ALUSrc = 0;
			RegDst = 0;
			RegWrite = 0;
			Branch = 1;
			ALUControl = 3'b010;
		end
		6'h2: begin 	// j
			Jump = 1;
			MemtoReg = 0;
			MemWrite = 0;
			ALUSrc = 0;
			RegDst = 0;
			RegWrite = 0;
			Branch = 0;
			ALUControl = 0;
		end
		default: begin
			Jump = 0;
			MemtoReg = 0;
			MemWrite = 0;
			ALUSrc = 0;
			RegDst = 0;
			RegWrite = 0;
			Branch = 0;
			ALUControl = 0;
		end
	endcase
end

endmodule