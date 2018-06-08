`timescale 1ns / 1ps

module RegFile(
	input 			clk,
	input 			rst_n,
	input			RegWrite,
	input 	[4:0] 	rAddr0,
	input	[4:0]	rAddr1,
	input 	[4:0] 	wAddr,
	input 	[31:0] 	wDin,
	output	[31:0] 	rDout0,
	output	[31:0]  rDout1
);

reg [31:0] data [0:31];
integer i;

assign rDout0 = rAddr0 ? ((RegWrite && rAddr0 == wAddr) ? wDin : data[rAddr0]) : 0;
assign rDout1 = rAddr1 ? ((RegWrite && rAddr1 == wAddr) ? wDin : data[rAddr1]) : 0;

always@(negedge clk or negedge rst_n) begin
	if(~rst_n) begin
		for(i = 0; i < 32; i = i + 1)
			data[i] <= 0;	
	end
	else if(RegWrite == 1'b1)
		data[wAddr] <= wDin;
end

endmodule