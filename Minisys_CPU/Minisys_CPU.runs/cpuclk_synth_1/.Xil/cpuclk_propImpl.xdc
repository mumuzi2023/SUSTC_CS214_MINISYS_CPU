set_property SRC_FILE_INFO {cfile:d:/myCodes/vivado/computer_organization/SUSTC_CS214_MINISYS_CPU/Minisys_CPU/Minisys_CPU.srcs/sources_1/ip/cpuclk/cpuclk.xdc rfile:../../../Minisys_CPU.srcs/sources_1/ip/cpuclk/cpuclk.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1
