vlib work
vlog part3.v
vsim part3
log {/*}
add wave {/*}

force -deposit /CLOCK_50 1 0, 0 {1 ps} -repeat 2

#sw 7:4 dividend
#sw 3:0 divisor
#key 0 reset SR AL
#key 1 Go

force {KEY[1:0]} 11
run 5 ns

force {KEY[1:0]} 10
run 5 ns

force {KEY[1:0]} 11
force {SW[7:0]} 01110011
run 5 ns

force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1
run 5 ns

force {KEY[1:0]} 11
force {SW[7:0]} 01110111
run 5 ns

force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1
run 5 ns

force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1
run 5 ns

force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1
run 5 ns

force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1
run 5 ns

force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1
run 5 ns

force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1
run 5 ns

force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1
run 5 ns

force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1
run 5 ns

force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1
run 5 ns

force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1
run 5 ns

force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1
run 5 ns

force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1
run 5 ns

force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1
run 5 ns
