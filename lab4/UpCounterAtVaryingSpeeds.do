# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules to working dir
vlog lab5part2.v

# load simulation using the top level simulation module
vsim part2

# log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}
force {SW[9]} 0
force {SW[0]} 0
force {SW[1]} 0
force {CLOCK_50} 0 0ns , 1 {5ns} -r 10ns
run 1000000 ns

force {SW[9]} 1
force {SW[0]} 0
force {SW[1]} 1
force {CLOCK_50} 0 0ns , 1 {5ns} -r 10ns
run 1000000 ns

force {SW[9]} 1
force {SW[0]} 1
force {SW[1]} 0
force {CLOCK_50} 0 0ns , 1 {5ns} -r 10ns
run 1000000 ns

force {SW[9]} 1
force {SW[0]} 1
force {SW[1]} 1
force {CLOCK_50} 0 0ns , 1 {5ns} -r 10ns
run 1000000 ns



