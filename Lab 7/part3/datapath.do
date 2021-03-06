vlib work
vlog part3.v vga_adapter.v vga_address_translator.v vga_controller.v vga_pll.v
vsim datapath
log {/*}
add wave {/*}

#sw 97 colour

#key 0 resetn

#	input CLOCK_50, resetn, En_x_counter, En_y_counter, ld_colour, ld_direction, sel_colour, square_counter_enable;
#	input [2:0] inputSW;

force -deposit /CLOCK_50 1 0, 0 {10 ps} -repeat 20

force {inputSW[2:0]} 101
force ld_colour 1
force resetn 1
run 1 ns
force resetn 0
run 1 ns

force resetn 1

force En_x_counter 0
force En_y_counter 0
force ld_direction 0
force sel_colour 0
force square_counter_enable 0
run 1 ns

force En_x_counter 0
force En_y_counter 0
force ld_direction 0
force sel_colour 0
force square_counter_enable 1
run 10 ns

force En_x_counter 0
force En_y_counter 0
force ld_direction 0
force sel_colour 1
force square_counter_enable 1
run 1 ns

force En_x_counter 1
force En_y_counter 1
force ld_direction 0
force sel_colour 0
force square_counter_enable 0
run 12 ns

force En_x_counter 0
force En_y_counter 0
force ld_direction 1
force sel_colour 0
force square_counter_enable 0
run 1 ns