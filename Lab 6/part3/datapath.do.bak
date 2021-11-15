vlib work
vlog part2.v
vsim datapath
log {/*}
add wave {/*}

#Sw[7:0] data_in

#KEY[0] synchronous reset when pressed
#KEY[1] go signal

#LEDR displays result
#HEX0 & HEX1 also displays result

force -deposit /clk 1 0, 0 {1 ps} -repeat 2

force resetn 1
run 5 ns

force resetn 0
run 5 ns

force resetn 1
force ld_alu_out 0
force data_in 00001010
force ld_a 1
run 5 ns

force data_in 00001010
force ld_a 0
run 5 ns

force data_in 00001010
force ld_b 1
run 5 ns

force data_in 00001010
force ld_b 0
run 5 ns

force data_in 00001010
force ld_c 1
run 5 ns

force data_in 00001010
force ld_c 0
run 5 ns

force data_in 00001010
force ld_x 1
run 5 ns

force data_in 00001010
force ld_x 0
run 5 ns

force alu_select_a 00
force alu_select_b 00
run 5 ns

force alu_op 1
run 5 ns



force resetn 1
run 5 ns

force resetn 0
run 5 ns

force resetn 1
force ld_alu_out 0
force data_in 00001010
force ld_a 1
run 5 ns

force data_in 00001010
force ld_a 0
run 5 ns

force data_in 00001010
force ld_b 1
run 5 ns

force data_in 00001010
force ld_b 0
run 5 ns

force data_in 00001010
force ld_c 1
run 5 ns

force data_in 00001010
force ld_c 0
run 5 ns

force data_in 00001010
force ld_x 1
run 5 ns

force data_in 00001010
force ld_x 0
run 5 ns

force ld_alu_out 1
force ld_a 1
force alu_op 1
force alu_select_a 00
force alu_select_b 00
run 5 ns
