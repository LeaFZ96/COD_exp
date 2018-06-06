`timescale 1ns / 1ps

module MUX(
    input [31:0] data0,
    input [31:0] data1,
    input ctrl,
    output reg [31:0] dataout
);

always@(*) begin
    if(ctrl)
        dataout = data1;
    else
        dataout = data0;
end

endmodule