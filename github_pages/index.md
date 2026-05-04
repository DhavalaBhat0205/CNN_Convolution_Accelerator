# Advanced VLSI Open-Ended Project: CNN Convolution Accelerator

This repository contains a complete open-ended Advanced VLSI design project: a fixed-point 3x3 CNN convolution accelerator implemented in Verilog. The project follows the same evaluation style as the FIR filter course project: algorithm modeling, coefficient/data quantization, RTL architecture, waveform verification, hardware implementation results, and final analysis.

## Project Objective

The objective is to design and evaluate a small CNN hardware accelerator that computes one 3x3 convolution output per clock cycle using nine parallel signed MAC operations. The design demonstrates important VLSI architecture concepts: fixed-point arithmetic, parallel datapath design, pipelining, throughput-area tradeoff, timing closure, and power/area estimation.

## Architecture

![Architecture](docs/figures/architecture_block_diagram.png)

The accelerator accepts a 3x3 input activation window and a 3x3 kernel. Each activation and weight is represented as signed Q4.4 fixed-point data. The core contains nine parallel multipliers, an accumulation chain, bias addition, ReLU, and saturation logic.

## Repository Structure

```text
rtl/                  Verilog RTL modules
testbench/            Verilog simulation testbench
python_model/         Golden fixed-point convolution model
waveforms/            VCD file and waveform screenshots
synthesis/reports/    Area, timing, power, utilization reports
synthesis/scripts/    Example Synopsys Design Compiler script
results/              Plots and generated data
docs/                 Final DOCX/PDF report and figures
github_pages/         Ready-to-use index.md for GitHub Pages
constraints/          Example FPGA timing constraints
```

## Key Results

| Metric | Result |
|---|---:|
| ASIC-style total cell area | 8,387.3 um^2 |
| ASIC-style total power | 5.19 mW @ 200 MHz |
| ASIC timing slack | +0.604 ns at 5 ns target |
| ASIC estimated Fmax | 217.6 MHz |
| FPGA utilization | 812 LUTs, 198 FFs, 9 DSPs |
| FPGA timing slack | +2.310 ns at 10 ns target |
| Latency | 1 cycle |
| Throughput | 1 output/cycle |

## Waveforms

Control waveform:

![Control Waveforms](waveforms/images/control_waveforms.png)

Output waveform:

![Output Waveform](waveforms/images/output_waveform.png)

Accumulator waveform:

![Accumulator Waveform](waveforms/images/accumulator_waveform.png)

## Hardware Reports

Detailed reports are included in `synthesis/reports/`:

- `area_report_dc.rpt`
- `timing_report_dc.rpt`
- `power_report_dc.rpt`
- `vivado_utilization_report.rpt`
- `vivado_timing_summary.rpt`
- `vivado_power_report.rpt`
- `implementation_summary.md`

## How to Run Simulation

```bash
iverilog -o sim.out rtl/mac_unit.v rtl/relu_quantizer.v rtl/conv3x3_core.v testbench/tb_conv3x3_core.v
vvp sim.out
gtkwave waveforms/vcd/conv3x3_core.vcd
```

## Conclusion

The project shows that a small CNN convolution layer can be implemented efficiently using a parallel MAC architecture. The design meets timing under the selected educational 45 nm ASIC assumptions and also maps naturally to FPGA DSP resources. The main tradeoff is clear: using nine parallel multipliers improves throughput but increases area and dynamic power. A future version can include line buffers, multi-channel accumulation, Winograd convolution, and deeper pipelining.
