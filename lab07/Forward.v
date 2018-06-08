`timescale 1ns / 1ps

module Forward(
    input RegWrite_EM,
    input RegWrite_MW,
	input RegWrite_EX,
	input Branch_ID,
    input [4:0] WriteReg_EM,
    input [4:0] WriteReg_MW,
	input [4:0] WriteReg_EX,
    input [4:0] RT_DE,
    input [4:0] RS_DE,
	input [4:0] RT_ID,
	input [4:0] RS_ID,
    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB,
	output reg [1:0] ForwardA_ID,
	output reg [1:0] ForwardB_ID
);

always@(*) begin
    ForwardA = 0;
    ForwardB = 0;
	ForwardA_ID = 0;
	ForwardB_ID = 0;
    if(RegWrite_EM && (WriteReg_EM != 0)) begin    // EX hazard
        if(RS_DE == WriteReg_EM)
            ForwardA = 2'b10;
        if(RT_DE == WriteReg_EM)
            ForwardB = 2'b10;
    end
    if(RegWrite_MW && (WriteReg_MW != 0) && !(RegWrite_EM && (WriteReg_EM != 0) && (WriteReg_EM == RS_DE))) begin   // MEM hazard
        if(RS_DE == WriteReg_MW)
            ForwardA = 2'b01;
	end
	if(RegWrite_MW && (WriteReg_MW != 0) && !(RegWrite_EM && (WriteReg_EM != 0) && (WriteReg_EM == RT_DE))) begin
        if(RT_DE == WriteReg_MW)
            ForwardB = 2'b01;
    end
	if(RegWrite_EM && Branch_ID && (WriteReg_EM != 0)) begin
		if(RS_ID == WriteReg_EM)
			ForwardA_ID = 2'b01;
		if(RT_ID == WriteReg_EM)
			ForwardB_ID = 2'b01;
	end
	if(RegWrite_EX && (WriteReg_EX != 0) && Branch_ID) begin
		if(RS_ID == WriteReg_EX)
			ForwardA_ID = 2'b10;
		if(RT_ID == WriteReg_EX)
			ForwardB_ID = 2'b10;
	end
end

endmodule