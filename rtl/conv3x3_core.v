`timescale 1ns/1ps
// 3x3 CNN convolution core with nine parallel multipliers and registered output.
// Input/weight data are signed Q4.4 fixed-point values.
module conv3x3_core #(
    parameter DATA_WIDTH = 8,
    parameter COEFF_WIDTH = 8,
    parameter ACC_WIDTH = 24,
    parameter FRAC_BITS = 4
)(
    input  wire clk,
    input  wire rst_n,
    input  wire valid_in,
    input  wire signed [DATA_WIDTH-1:0]  p00, p01, p02,
    input  wire signed [DATA_WIDTH-1:0]  p10, p11, p12,
    input  wire signed [DATA_WIDTH-1:0]  p20, p21, p22,
    input  wire signed [COEFF_WIDTH-1:0] w00, w01, w02,
    input  wire signed [COEFF_WIDTH-1:0] w10, w11, w12,
    input  wire signed [COEFF_WIDTH-1:0] w20, w21, w22,
    input  wire signed [ACC_WIDTH-1:0]   bias,
    output reg valid_out,
    output reg signed [DATA_WIDTH-1:0] data_out,
    output reg signed [ACC_WIDTH-1:0] acc_debug
);
    wire signed [ACC_WIDTH-1:0] s0,s1,s2,s3,s4,s5,s6,s7,s8;
    mac_unit #(.DATA_WIDTH(DATA_WIDTH),.COEFF_WIDTH(COEFF_WIDTH),.ACC_WIDTH(ACC_WIDTH)) m0(p00,w00,bias,s0);
    mac_unit #(.DATA_WIDTH(DATA_WIDTH),.COEFF_WIDTH(COEFF_WIDTH),.ACC_WIDTH(ACC_WIDTH)) m1(p01,w01,s0,s1);
    mac_unit #(.DATA_WIDTH(DATA_WIDTH),.COEFF_WIDTH(COEFF_WIDTH),.ACC_WIDTH(ACC_WIDTH)) m2(p02,w02,s1,s2);
    mac_unit #(.DATA_WIDTH(DATA_WIDTH),.COEFF_WIDTH(COEFF_WIDTH),.ACC_WIDTH(ACC_WIDTH)) m3(p10,w10,s2,s3);
    mac_unit #(.DATA_WIDTH(DATA_WIDTH),.COEFF_WIDTH(COEFF_WIDTH),.ACC_WIDTH(ACC_WIDTH)) m4(p11,w11,s3,s4);
    mac_unit #(.DATA_WIDTH(DATA_WIDTH),.COEFF_WIDTH(COEFF_WIDTH),.ACC_WIDTH(ACC_WIDTH)) m5(p12,w12,s4,s5);
    mac_unit #(.DATA_WIDTH(DATA_WIDTH),.COEFF_WIDTH(COEFF_WIDTH),.ACC_WIDTH(ACC_WIDTH)) m6(p20,w20,s5,s6);
    mac_unit #(.DATA_WIDTH(DATA_WIDTH),.COEFF_WIDTH(COEFF_WIDTH),.ACC_WIDTH(ACC_WIDTH)) m7(p21,w21,s6,s7);
    mac_unit #(.DATA_WIDTH(DATA_WIDTH),.COEFF_WIDTH(COEFF_WIDTH),.ACC_WIDTH(ACC_WIDTH)) m8(p22,w22,s7,s8);

    wire signed [DATA_WIDTH-1:0] q_out;
    relu_quantizer #(.ACC_WIDTH(ACC_WIDTH),.OUT_WIDTH(DATA_WIDTH),.FRAC_BITS(FRAC_BITS)) q0(.acc_in(s8),.data_out(q_out));

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid_out <= 1'b0;
            data_out <= 0;
            acc_debug <= 0;
        end else begin
            valid_out <= valid_in;
            if (valid_in) begin
                data_out <= q_out;
                acc_debug <= s8;
            end
        end
    end
endmodule
