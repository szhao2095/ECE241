vlib work
vlog part3.v vga_adapter.v vga_address_translator.v vga_controller.v vga_pll.v
vsim handler
log {/*}
add wave {/*}

#sw 97 colour

#key 0 resetn

#	input CLOCK_50, resetn;
#	input [2:0] inputSW;

force -deposit /CLOCK_50 1 0, 0 {10 ps} -repeat 20

force {inputSW[2:0]} 101
force resetn 1
run 1 ns
force resetn 0
run 1 ns

force resetn 1
run 1000 ns