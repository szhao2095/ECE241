vlib work

vlog mux.v

vsim mux

log {/*}
add wave {/*}

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[8]} 0
force {SW[9]} 0
run 50ns

force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[8]} 0
force {SW[9]} 0
run 50ns

force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
force {SW[8]} 0
force {SW[9]} 0
run 50ns

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[8]} 0
force {SW[9]} 0
run 50ns

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[8]} 0
force {SW[9]} 0
run 50ns

#change switches

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[8]} 1
force {SW[9]} 0
run 50ns

force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[8]} 1
force {SW[9]} 0
run 50ns

force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
force {SW[8]} 1
force {SW[9]} 0
run 50ns

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[8]} 1
force {SW[9]} 0
run 50ns

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[8]} 1
force {SW[9]} 0
run 50ns

#change switches

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[8]} 0
force {SW[9]} 1
run 50ns

force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[8]} 0
force {SW[9]} 1
run 50ns

force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
force {SW[8]} 0
force {SW[9]} 1
run 50ns

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[8]} 0
force {SW[9]} 1
run 50ns

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[8]} 0
force {SW[9]} 1
run 50ns

#change switches

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[8]} 1
force {SW[9]} 1
run 50ns

force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[8]} 1
force {SW[9]} 1
run 50ns

force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
force {SW[8]} 1
force {SW[9]} 1
run 50ns

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[8]} 1
force {SW[9]} 1
run 50ns

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[8]} 1
force {SW[9]} 1
run 50ns

