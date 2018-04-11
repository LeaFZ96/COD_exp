`timescale 1ns / 1ps

module control(
	input clk,
	input rst_n,
	input [31:0] c,
	input [31:0] rrout,
	output reg [5:0] rradd,
	output reg [5:0] rwadd,
	output reg [5:0] wAddr,
	output reg [31:0] a,
	output reg [31:0] b,
	output reg [31:0] res,
	output reg rwe,
	output reg wEna
);

reg [2:0] num, initr;
	 
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		initr <= 0;
		rradd <= 0;
		rwadd <= 1;
		wAddr <= 1;
		rwe <= 0;
		wEna <= 0;
		num <= 0;
	end
	else if(initr < 2) begin
		initr <= initr + 1;
		wEna <= 1;
		rradd <= rradd + 1;
		res <= rrout;
	end
	else if(initr == 2) begin
		initr <= initr + 1;
		rradd <= 0;
		rwadd <= 1;
		wAddr <= 1;
		rwe <= 0;
		wEna <= 0;
		num <= 0;
		a <= 2;
	end
	else if(num == 0) begin
		rwe <= 0;
		wEna <= 0;
		rradd <= rradd;
		num <= num + 1;
	end
	else if(num == 1) begin
		a <= rrout;
		num <= num + 1;
	end
	else if(num == 2) begin
		num <= num + 1;
		rradd <= rradd + 1;
	end
	else if(num == 3) begin
		num <= num + 1;
	end
	else if(num == 4) begin
		num <= num + 1;
		b <= rrout;
	end
	else if(num == 5) begin
		rwe <= 1;
		wEna <= 1;
		num <= 0;
		res <= c;
		rwadd <= rwadd + 1;
		wAddr <= wAddr + 1;
	end
end

endmodule