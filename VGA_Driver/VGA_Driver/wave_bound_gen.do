onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /bound_gen_testbench/clk
add wave -noupdate /bound_gen_testbench/reset
add wave -noupdate /bound_gen_testbench/start
add wave -noupdate /bound_gen_testbench/gameover
add wave -noupdate -radix unsigned /bound_gen_testbench/point
add wave -noupdate -radix unsigned -childformat {{{/bound_gen_testbench/dut/num[9]} -radix unsigned} {{/bound_gen_testbench/dut/num[8]} -radix unsigned} {{/bound_gen_testbench/dut/num[7]} -radix unsigned} {{/bound_gen_testbench/dut/num[6]} -radix unsigned} {{/bound_gen_testbench/dut/num[5]} -radix unsigned} {{/bound_gen_testbench/dut/num[4]} -radix unsigned} {{/bound_gen_testbench/dut/num[3]} -radix unsigned} {{/bound_gen_testbench/dut/num[2]} -radix unsigned} {{/bound_gen_testbench/dut/num[1]} -radix unsigned} {{/bound_gen_testbench/dut/num[0]} -radix unsigned}} -subitemconfig {{/bound_gen_testbench/dut/num[9]} {-radix unsigned} {/bound_gen_testbench/dut/num[8]} {-radix unsigned} {/bound_gen_testbench/dut/num[7]} {-radix unsigned} {/bound_gen_testbench/dut/num[6]} {-radix unsigned} {/bound_gen_testbench/dut/num[5]} {-radix unsigned} {/bound_gen_testbench/dut/num[4]} {-radix unsigned} {/bound_gen_testbench/dut/num[3]} {-radix unsigned} {/bound_gen_testbench/dut/num[2]} {-radix unsigned} {/bound_gen_testbench/dut/num[1]} {-radix unsigned} {/bound_gen_testbench/dut/num[0]} {-radix unsigned}} /bound_gen_testbench/dut/num
add wave -noupdate /bound_gen_testbench/dut/ps
add wave -noupdate /bound_gen_testbench/dut/ns
add wave -noupdate -radix unsigned /bound_gen_testbench/dut/counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6997 ps} 0}
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
WaveRestoreZoom {1739 ps} {2695 ps}
