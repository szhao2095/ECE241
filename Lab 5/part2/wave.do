vlib work
vlog part2.v
vsim part2
log {/*}
add wave {/*}

#sw 5~2 is for loading in
#key 1 put to 0 for parallel load
#key 0 is clear active low
#sw 1~0 is for rate divider

force -deposit /Clock_50 1 0, 0 {1 ns} -repeat 2

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

force {KEY[0]} 1
force {SW[1:0]} 00
run 50000ns

force {KEY[0]} 1
force {SW[1:0]} 01
run 50000ns


force {KEY[0]} 1
force {SW[1:0]} 10
run 50000ns


force {KEY[0]} 1
force {SW[1:0]} 11
run 50000ns

