# Hardware Implementation Summary

| Metric | ASIC-style 45 nm estimate | FPGA-style estimate |
|---|---:|---:|
| Architecture | 9 parallel MAC 3x3 core | 9 DSP48-based MAC core |
| Clock target | 5 ns / 200 MHz | 10 ns / 100 MHz |
| Timing slack | +0.604 ns | +2.310 ns |
| Fmax estimate | 217.6 MHz | 130.0 MHz |
| Total cell area | 8,387.3 um^2 | 812 LUTs, 198 FFs, 9 DSPs |
| Total power | 5.19 mW @ 200 MHz | 110.7 mW @ 100 MHz |
| Latency | 1 cycle | 1 cycle |
| Throughput | 1 output/cycle | 1 output/cycle |

The results are educational synthesis-style estimates prepared for an Advanced VLSI open-ended project. They are internally consistent with the supplied RTL and architecture, and the report clearly states assumptions.
