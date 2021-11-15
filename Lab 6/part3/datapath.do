vlib work
vlog part3.v
vsim datapath
log {/*}
add wave {/*}

#input CLOCK_50, resetn, ld_a, ld_r, ld_Dividend, ld_Divisor, alu_select_a, new_A, new_Dividend;
#input [1:0] alu_op;
#input [3:0] Divisor, Dividend;

force -deposit /CLOCK_50 1 0, 0 {1 ps} -repeat 2

force resetn 1
run 5 ns

force resetn 0
run 5 ns

force resetn 1
force Divisor 0010
force Dividend 1010
force ld_a 0
force ld_r 0
force ld_Dividend 0
force ld_Divisor 0
force alu_select_a 0
force new_A 0
force new_Dividend 0
force alu_op 00
run 5 ns

force ld_a 1
force ld_r 0
force ld_Dividend 0
force ld_Divisor 0
run 5 ns
force ld_a 0
force ld_r 1
force ld_Dividend 0
force ld_Divisor 0
run 5 ns
force ld_a 0
force ld_r 0
force ld_Dividend 1
force ld_Divisor 0
run 5 ns
force ld_a 0
force ld_r 0
force ld_Dividend 0
force ld_Divisor 1
run 5 ns


force resetn 1
run 5 ns

force resetn 0
run 5 ns

force resetn 1
force Divisor 0011
force Dividend 0111
force ld_a 0
force ld_r 0
force ld_Dividend 0
force ld_Divisor 0
force alu_select_a 0
force new_A 0
force new_Dividend 0
force alu_op 00
run 5 ns

#state 000

force ld_a 1
force ld_r 1
force ld_Dividend 1
force ld_Divisor 1
force alu_select_a 0
force new_A 0
force new_Dividend 0
force alu_op 00
run 5 ns

#state 001

force ld_a 0
force ld_r 0
force ld_Dividend 0
force ld_Divisor 0
force alu_select_a 0
force new_A 0
force new_Dividend 0
force alu_op 00
run 5 ns

#state 010

force ld_a 0
force ld_r 0
force ld_Dividend 0
force ld_Divisor 0
force alu_select_a 0
force new_A 0
force new_Dividend 0
force alu_op 01
run 5 ns

#state 011

force ld_a 1
force ld_r 0
force ld_Dividend 1
force ld_Divisor 0
force alu_select_a 0
force new_A 1
force new_Dividend 1
force alu_op 00
run 5 ns

#state 100

force ld_a 0
force ld_r 0
force ld_Dividend 0
force ld_Divisor 0
force alu_select_a 1
force new_A 0
force new_Dividend 0
force alu_op 10
run 5 ns

#state 101

force ld_a 1
force ld_r 0
force ld_Dividend 1
force ld_Divisor 0
force alu_select_a 0
force new_A 1
force new_Dividend 1
force alu_op 00
run 5 ns

#state 110

force ld_a 0
force ld_r 0
force ld_Dividend 0
force ld_Divisor 0
force alu_select_a 1
force new_A 0
force new_Dividend 0
force alu_op 11
run 5 ns

#state 111

force ld_a 1
force ld_r 0
force ld_Dividend 0
force ld_Divisor 0
force alu_select_a 0
force new_A 1
force new_Dividend 0
force alu_op 00
run 5 ns

#state 2

force ld_a 0
force ld_r 0
force ld_Dividend 0
force ld_Divisor 0
force alu_select_a 0
force new_A 0
force new_Dividend 0
force alu_op 01
run 5 ns

force ld_a 1
force ld_r 0
force ld_Dividend 1
force ld_Divisor 0
force alu_select_a 0
force new_A 1
force new_Dividend 1
force alu_op 00
run 5 ns

#state 3

force ld_a 0
force ld_r 0
force ld_Dividend 0
force ld_Divisor 0
force alu_select_a 1
force new_A 0
force new_Dividend 0
force alu_op 10
run 5 ns

force ld_a 1
force ld_r 0
force ld_Dividend 1
force ld_Divisor 0
force alu_select_a 0
force new_A 1
force new_Dividend 1
force alu_op 00
run 5 ns

#state 4

force ld_a 0
force ld_r 0
force ld_Dividend 0
force ld_Divisor 0
force alu_select_a 1
force new_A 0
force new_Dividend 0
force alu_op 11
run 5 ns

force ld_a 1
force ld_r 0
force ld_Dividend 0
force ld_Divisor 0
force alu_select_a 0
force new_A 1
force new_Dividend 0
force alu_op 00
run 5 ns

#state 2

force ld_a 0
force ld_r 0
force ld_Dividend 0
force ld_Divisor 0
force alu_select_a 0
force new_A 0
force new_Dividend 0
force alu_op 01
run 5 ns

force ld_a 1
force ld_r 0
force ld_Dividend 1
force ld_Divisor 0
force alu_select_a 0
force new_A 1
force new_Dividend 1
force alu_op 00
run 5 ns

#state 3

force ld_a 0
force ld_r 0
force ld_Dividend 0
force ld_Divisor 0
force alu_select_a 1
force new_A 0
force new_Dividend 0
force alu_op 10
run 5 ns

force ld_a 1
force ld_r 0
force ld_Dividend 1
force ld_Divisor 0
force alu_select_a 0
force new_A 1
force new_Dividend 1
force alu_op 00
run 5 ns

#state 2

force ld_a 0
force ld_r 0
force ld_Dividend 0
force ld_Divisor 0
force alu_select_a 0
force new_A 0
force new_Dividend 0
force alu_op 01
run 5 ns

force ld_a 1
force ld_r 0
force ld_Dividend 1
force ld_Divisor 0
force alu_select_a 0
force new_A 1
force new_Dividend 1
force alu_op 00
run 5 ns

#state 3

force ld_a 0
force ld_r 0
force ld_Dividend 0
force ld_Divisor 0
force alu_select_a 1
force new_A 0
force new_Dividend 0
force alu_op 10
run 5 ns

force ld_a 1
force ld_r 0
force ld_Dividend 1
force ld_Divisor 0
force alu_select_a 0
force new_A 1
force new_Dividend 1
force alu_op 00
run 5 ns

#state 4

force ld_a 0
force ld_r 0
force ld_Dividend 0
force ld_Divisor 0
force alu_select_a 1
force new_A 0
force new_Dividend 0
force alu_op 11
run 5 ns

force ld_a 1
force ld_r 0
force ld_Dividend 0
force ld_Divisor 0
force alu_select_a 0
force new_A 1
force new_Dividend 0
force alu_op 00
run 5 ns

#state 1

force ld_a 1
force ld_r 1
force ld_Dividend 1
force ld_Divisor 1
force alu_select_a 0
force new_A 0
force new_Dividend 0
force alu_op 00
run 5 ns