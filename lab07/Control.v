`timescale 1ns / 1ps

module Control(
	input [5:0] opcode,
	input [5:0] funct,
	input [4:0] RD,
	output reg Jump,
	output reg JumpR,
	output reg MemtoReg,
	output reg MemWrite,
	output reg MemRead,
	output reg Branch,
	output reg ALUSrc,
	output reg RegDst,
	output reg RegWrite,
	output reg [1:0] ALUOF,
	output reg [2:0] BranchSt,
	output reg [3:0] ALUControl
);

always@(opcode or funct) begin
	Jump = 0;
	JumpR = 0;
	MemtoReg = 0;
	MemWrite = 0;
	MemRead = 0;
	Branch = 0;
	BranchSt = 0;
	ALUSrc = 0;
	RegDst = 0;
	RegWrite = 0;
	ALUOF = 0;
	ALUControl = 0;
	case(opcode)
		6'h0: begin
			RegDst = 1;
			RegWrite = 1；
			case(funct)
				6'h20: begin				// add
					ALUControl = 4'h1;
					ALUOF = 2'b01;
				end
				6'h21: ALUControl = 4'h1;	// addu
				6'h22: begin				// sub
					ALUControl = 4'h2;
					ALUOF = 2'b10;
				end
				6'h23: ALUControl = 4'h2;	// subu
				6'h24: ALUControl = 4'h3;	// and
				6'h25: ALUControl = 4'h4;	// or
				6'h26: ALUControl = 4'h5;	// xor
				6'h27: ALUControl = 4'h6;	// nor
				6'h2a: ALUControl = 4'h8;	// slt
				6'h2b: ALUControl = 4'h7;	// sltu
				6'h8: begin					// jr
					Jump = 1;
					JumpR = 1;
					Branch = 1;
				end
			endcase
		end
		6'h8: begin		// addi
			ALUSrc = 1;
			ALUOF = 2'b01;
			RegWrite = 1;
			ALUControl = 4'h1;
		end 
		6'h9: begin		// addiu
			ALUSrc = 1;
			RegWrite = 1;
			ALUControl = 4'h1;
		end
		6'ha: begin 	// slti
			ALUSrc = 1;
			RegWrite = 1;
			ALUControl = 4'h8;
		end
		6'hb: begin 	// sltiu
			ALUSrc = 1;
			RegWrite = 1;
			ALUControl = 4'h7;
		end
		6'hc: begin 	// andi
			ALUSrc = 1;
			RegWrite = 1;
			ALUControl = 4'h3;
		end
		6'hd: begin 	// ori
			ALUSrc = 1;
			RegWrite = 1;
			ALUControl = 4'h4;
		end
		6'he: begin 	// xori
			ALUSrc = 1;
			RegWrite = 1;
			ALUControl = 4'h5
		end
		6'h23: begin 	// lw
			MemRead = 1;
			MemtoReg = 1;
			ALUSrc = 1;
			RegWrite = 1;
			ALUControl = 4'h1;
		end
		6'h2b: begin 	// sw
			MemWrite = 1;
			ALUSrc = 1;
			ALUControl = 4'h1;
		end
		6'h1: begin
			if (RD == 0) begin	// bltz
				Branch = 1;
				ALUControl = 4'h2;
				BranchSt = 3'h4;
			end
			else if (RD == 1) begin // bgez
				Branch = 1;
				ALUControl = 4'h2;
				BranchSt = 3'h5;
			end
		end
		6'h4: begin		// beq
			Branch = 1;
			ALUControl = 4'h2;
			BranchSt = 3'h3;
		end
		6'h5: begin 	// bne
			Branch = 1;
			ALUControl = 4'h2;
			BranchSt = 3'h0;
		end
		6'h6: begin		// blez
			Branch = 1;
			ALUControl = 4'h2;
			BranchSt = 3'h2;
		end
		6'h7: begin 	// bgtz
			Branch = 1;
			ALUControl = 4'h2;
			BranchSt = 3'h1;
		end
		6'h2: begin 	// j
			Jump = 1;
		end
	endcase
end

endmodule