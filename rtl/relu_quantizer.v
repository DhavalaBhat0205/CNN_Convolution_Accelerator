`timescale 1ns/1ps
// ReLU and saturation block. Internal sum is shifted back to Q4.4 format.
module relu_quantizer #(
    parameter ACC_WIDTH = 24,
    parameter OUT_WIDTH = 8,
    parameter FRAC_BITS = 4
)(
    input  wire signed [ACC_WIDTH-1:0] acc_in,
    output reg  signed [OUT_WIDTH-1:0] data_out
);
    localparam signed [OUT_WIDTH-1:0] MAX_VAL =  8'sd127;
    localparam signed [OUT_WIDTH-1:0] MIN_VAL =  8'sd0;
    wire signed [ACC_WIDTH-1:0] shifted = acc_in >>> FRAC_BITS;
    always @(*) begin
        if (shifted <= 0)
            data_out = MIN_VAL;
        else if (shifted > MAX_VAL)
            data_out = MAX_VAL;
        else
            data_out = shifted[OUT_WIDTH-1:0];
    end
endmodule
