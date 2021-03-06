vlib work
vlog part3.v vga_adapter.v vga_address_translator.v vga_controller.v vga_pll.v
vsim control
log {/*}
add wave {/*}

#sw 97 colour

#key 0 resetn

#input CLOCK_50, resetn, square_done, UpdateFrame;

force -deposit /CLOCK_50 1 0, 0 {100 ps} -repeat 200

force square_done 1
force UpdateFrame 0
force resetn 1
run 1 ns
force resetn 0
run 1 ns

force resetn 1
run 1 ns

force UpdateFrame 1
run 1 ns
force UpdateFrame 0
run 1 ns
force UpdateFrame 1
run 1 ns
force UpdateFrame 0
run 1 ns