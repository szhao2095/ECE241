vlib work
vlog part2.v
vsim part2
log {/*}
add wave {/*}

#Sw[7:0] data_in

#KEY[0] synchronous reset when pressed
#KEY[1] go signal

#LEDR displays result
#HEX0 & HEX1 also displays result

force -deposit /CLOCK_50 1 0, 0 {1 ps} -repeat 2

force {KEY[1:0]} 11
run 5 ns

force {KEY[1:0]} 10
run 5 ns

force {KEY[1:0]} 11
force {SW[7:0]} 00000010
run 5 ns

force {KEY[1:0]} 01
force {SW[7:0]} 00000010
run 5 ns

force {KEY[1:0]} 11
force {SW[7:0]} 00000100
run 5 ns

force {KEY[1:0]} 01
force {SW[7:0]} 00000100
run 5 ns

force {KEY[1:0]} 11
force {SW[7:0]} 00000001
run 5 ns

force {KEY[1:0]} 01
force {SW[7:0]} 00000001
run 5 ns

force {KEY[1:0]} 11
force {SW[7:0]} 00001000
run 5 ns

force {KEY[1:0]} 01
force {SW[7:0]} 00001000
run 5 ns

force {KEY[1:0]} 11
force {SW[7:0]} 00001110
run 5 ns

force {KEY[1:0]} 01
force {SW[7:0]} 00001110
run 5 ns

force {KEY[1:0]} 11
force {SW[7:0]} 00000100
run 5 ns

force {KEY[1:0]} 01
force {SW[7:0]} 00000100
run 5 ns

force {KEY[1:0]} 11
force {SW[7:0]} 00010001
run 5 ns

force {KEY[1:0]} 01
force {SW[7:0]} 00010001
run 5 ns

force {KEY[1:0]} 11
force {SW[7:0]} 00001000
run 5 ns

force {KEY[1:0]} 01
force {SW[7:0]} 00001000
run 5 ns

force {KEY[1:0]} 11
force {SW[7:0]} 00001000
run 5 ns

