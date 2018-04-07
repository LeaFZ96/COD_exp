`timescale 1ns / 1ps

module control(
	input clk,
	input rst_n,
	input [31:0] r0,
	output reg [5:0] rAddr,
	output reg [5:0] wAddr,
	output reg [31:0] a,
	output reg [31:0] b,
	output reg wEna
);

reg [2:0] num;
	 
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		rAddr <= 0;
		wAddr <= 1;
		num <= 0;
		a <= 2;
	end
	else if(num == 0) begin
		wEna <= 0;
		rAddr <= rAddr;
		num <= num + 1;
	end
	else if(num == 1) begin
		a <= r0;
		num <= num + 1;
	end
	else if(num == 2) begin
		num <= num + 1;
		rAddr <= rAddr + 1;
	end
	else if(num == 3) begin
		num <= num + 1;
		b <= r0;
	end
	else if(num == 4) begin
		wEna <= 1;
		num <= 0;
		wAddr <= wAddr + 1;
	end
end

endmodule