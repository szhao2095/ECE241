vlib work
vlog part2.v
vsim part2
log {/*}
add wave {/*}

#simple reset to get registers to 0

force {SW[9]} 0
force {KEY[0]} 0
run 5ns

force {SW[9]} 0
force {KEY[0]} 1
run 5ns

#test simple addition of 0001 + 0000 and setting of register

force {SW[9]} 1
force {KEY[0]} 0
force {SW[3:0]} 0001
force {SW[8]} 0
force {KEY[3:1]} 000
run 5ns

force {SW[9]} 1
force {KEY[0]} 1
force {SW[3:0]} 0001
force {SW[8]} 0
force {KEY[3:1]} 000
run 5ns

#nonsense to test register holding info

force {SW[9]} 1
force {KEY[0]} 0
force {SW[3:0]} 1101
force {SW[8]} 0
force {KEY[3:1]} 011
run 5ns

force {SW[9]} 1
force {KEY[0]} 0
force {SW[3:0]} 0011
force {SW[8]} 0
force {KEY[3:1]} 100
run 5ns

force {SW[9]} 1
force {KEY[0]} 0
force {SW[3:0]} 1111
force {SW[8]} 0
force {KEY[3:1]} 111
run 5ns

#testing reset for register with junk input

force {SW[9]} 0
force {KEY[0]} 0
force {SW[3:0]} 1001
force {SW[8]} 0
force {KEY[3:1]} 010
run 5ns

#note that reset takes precedence

force {SW[9]} 0
force {KEY[0]} 1
force {SW[3:0]} 0111
force {SW[8]} 0
force {KEY[3:1]} 100
run 5ns

#assuming lab 3 part 3 functions work
#testing new function
#testing left shift of data by lower 4 bits of register
#register currently 0

force {SW[9]} 1
force {KEY[0]} 0
force {SW[3:0]} 0011
force {SW[8]} 0
force {KEY[3:1]} 100
run 5ns

#nothing happens as it should be
#now setting register to 1

force {SW[9]} 1
force {KEY[0]} 1
force {SW[3:0]} 0001
force {SW[8]} 0
force {KEY[3:1]} 000
run 5ns

#register currently 1

force {SW[9]} 1
force {KEY[0]} 0
force {SW[3:0]} 0011
force {SW[8]} 0
force {KEY[3:1]} 101
run 5ns

#successfully left shifted by 1
#setting register to 2

force {SW[9]} 1
force {KEY[0]} 1
force {SW[3:0]} 0001
force {SW[8]} 0
force {KEY[3:1]} 000
run 5ns

#register currently 2 or 0000 0010

force {SW[9]} 1
force {KEY[0]} 0
force {SW[3:0]} 0011
force {SW[8]} 0
force {KEY[3:1]} 101 	
run 50ns

#successfully left shifted by 2
#also successfully tested verilog * operator, 0011 * 0000 0010 = 0000 0110 or 3 * 2 = 6
#test for final case with nonsense input

force {SW[9]} 1
force {KEY[0]} 1
force {SW[3:0]} 0101
force {SW[8]} 0
force {KEY[3:1]} 111
run 5ns

#successfully maintained value in register
