vlib work
vlog part3.v
vsim part3
log {/*}
add wave {/*}

#SW[7:0] //DATA_IN for parallel loading
#SW[9] //Synchronous active high reset i.e. 1 to reset
#KEY[0] //Clock
#KEY[1] //ParallelLoadn, 0 to parallel load i.e. push button
#KEY[2] //RotateRight, 0 to shift bits left i.e. push button to rotate LEFT LMAO
#KEY[3] //ASRight, 0 Arithmetic Shift, only works for right shifts i.e. push button

#proof of synchronous active high reset

force {SW[9]} 0
force {KEY[0]} 1
run 5ns

force {KEY[0]} 0
run 5ns

#simple reset to get registers to 0

force {SW[9]} 1
force {KEY[0]} 1
run 5ns

#testing parallel loading

force {SW[7:0]} 00001111
force {SW[9]} 0
force {KEY[0]} 0
force {KEY[1]} 0
run 5 ns

force {SW[7:0]} 00001111
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 0
run 5 ns

#changing initial loading

force {SW[7:0]} 01101001
force {SW[9]} 0
force {KEY[0]} 0
force {KEY[1]} 0
run 5 ns

force {SW[7:0]} 01101001
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 0
run 5 ns

#successfully tested parallel loading
#testing ParallelLoadn = 1, RotateRight = 1 and ASRight = 0
#DATA_IN set to zero to see if it changes anything, it shouldn't

force {SW[7:0]} 00000000 
force {SW[9]} 0
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 0
run 10 ns

force {SW[7:0]} 00000000
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 0
run 5 ns


force {SW[7:0]} 00000000 
force {SW[9]} 0
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 0
run 5 ns

force {SW[7:0]} 00000000
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 0
run 5 ns


force {SW[7:0]} 00000000 
force {SW[9]} 0
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 0
run 5 ns

force {SW[7:0]} 00000000
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 0
run 5 ns


force {SW[7:0]} 00000000 
force {SW[9]} 0
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 0
run 5 ns

force {SW[7:0]} 00000000
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 0
run 5 ns

#successfully tested ParallelLoadn = 1, RotateRight = 1 and ASRight = 0
#testing ParallelLoadn = 1, RotateRight = 1 and ASRight = 1

force {SW[7:0]} 00000000 
force {SW[9]} 0
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1
run 10 ns

force {SW[7:0]} 00000000
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1
run 5 ns

force {SW[7:0]} 00000000 
force {SW[9]} 0
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1
run 5 ns

force {SW[7:0]} 00000000
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1
run 5 ns

force {SW[7:0]} 00000000 
force {SW[9]} 0
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1
run 5 ns

force {SW[7:0]} 00000000
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1
run 5 ns

force {SW[7:0]} 00000000 
force {SW[9]} 0
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1
run 5 ns

force {SW[7:0]} 00000000
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1
run 5 ns

#changing initial loading, same as before

force {SW[7:0]} 01101001
force {SW[9]} 0
force {KEY[0]} 0
force {KEY[1]} 0
run 5 ns

force {SW[7:0]} 01101001
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 0
run 5 ns

#successfully tested  ParallelLoadn = 1, RotateRight = 1 and ASRight = 1
#testing ParallelLoadn = 1 and RotateRight = 0, ASRight ignored

force {SW[7:0]} 00000000 
force {SW[9]} 0
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 0
run 10 ns

force {SW[7:0]} 00000000
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 0
run 5 ns

force {SW[7:0]} 00000000 
force {SW[9]} 0
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 0
run 5 ns

force {SW[7:0]} 00000000
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 0
run 5 ns

force {SW[7:0]} 00000000 
force {SW[9]} 0
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 0
run 5 ns

force {SW[7:0]} 00000000
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 0
run 5 ns

force {SW[7:0]} 00000000 
force {SW[9]} 0
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 0
run 5 ns

force {SW[7:0]} 00000000
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 0
run 5 ns

#successfully tested ParallelLoadn = 1 and RotateRight = 0, ASRight ignored