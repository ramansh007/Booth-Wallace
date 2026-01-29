###############################################################################
# Created by write_sdc
###############################################################################
current_design Top
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 10.0000 [get_ports {clk}]
set_clock_uncertainty 0.1500 clk
set_propagated_clock [get_clocks {clk}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {A[0]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {A[1]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {A[2]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {A[3]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {A[4]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {A[5]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {A[6]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {A[7]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {B[0]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {B[1]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {B[2]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {B[3]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {B[4]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {B[5]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {B[6]}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {B[7]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Output[0]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Output[10]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Output[11]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Output[12]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Output[13]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Output[14]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Output[15]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Output[1]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Output[2]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Output[3]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Output[4]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Output[5]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Output[6]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Output[7]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Output[8]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {Output[9]}]
###############################################################################
# Environment
###############################################################################
###############################################################################
# Design Rules
###############################################################################
