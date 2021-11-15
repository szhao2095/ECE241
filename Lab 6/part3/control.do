vlib work
vlog part3.v
vsim control
log {/*}
add wave {/*}

force -deposit /CLOCK_50 1 0, 0 {1 ps} -repeat 2

force resetn 1
run 5 ns

force resetn 0 
run 5 ns

force resetn 1
force go 0
force MSB_A 1
run 5 ns

force go 1
run 5 ns
force go 0
run 5 ns
