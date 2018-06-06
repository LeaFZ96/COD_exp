`timescale 1ns / 1ps

module ForwardMUX(
    input [1:0] ALUSec,
    input [31:0] ALU_DE,
    input [31:0] ALU_EM,
    input [31:0] ALU_MW,
    output reg [31:0] ALUSrc
);

always@(*) begin
    if(ALUSec == 2'b01)
        ALUSrc = ALU_MW;
    else if(ALUSec == 2'b10)
        ALUSrc = ALU_EM;
    else
        ALUSrc = ALU_DE;
end

endmodule