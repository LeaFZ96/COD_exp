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

always@(posedge clk or negedge rst_n) begin
    if(~rst_n)
        PCNext <= 0;
    else begin
	if(~Stall) begin
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
    if(PCSrc == 2'b11)
        PCNext <= 32'hffffffff;
    if(Continue)
        PCNext <= PCH[63:32];
	end
end

endmodule