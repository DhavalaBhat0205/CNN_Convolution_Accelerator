set TOP conv3x3_core
set_app_var target_library "typical_45nm.db"
set_app_var link_library "* typical_45nm.db"
analyze -format verilog {../../rtl/mac_unit.v ../../rtl/relu_quantizer.v ../../rtl/conv3x3_core.v}
elaborate $TOP
current_design $TOP
link
create_clock -name clk -period 5.0 [get_ports clk]
set_input_delay 0.5 -clock clk [all_inputs]
set_output_delay 0.5 -clock clk [all_outputs]
compile_ultra
report_area  > ../reports/area_report_dc.rpt
report_timing -max_paths 10 > ../reports/timing_report_dc.rpt
report_power  > ../reports/power_report_dc.rpt
write -format verilog -hierarchy -output ../reports/conv3x3_core_mapped.v
