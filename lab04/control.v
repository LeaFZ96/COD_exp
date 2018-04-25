`timescale 1ns / 1ps

module control(
	input clk,
	input rst_n,
	input [31:0] c,
	input [31:0] rrout,
	output reg signed [4:0] alu_op,
	output reg [7:0] rradd,
	output reg [7:0] rwadd,
	output reg [5:0] wAddr,
	output reg [31:0] a,
	output reg [31:0] b,
	output reg [31:0] rwd,
	output reg [31:0] res,
	output reg rwe,
	output reg wEna
);

parameter idle = 3'h0;
parameter read0 = 3'h1;
parameter read1 = 3'h2;
parameter read2 = 3'h3;
parameter write = 3'h5;
parameter stop = 3'h6;

reg [3:0] curr_state, next_state;
reg [4:0] num;
reg [7:0] radd_reg, op_reg;
	 


always@(posedge clk or negedge rst_n) begin
	if (~rst_n)
		curr_state <= idle;
	else
		curr_state <= next_state;
end

always@(*) begin
	case(curr_state)
		idle:
			if (num < 22) next_state = idle;
			else next_state = read0;
		read0:
			next_state = read1;
		read1:
			next_state = read2;
		read2:
			if (alu_op == -1) next_state = stop;
			else next_state = write;
		write:
			next_state = read0;
		stop:
			next_state = stop;
		default:
			next_state = idle;
	endcase
end

always@(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		rradd <= 0;
		rwadd <= 0;
		op_reg <= 8'd100;
		wAddr <= 0;
		rwe <= 1;
		wEna <= 0;
		num <= 0;
		res <= 10;
		rwd <= 0;
		a <= 0;
		b <= 0;
		alu_op <= 0;
		radd_reg <= 0;
	end
	else if (curr_state == idle) begin
		if (num < 13) begin
			rwadd <= rwadd + 1;
			num <= num + 1;
			res <= res + 1;
		end
		else if (num == 13) begin
			rwadd <= 100;
			num <= num + 1;
			res <= 0;
		end
		else if (num < 20) begin
			rwadd <= rwadd + 1;
			num <= num + 1;
			res <= res + 1;
		end
		else if (num == 20) begin
			rwadd <= rwadd + 1;
			res <= -1;
			num <= num + 1;
		end
		else if (num == 21) begin
			rwadd <= 199;
			res <= 0;
			num <= num + 1;
		end
	end
	else if (curr_state == read0) begin
		alu_op <= rrout;
		rradd <= rradd + 1;
		wAddr <= 0;
		wEna <= 1;
		rwd <= rrout;
	end
	else if (curr_state == read1) begin
		res <= c;
		radd_reg <= rradd;
		wAddr <= wAddr + 1;
		a <= rrout;
		rwd <= rrout;
		rwe <= 1;
	end
	else if (curr_state == read2) begin
		radd_reg <= radd_reg + 1;
		rradd <= op_reg;
		b <= rrout;
		op_reg <= op_reg + 1;
		wAddr <= wAddr + 1;
		wEna <= 0;
		
	end
	else if (curr_state == write) begin
		rwe <= 0;
		rwadd <= rwadd + 1;
		rradd <= radd_reg;
	end
	else if (curr_state == stop) begin
		rwe <= 0;
		wEna <= 0;
	end
end

endmodule