`timescale 1ns/1ps
// Signed fixed-point MAC unit for CNN convolution accelerator.
module mac_unit #(
    parameter DATA_WIDTH = 8,
    parameter COEFF_WIDTH = 8,
    parameter ACC_WIDTH = 24
)(
    input  wire signed [DATA_WIDTH-1:0]  pixel,
    input  wire signed [COEFF_WIDTH-1:0] weight,
    input  wire signed [ACC_WIDTH-1:0]   acc_in,
    output wire signed [ACC_WIDTH-1:0]   acc_out
);
    wire signed [DATA_WIDTH+COEFF_WIDTH-1:0] product;
    assign product = pixel * weight;
    assign acc_out = acc_in + {{(ACC_WIDTH-(DATA_WIDTH+COEFF_WIDTH)){product[DATA_WIDTH+COEFF_WIDTH-1]}}, product};
endmodule
