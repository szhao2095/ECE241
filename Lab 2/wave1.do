onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mux/SW
add wave -noupdate /mux/LEDR
add wave -noupdate -label u {/mux/SW[0]}
add wave -noupdate -label v {/mux/SW[1]}
add wave -noupdate -label w {/mux/SW[2]}
add wave -noupdate -label x {/mux/SW[3]}
add wave -noupdate -label s0 {/mux/SW[8]}
add wave -noupdate -label s1 {/mux/SW[9]}
add wave -noupdate /mux/wire0
add wave -noupdate /mux/wire1
add wave -noupdate -label m {/mux/LEDR[0]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {50 ns} {1068 ns}
