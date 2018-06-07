`timescale 1ns / 1ps

module PCMUX(
	input PCJ,
	input PCB,
	input PCE,
	output reg [1:0] PCSrc
);

always@(*) begin
	if(PCE)
		PCSrc = 2'b11;
	else if(PCJ)
		PCSrc = 2'b10;
	else if(PCB)
		PCSrc = 2'b01;
	else
		PCSrc = 0;
end

endmodule