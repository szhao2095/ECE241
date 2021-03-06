vlib work
vlog part2.v vga_adapter.v vga_address_translator.v vga_controller.v vga_pll.v
vsim datapath
log {/*}
add wave {/*}

#sw 60 coord
#sw 97 colour

#key 0 resetn
#key 1 ~write
#key 2 ~blackscreen
#key 3 ~go

#input CLOCK_50, resetn, ld_x, ld_y, ld_colour, sel_xy_out, sel_colour, square_counter_enable, blackscreen_counter_enable, writeEn;

force -deposit /CLOCK_50 1 0, 0 {100 ps} -repeat 200

force resetn 1
run 1 ns
force resetn 0
force ld_x 0
force ld_y 0
force ld_colour 1
force sel_xy_out 0
force sel_colour 0
force square_counter_enable 0
force blackscreen_counter_enable 0
force writeEn 0
run 1 ns

force {inputSW[6:0]} 0000000
force {inputSW[9:7]} 101
force resetn 1

force ld_x 1
force ld_y 0
force ld_colour 1
force sel_xy_out 0
force sel_colour 0
force square_counter_enable 0
force blackscreen_counter_enable 0
force writeEn 0
run 1 ns

force ld_x 0
force ld_y 0
force ld_colour 1
force sel_xy_out 0
force sel_colour 0
force square_counter_enable 0
force blackscreen_counter_enable 0
force writeEn 0
run 1 ns

force ld_x 0
force ld_y 1
force ld_colour 1
force sel_xy_out 0
force sel_colour 0
force square_counter_enable 0
force blackscreen_counter_enable 0
force writeEn 0
run 1 ns

force ld_x 0
force ld_y 0
force ld_colour 1
force sel_xy_out 0
force sel_colour 0
force square_counter_enable 0
force blackscreen_counter_enable 0
force writeEn 0
run 1 ns

force ld_x 0
force ld_y 0
force ld_colour 1
force sel_xy_out 0
force sel_colour 0
force square_counter_enable 1
force blackscreen_counter_enable 0
force writeEn 1
run 5 ns

force ld_x 0
force ld_y 0
force ld_colour 1
force sel_xy_out 1
force sel_colour 1
force square_counter_enable 0
force blackscreen_counter_enable 1
force writeEn 1
run 1000 ns
