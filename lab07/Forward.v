`timescale 1ns / 1ps

module Forward(
    input RegWrite_EM,
    input RegWrite_MW,
    input [4:0] WriteReg_EM,
    input [4:0] WriteReg_MW,
    input [4:0] RT_DE,
    input [4:0] RS_DE,
    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB,
);

always@(*) begin
    ForwardA = 0;
    ForwardB = 0;
    if(RegWrite_EM && (WriteReg_EM != 0)) begin    // EX hazard
        if(RS_DE == WriteReg_EM)
            ForwardA = 2'b10;
        if(RT_DE == WriteReg_EM)
            ForwardB = 2'b10;
    end
    if(RegWrite_MW && (WriteReg_MW != 0) && !(RegWrite_EM && (WriteReg_EM != 0))) begin   // MEM hazard
        if((RS_DE == WriteReg_MW) && (RS_DE != WriteReg_EM))
            ForwardA = 2'b01;
        if((RT_DE == WriteReg_MW) && (RT_DE != WriteReg_EM))
            ForwardB = 2'b01;
    end
end

endmodule