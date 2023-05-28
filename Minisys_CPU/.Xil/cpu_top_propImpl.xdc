set_property SRC_FILE_INFO {cfile:d:/computer_organization/SUSTC_CS214_MINISYS_CPU/Minisys_CPU/Minisys_CPU.srcs/sources_1/ip/cpuclk/cpuclk.xdc rfile:../Minisys_CPU.srcs/sources_1/ip/cpuclk/cpuclk.xdc id:1 order:EARLY scoped_inst:cpuclk/inst} [current_design]
set_property SRC_FILE_INFO {cfile:D:/computer_organization/SUSTC_CS214_MINISYS_CPU/Minisys_CPU/Minisys_CPU.srcs/constrs_1/new/TEST_FOR_LED.xdc rfile:../Minisys_CPU.srcs/constrs_1/new/TEST_FOR_LED.xdc id:2} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1
set_property src_info {type:XDC file:2 line:80 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS33 [get_ports {led[23]}]
set_property src_info {type:XDC file:2 line:81 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS33 [get_ports {led[22]}]
set_property src_info {type:XDC file:2 line:82 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS33 [get_ports {led[21]}]
set_property src_info {type:XDC file:2 line:83 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS33 [get_ports {led[20]}]
set_property src_info {type:XDC file:2 line:84 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS33 [get_ports {led[19]}]
set_property src_info {type:XDC file:2 line:85 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS33 [get_ports {led[18]}]
set_property src_info {type:XDC file:2 line:86 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS33 [get_ports {led[17]}]
set_property src_info {type:XDC file:2 line:87 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS33 [get_ports {led[16]}]
set_property src_info {type:XDC file:2 line:96 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN K17 [get_ports {led[23]}]
set_property src_info {type:XDC file:2 line:106 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN N19 [get_ports {led[16]}]
set_property src_info {type:XDC file:2 line:107 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN N20 [get_ports {led[17]}]
set_property src_info {type:XDC file:2 line:108 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN L13 [get_ports {led[22]}]
set_property src_info {type:XDC file:2 line:109 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN M20 [get_ports {led[18]}]
set_property src_info {type:XDC file:2 line:110 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN K13 [get_ports {led[19]}]
set_property src_info {type:XDC file:2 line:111 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN K14 [get_ports {led[20]}]
set_property src_info {type:XDC file:2 line:112 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN M13 [get_ports {led[21]}]