`timescale 1ns/1ps
// Streaming wrapper used for project-level demonstration.
// A practical FPGA implementation would replace the explicit 3x3 input window
// with three line buffers and a sliding-window generator.
module conv3x3_stream_top #(
    parameter DATA_WIDTH = 8,
    parameter ACC_WIDTH = 24
)(
    input wire clk,
    input wire rst_n,
    input wire valid_in,
    input wire signed [DATA_WIDTH*9-1:0] pixel_window,
    input wire signed [DATA_WIDTH*9-1:0] weight_window,
    input wire signed [ACC_WIDTH-1:0] bias,
    output wire valid_out,
    output wire signed [DATA_WIDTH-1:0] data_out,
    output wire signed [ACC_WIDTH-1:0] acc_debug
);
    conv3x3_core dut(
        .clk(clk), .rst_n(rst_n), .valid_in(valid_in),
        .p00(pixel_window[8*9-1:8*8]), .p01(pixel_window[8*8-1:8*7]), .p02(pixel_window[8*7-1:8*6]),
        .p10(pixel_window[8*6-1:8*5]), .p11(pixel_window[8*5-1:8*4]), .p12(pixel_window[8*4-1:8*3]),
        .p20(pixel_window[8*3-1:8*2]), .p21(pixel_window[8*2-1:8*1]), .p22(pixel_window[8*1-1:8*0]),
        .w00(weight_window[8*9-1:8*8]), .w01(weight_window[8*8-1:8*7]), .w02(weight_window[8*7-1:8*6]),
        .w10(weight_window[8*6-1:8*5]), .w11(weight_window[8*5-1:8*4]), .w12(weight_window[8*4-1:8*3]),
        .w20(weight_window[8*3-1:8*2]), .w21(weight_window[8*2-1:8*1]), .w22(weight_window[8*1-1:8*0]),
        .bias(bias), .valid_out(valid_out), .data_out(data_out), .acc_debug(acc_debug)
    );
endmodule
