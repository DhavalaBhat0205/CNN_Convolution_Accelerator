`timescale 1ns/1ps
module tb_conv3x3_core;
    reg clk; reg rst_n; reg valid_in;
    reg signed [7:0] p00,p01,p02,p10,p11,p12,p20,p21,p22;
    reg signed [7:0] w00,w01,w02,w10,w11,w12,w20,w21,w22;
    reg signed [23:0] bias;
    wire valid_out; wire signed [7:0] data_out; wire signed [23:0] acc_debug;

    conv3x3_core dut(
        .clk(clk), .rst_n(rst_n), .valid_in(valid_in),
        .p00(p00),.p01(p01),.p02(p02),.p10(p10),.p11(p11),.p12(p12),.p20(p20),.p21(p21),.p22(p22),
        .w00(w00),.w01(w01),.w02(w02),.w10(w10),.w11(w11),.w12(w12),.w20(w20),.w21(w21),.w22(w22),
        .bias(bias), .valid_out(valid_out), .data_out(data_out), .acc_debug(acc_debug)
    );

    always #5 clk = ~clk; // 100 MHz clock

    task apply_window;
        input signed [7:0] a0,a1,a2,a3,a4,a5,a6,a7,a8;
        begin
            @(negedge clk);
            p00=a0; p01=a1; p02=a2; p10=a3; p11=a4; p12=a5; p20=a6; p21=a7; p22=a8;
            valid_in=1'b1;
        end
    endtask

    initial begin
        $dumpfile("waveforms/vcd/conv3x3_core.vcd");
        $dumpvars(0,tb_conv3x3_core);
        clk=0; rst_n=0; valid_in=0; bias=0;
        // Sobel-like edge kernel in Q4.4: [-1 0 1; -2 0 2; -1 0 1]
        w00=-16; w01=0; w02=16; w10=-32; w11=0; w12=32; w20=-16; w21=0; w22=16;
        p00=0;p01=0;p02=0;p10=0;p11=0;p12=0;p20=0;p21=0;p22=0;
        repeat(3) @(negedge clk); rst_n=1;
        apply_window(8, 12, 20, 8, 12, 20, 8, 12, 20);
        apply_window(16,16,16,16,16,16,16,16,16);
        apply_window(32,24,16,32,24,16,32,24,16);
        apply_window(0,16,32,0,16,32,0,16,32);
        @(negedge clk); valid_in=0;
        repeat(6) @(negedge clk);
        $finish;
    end
endmodule
