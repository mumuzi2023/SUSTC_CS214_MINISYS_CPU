-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Mon May 22 19:31:14 2023
-- Host        : Gao running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/myCodes/vivado/computer_organization/SUSTC_CS214_MINISYS_CPU/Minisys_CPU/Minisys_CPU.srcs/sources_1/ip/cpuclk/cpuclk_stub.vhdl
-- Design      : cpuclk
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tfgg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpuclk is
  Port ( 
    single_cycle_cpu_clk : out STD_LOGIC;
    uart_clk : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end cpuclk;

architecture stub of cpuclk is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "single_cycle_cpu_clk,uart_clk,clk_in1";
begin
end;
