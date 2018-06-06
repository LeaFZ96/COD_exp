`timescale 1ns / 1ps

module PC_JMUX(
    input Jump,
    input JumpR,
    input [31:0] PCPlus4,
    input [25:0] Instr,
    input [31:0] Signimm,
    input [31:0] ReadRs_ID,
    output reg PCSrc,
    output reg [31:0] PCJOut
);

always@(*) begin
    PCSrc = 0;
    if(Jump) begin
        PCSrc = 2'b10;
        if(JumpR)
            PCJOut = ReadRs_ID;
        else
            PCJOut = {PCPlus4[31:28], Instr, 2'b0};
end

endmodule