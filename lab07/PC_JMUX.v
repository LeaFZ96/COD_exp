`timescale 1ns / 1ps

module PC_JMUX(
    input Jump,
    input JumpR,
    input [31:0] PCPlus4,
    input [27:0] Instr,
    input [31:0] Signimm,
    input [31:0] ReadRs_ID,
    output reg PCJ,
    output reg [31:0] PCJOut
);

always@(*) begin
    PCJ = 0;
    if(Jump) begin
        PCJ = 1;
        if(JumpR)
            PCJOut = {2'b00, ReadRs_ID[31:2]};
        else
            PCJOut = {PCPlus4[31:28], Instr};
	 end
end

endmodule