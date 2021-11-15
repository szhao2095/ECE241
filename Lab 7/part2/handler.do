vlib work
vlog part2.v vga_adapter.v vga_address_translator.v vga_controller.v vga_pll.v
vsim handler
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

force -deposit /CLOCK_50 1 0, 0 {100 ps} -repeat 200

force resetn 1
run 1 ns
force resetn 0
force go 0
force write 0
force blackscreen 0
force {inputSW[6:0]} 0000001
force {inputSW[9:7]} 101
run 1 ns

force resetn 1

force go 1
run 1 ns
force go 0
run 1 ns

force go 1
run 1 ns
force go 0
run 1 ns

force write 1 
run 1 ns
force write 0 
run 10 ns

force blackscreen 1 
run 1 ns
force blackscreen 0 
run 5 ns