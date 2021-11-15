vlib work

vlog hexdecoder.v

vsim hexdecoder

log {/*}
add wave {/*}

force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
run 50ns

force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
run 50ns

force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
run 50ns

force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
run 50ns

force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1
run 50ns

force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 0
run 50ns

force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1
run 50ns

force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 0
run 50ns

force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
run 50ns

force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
run 50ns

force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
run 50ns

force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
run 50ns

force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1
run 50ns

force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 0
run 50ns

force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1
run 50ns

force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 0
run 50ns

force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
run 50ns
