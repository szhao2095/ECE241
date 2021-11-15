vlib work
vlog part3.v
vsim part3
log {/*}
add wave {/*}

#sw 2~0 is for choosing character
#key 0 async active low
#key 1 single press for output

force -deposit /Clock_50 1 0, 0 {1 ns} -repeat 2

force {KEY[1]} 1
force {KEY[0]} 1
force {SW[2:0]} 101
run 10ns

force {KEY[1]} 1
force {KEY[0]} 0
force {SW[2:0]} 101
run 10ns

force {KEY[1]} 1
force {KEY[0]} 1
force {SW[2:0]} 101
run 50ns

force {KEY[1]} 0
force {KEY[0]} 1
force {SW[2:0]} 101
run 50ns

force {KEY[1]} 1
force {KEY[0]} 1
force {SW[2:0]} 101
run 150000ns

force {KEY[1]} 1
force {KEY[0]} 1
force {SW[2:0]} 000
run 50ns

force {KEY[1]} 0
force {KEY[0]} 1
force {SW[2:0]} 000
run 50ns

force {KEY[1]} 1
force {KEY[0]} 1
force {SW[2:0]} 000
run 150000ns

