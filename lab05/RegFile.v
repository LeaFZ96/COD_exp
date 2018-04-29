`timescale 1ns / 1ps

module RegFile(
	input 			clk,
	input 			rst_n,
	input			RegWrite,
	input 	[5:0] 	rAddr0,
	input	[5:0]	rAddr1,
	input 	[5:0] 	wAddr,
	input 	[31:0] 	wDin,
	output reg	[31:0] 	rDout0,
	output reg	[31:0]  rDout1
);

reg [31:0] data [0:63];
integer i;

always@(*) begin
	if(~RegWrite)
		rDout0 = data[rAddr0];
		rDout1 = data[rAddr1];
end

always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		for(i = 0; i < 64; i = i + 1)
			data[i] <= 0;	
	end
	if(RegWrite)
		data[wAddr] = wDin;
end

endmodule