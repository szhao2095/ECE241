vlib work
vlog part2.v vga_adapter.v vga_address_translator.v vga_controller.v vga_pll.v
vsim part2 -L altera_mf_ver
log {/*}
add wave {/*}

#sw 60 coord
#sw 97 colour

#key 0 resetn
#key 1 ~write
#key 2 ~blackscreen
#key 3 ~go

#input CLOCK_50, resetn, go, blackscreen, write;
#input [9:0] inputSW;

force -deposit /CLOCK_50 1 0, 0 {10 ps} -repeat 20

force {KEY[0]} 1 #force resetn 1
run 1 ns
force {KEY[0]} 0 #force resetn 0
force {KEY[3]} 1 #force go 0
force {KEY[1]} 1 #force write 0
force {KEY[2]} 1 #force blackscreen 0
force {SW[6:0]} 0000001 #force {inputSW[6:0]} 0000001
force {SW[9:7]} 101 #force {inputSW[9:7]} 101
run 1 ns

force {KEY[0]} 1 #force resetn 1

force {KEY[3]} 0 #force go 1
run 1 ns
force {KEY[3]} 1 #force go 0
run 1 ns

force {KEY[3]} 0 #force go 1
run 1 ns
force {KEY[3]} 1 #force go 0
run 1 ns

force {KEY[1]} 0 #force write 1
run 1 ns
force {KEY[1]} 1 #force write 0
run 10 ns

force {KEY[2]} 0 #force blackscreen 1
run 1 ns
force {KEY[2]} 1 #force blackscreen 0
run 5000 ns