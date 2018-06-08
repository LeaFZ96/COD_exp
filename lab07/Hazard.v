`timescale 1ns / 1ps

module Hazard(
    input MemRead_DE,
    input Overflow,
    input Break,
	input RegWrite_EX,
	input Branch_ID,
    input [4:0] RT_DE,
    input [4:0] RT_FD,
    input [4:0] RS_FD,
	input [4:0] WriteReg_EX,
    output reg Flush_DE,
    output reg Expt_PC,
    output reg Stall_PC,
    output reg Stall_FD
);

always@(*) begin
    Stall_FD = 0;
    Stall_PC = 0;
    Flush_DE = 0;
    Expt_PC = 0;
    if(MemRead_DE && ((RT_DE == RS_FD) || (RT_DE == RT_FD))) begin
        Flush_DE = 1;
        Stall_FD = 1;
        Stall_PC = 1;
    end
	if(RegWrite_EX && (WriteReg_EX != 0) && Branch_ID && MemRead_DE) begin
		if(RS_FD == WriteReg_EX || RT_FD == WriteReg_EX) begin
			Flush_DE = 1;
			Stall_FD = 1;
			Stall_PC = 1;
		end
	end
    if(Overflow) begin
        Expt_PC = 1;
        Stall_PC = 1;
        Flush_DE = 1;
    end
    if(Break) begin
        Expt_PC = 1;
        Stall_PC = 1;
        Flush_DE = 1;
    end
end

endmodule