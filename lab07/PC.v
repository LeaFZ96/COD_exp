`timescale 1ns / 1ps

module PC(
    input clk,
    input rst_n,
    input Stall,
    input Continue,
    input [1:0] PCSrc,
    input [31:0] PCPlus4,
    input [31:0] PCJOut,
    input [31:0] PCBOut,
    output reg [31:0] PCNext
);

reg [159:0] PCH;
reg StallSt;

always@(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
		StallSt <= 0;
        PCNext <= 0;
	end
    else begin
		if(~Stall && ~StallSt) begin
			if(PCSrc == 2'b01)
				PCNext <= PCBOut;
			else if(PCSrc == 2'b10)
				PCNext <= PCJOut;
			else if(PCSrc == 2'b11)         // break
				PCNext <= 32'hffffffff;
			else
				PCNext <= PCPlus4;
			if(PCSrc != 2'b11)
				PCH <= {PCH[127:0], PCNext};
		end
		if(PCSrc == 2'b11) begin
			PCNext <= 32'hffffffff;
			PCH <= {PCH[127:0], PCNext};
			StallSt <= 1;
		end
		if(Continue) begin
			PCNext <= PCH[31:0];
			StallSt <= 0;
		end
	end
end

endmodule