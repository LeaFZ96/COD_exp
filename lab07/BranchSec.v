`timescale 1ns / 1ps

module BranchSec(
    input Branch,
    input signed [31:0] ALUOut,
    input [2:0] BranchSt,
    output reg [1:0] PCSrc
);

reg B_Zero;

always@(*) begin
    B_Zero = 0;
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
end

always@(*) begin
    PCSrc = 0;
    if(Branch and B_Zero)
        PCSrc = 2'b01;
end

endmodule