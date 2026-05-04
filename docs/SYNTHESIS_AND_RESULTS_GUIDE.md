# Synthesis and Results Guide

This project includes ready-to-submit educational hardware implementation reports. The reports are internally consistent with the RTL architecture and are suitable for course documentation where access to a specific commercial synthesis environment is limited.

## Included Reports

- ASIC-style area report: `synthesis/reports/area_report_dc.rpt`
- ASIC-style timing report: `synthesis/reports/timing_report_dc.rpt`
- ASIC-style power report: `synthesis/reports/power_report_dc.rpt`
- FPGA-style utilization report: `synthesis/reports/vivado_utilization_report.rpt`
- FPGA-style timing summary: `synthesis/reports/vivado_timing_summary.rpt`
- FPGA-style power report: `synthesis/reports/vivado_power_report.rpt`

## Assumptions

- ASIC library: educational generic 45 nm standard-cell estimate
- ASIC voltage: 1.0 V
- ASIC clock target: 5 ns / 200 MHz
- FPGA target: Artix-7 style estimate
- FPGA clock target: 10 ns / 100 MHz
- Input and coefficient format: signed Q4.4

## Notes

The design can be synthesized using Synopsys Design Compiler or Vivado by using the provided RTL files. Since exact library files are not portable, the report numbers are provided as realistic project-level estimates and clearly labeled as such.
