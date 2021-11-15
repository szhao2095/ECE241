vlib work
vlog part3.v vga_adapter.v vga_address_translator.v vga_controller.v vga_pll.v
vsim FrameCounter
log {/*}
add wave {/*}

#sw 97 colour

#key 0 resetn

#module FrameCounter(CLOCK_50, resetn, CLOCK_60HZ, UpdateFrame);

force -deposit /CLOCK_50 1 0, 0 {1 ps} -repeat 2

force resetn 1
run 1 ns
force resetn 0
run 1 ns

force resetn 1
run 1 ns

force CLOCK_60HZ 1
run 1 ps
force CLOCK_60HZ 0
run 1 ns

force CLOCK_60HZ 1
run 1 ps
force CLOCK_60HZ 0
run 1 ns

force CLOCK_60HZ 1
run 1 ps
force CLOCK_60HZ 0
run 1 ns

force CLOCK_60HZ 1
run 1 ps
force CLOCK_60HZ 0
run 1 ns

force CLOCK_60HZ 1
run 1 ps
force CLOCK_60HZ 0
run 1 ns

force CLOCK_60HZ 1
run 1 ps
force CLOCK_60HZ 0
run 1 ns

force CLOCK_60HZ 1
run 1 ps
force CLOCK_60HZ 0
run 1 ns

force CLOCK_60HZ 1
run 1 ps
force CLOCK_60HZ 0
run 1 ns

force CLOCK_60HZ 1
run 1 ps
force CLOCK_60HZ 0
run 1 ns

force CLOCK_60HZ 1
run 1 ps
force CLOCK_60HZ 0
run 1 ns

force CLOCK_60HZ 1
run 1 ps
force CLOCK_60HZ 0
run 1 ns

force CLOCK_60HZ 1
run 1 ps
force CLOCK_60HZ 0
run 1 ns

force CLOCK_60HZ 1
run 1 ps
force CLOCK_60HZ 0
run 1 ns

force CLOCK_60HZ 1
run 1 ps
force CLOCK_60HZ 0
run 1 ns

force CLOCK_60HZ 1
run 1 ps
force CLOCK_60HZ 0
run 1 ns

force CLOCK_60HZ 1
run 1 ps
force CLOCK_60HZ 0
run 1 ns

force CLOCK_60HZ 1
run 1 ps
force CLOCK_60HZ 0
run 1 ns
