`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:47:33 11/23/2017 
// Design Name: 
// Module Name:    regfile 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module regfile(
	input clk,
	input rst,
	input [3:0] addr_a,
	input [3:0] addr_b,
	input [3:0] addr_c,
	input [15:0] data_c,
	input wen_c,
	output reg [15:0] q_a,
	output reg [15:0] q_b
    );

reg [15:0] data [0:15];

always@(addr_a or addr_b)
begin
	case(addr_a)
	4'h0: q_a = data[0];	
	4'h1: q_a = data[1];
	4'h2: q_a = data[2];
	4'h3: q_a = data[3];
	4'h4: q_a = data[4];
	4'h5: q_a = data[5];
	4'h6: q_a = data[6];
	4'h7: q_a = data[7];
	4'h8: q_a = data[8];
	4'h9: q_a = data[9];
	4'ha: q_a = data[10];
	4'hb: q_a = data[11];
	4'hc: q_a = data[12];
	4'hd: q_a = data[13];
	4'he: q_a = data[14];
	4'hf: q_a = data[15];
	default: q_a = data[0];
	endcase
	case(addr_b)
	4'h0: q_b = data[0];	
	4'h1: q_b = data[1];
	4'h2: q_b = data[2];
	4'h3: q_b = data[3];
	4'h4: q_b = data[4];
	4'h5: q_b = data[5];
	4'h6: q_b = data[6];
	4'h7: q_b = data[7];
	4'h8: q_b = data[8];
	4'h9: q_b = data[9];
	4'ha: q_b = data[10];
	4'hb: q_b = data[11];
	4'hc: q_b = data[12];
	4'hd: q_b = data[13];
	4'he: q_b = data[14];
	4'hf: q_b = data[15];
	default: q_a = data[0];
	endcase
//	for(i = 0; i < 16; i = i + 1)
//	begin
//		if (addr_a == i)
//			q_a = data[i];
//		if (addr_b == i)
//			q_b = data[i];
//	end
//	q_a = data[addr_a];
//	q_b = data[addr_b];
end

always@(posedge clk or posedge rst)
	if (rst)
	begin
		data[0] <= 16'h0000;
		data[1] <= 16'h1100;
		data[2] <= 16'h2200;
		data[3] <= 16'h3300;
		data[4] <= 16'h4400;
		data[5] <= 16'h5500;
		data[6] <= 16'h6600;
		data[7] <= 16'h7700;
		data[8] <= 16'h8800;
		data[9] <= 16'h9900;
		data[10] <= 16'haa00;
		data[11] <= 16'hbb00;
		data[12] <= 16'hcc00;
		data[13] <= 16'hdd00;
		data[14] <= 16'hee00;	
		data[15] <= 16'hff00;
	end
	else if (wen_c)
		data[addr_c] <= data_c;


endmodule
