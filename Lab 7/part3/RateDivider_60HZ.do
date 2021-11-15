vlib work
vlog part3.v vga_adapter.v vga_address_translator.v vga_controller.v vga_pll.v
vsim RateDivider_60HZ
log {/*}
add wave {/*}

#sw 97 colour

#key 0 resetn

#module RateDivider_60HZ(CLOCK_50, resetn, CLOCK_60HZ);

force -deposit /CLOCK_50 1 0, 0 {1 ps} -repeat 2

force resetn 1
run 1 ns
force resetn 0
run 1 ns

force resetn 1
run 10 ns