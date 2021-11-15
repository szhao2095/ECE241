vlib work
vlog part1.v ram32x4.v
vsim part1 -L altera_mf_ver
log {/*}
add wave {/*}

#	ram32x4 ram1(
#		.data(SW[3:0]),
#		.address(SW[8:4]),
#		.wren(SW[9]),
#		.clock(KEY[0]),
#		.q(q)
#		);

force {SW[3:0]} 0000
force {SW[8:4]} 00000
force {SW[9]} 0

force {KEY[0]} 0
run 5 ns
force {KEY[0]} 1
run 5 ns
force {KEY[0]} 0
run 5 ns
force {KEY[0]} 1
run 5 ns
force {KEY[0]} 0
run 5 ns
force {KEY[0]} 1
run 5 ns

force {SW[3:0]} 0001
force {SW[8:4]} 00001
force {SW[9]} 1

force {KEY[0]} 0
run 5 ns
force {KEY[0]} 1
run 5 ns

force {SW[3:0]} 0010
force {SW[8:4]} 00010
force {SW[9]} 1

force {KEY[0]} 0
run 5 ns
force {KEY[0]} 1
run 5 ns

force {SW[3:0]} 0000
force {SW[8:4]} 00000
force {SW[9]} 0

force {KEY[0]} 0
run 5 ns
force {KEY[0]} 1
run 5 ns
force {KEY[0]} 0
run 5 ns
force {KEY[0]} 1
run 5 ns

force {SW[8:4]} 00010
force {KEY[0]} 0
run 10 ns
force {SW[8:4]} 00000
force {KEY[0]} 1
run 10 ns
force {SW[8:4]} 00010
force {KEY[0]} 0
run 10 ns
force {SW[8:4]} 00010
force {KEY[0]} 1
run 10 ns

force {SW[3:0]} 0000
force {SW[8:4]} 00001
force {SW[9]} 0

force {KEY[0]} 0
run 5 ns
force {KEY[0]} 1
run 5 ns

force {SW[3:0]} 0000
force {SW[8:4]} 00010
force {SW[9]} 0

force {KEY[0]} 0
run 5 ns
force {KEY[0]} 1
run 5 ns

force {SW[3:0]} 0000
force {SW[8:4]} 00011
force {SW[9]} 0

force {KEY[0]} 0
run 5 ns
force {KEY[0]} 1
run 5 ns
