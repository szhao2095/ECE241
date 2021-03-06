vlib work
vlog project_2048_game.v vga_adapter.v vga_address_translator.v vga_controller.v vga_pll.v GameRAM.v GameRAM2port.v
vsim handler -L altera_mf_ver
log {/*}
add wave {/*}

#input CLOCK_50,
#input resetn,
	
#input [3:0] sig_move,
	
#input [3:0] gameRAM_Addr_Display,


force -deposit /CLOCK_50 1 0, 0 {1 ps} -repeat 2

force sig_move 0000
force gameRAM_Addr_Display 0000
force enter 0

force resetn 1
run 1 ns
force resetn 0
run 1 ns
force resetn 1
run 1000 ns

force enter 1
run 100 ns

force gameRAM_Addr_Display 0000
run 1 ns
force gameRAM_Addr_Display 0001
run 1 ns
force gameRAM_Addr_Display 0010
run 1 ns
force gameRAM_Addr_Display 0011
run 1 ns
force gameRAM_Addr_Display 0100
run 1 ns
force gameRAM_Addr_Display 0101
run 1 ns
force gameRAM_Addr_Display 0110
run 1 ns
force gameRAM_Addr_Display 0111
run 1 ns
force gameRAM_Addr_Display 1000
run 1 ns
force gameRAM_Addr_Display 1001
run 1 ns
force gameRAM_Addr_Display 1010
run 1 ns
force gameRAM_Addr_Display 1011
run 1 ns
force gameRAM_Addr_Display 1100
run 1 ns
force gameRAM_Addr_Display 1101
run 1 ns
force gameRAM_Addr_Display 1110
run 1 ns
force gameRAM_Addr_Display 1111
run 1 ns

force sig_move 0100
run 1 ns
force sig_move 0000
run 2000 ns

force gameRAM_Addr_Display 0000
run 1 ns
force gameRAM_Addr_Display 0001
run 1 ns
force gameRAM_Addr_Display 0010
run 1 ns
force gameRAM_Addr_Display 0011
run 1 ns
force gameRAM_Addr_Display 0100
run 1 ns
force gameRAM_Addr_Display 0101
run 1 ns
force gameRAM_Addr_Display 0110
run 1 ns
force gameRAM_Addr_Display 0111
run 1 ns
force gameRAM_Addr_Display 1000
run 1 ns
force gameRAM_Addr_Display 1001
run 1 ns
force gameRAM_Addr_Display 1010
run 1 ns
force gameRAM_Addr_Display 1011
run 1 ns
force gameRAM_Addr_Display 1100
run 1 ns
force gameRAM_Addr_Display 1101
run 1 ns
force gameRAM_Addr_Display 1110
run 1 ns
force gameRAM_Addr_Display 1111
run 1 ns

force sig_move 0100
run 1 ns
force sig_move 0000
run 2000 ns

force gameRAM_Addr_Display 0000
run 1 ns
force gameRAM_Addr_Display 0001
run 1 ns
force gameRAM_Addr_Display 0010
run 1 ns
force gameRAM_Addr_Display 0011
run 1 ns
force gameRAM_Addr_Display 0100
run 1 ns
force gameRAM_Addr_Display 0101
run 1 ns
force gameRAM_Addr_Display 0110
run 1 ns
force gameRAM_Addr_Display 0111
run 1 ns
force gameRAM_Addr_Display 1000
run 1 ns
force gameRAM_Addr_Display 1001
run 1 ns
force gameRAM_Addr_Display 1010
run 1 ns
force gameRAM_Addr_Display 1011
run 1 ns
force gameRAM_Addr_Display 1100
run 1 ns
force gameRAM_Addr_Display 1101
run 1 ns
force gameRAM_Addr_Display 1110
run 1 ns
force gameRAM_Addr_Display 1111
run 1 ns
