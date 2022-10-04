onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /scorekeeping_testbench/clk
add wave -noupdate /scorekeeping_testbench/dut/slow_clk
add wave -noupdate /scorekeeping_testbench/reset
add wave -noupdate /scorekeeping_testbench/dut/incr
add wave -noupdate -radix unsigned /scorekeeping_testbench/score
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {40600 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 187
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {35908 ps} {43556 ps}
