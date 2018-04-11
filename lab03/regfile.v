`timescale 1ns / 1ps

module regfile(
	input 			clk,
	input 			rst_n,
	input 	[5:0] 	wAddr,
	input 	[31:0] 	wDin,
	input			wEna
);

reg [31:0] data [0:63];
integer i;

always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		data[0] <= 32'h0002;
		data[1] <= 32'h0002;
		for(i = 2; i < 64; i = i + 1)
			data[i] <= 0;
	end
	if(wEna)
		data[wAddr] = wDin;
end

endmodule