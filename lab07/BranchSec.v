`timescale 1ns / 1ps

module BranchSec(
    input Branch,
    input [2:0] BranchSt,
    input [31:0] Rs,
    input [31:0] Rt,
    output reg PCSrc
);

reg B_Zero;
reg signed [31:0] ALUOut;

always@(*) begin
    B_Zero = 0;
    ALUOut = Rs - Rt;
    case (BranchSt)
        3'h0:       // bne
            if (ALUOut == 0)
                B_Zero = 0;
            else
                B_Zero = 1;
        3'h1:       // bgtz
            if (ALUOut > 0)
                B_Zero = 1;
            else
                B_Zero = 0;
        3'h2:       // blez
            if (ALUOut > 0)
                B_Zero = 0;
            else
                B_Zero = 1;
        3'h3:       // beq
            if (ALUOut == 0)
                B_Zero = 1;
            else
                B_Zero = 0;
        3'h4:       // bltz
            if (ALUOut < 0)
                B_Zero = 1;
            else
                B_Zero = 0;
        3'h5:       // bgez
            if (ALUOut < 0)
                B_Zero = 0;
            else
                B_Zero = 1;
	 endcase
end

always@(*) begin
    PCSrc = 0;
    if(Branch && B_Zero)
        PCSrc = 1;
end

endmodule