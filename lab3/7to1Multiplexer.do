# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog lab3part1.v

#load simulation using mux as the top level simulation module
vsim part1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {SW[0]} 1
force {SW[7]} 0
force {SW[8]} 0
force {SW[9]} 0
#run simulation for a few ns
run 10ns

# second test case
#set input values using the force command, signal names need to be in {} brackets
force {SW[2]} 1
force {SW[7]} 0
force {SW[8]} 1
force {SW[9]} 0
#run simulation for a few ns
run 10ns


# third test case
#set input values using the force command, signal names need to be in {} brackets
force {SW[5]} 1
force {SW[7]} 0
force {SW[8]} 1
force {SW[9]} 1
#run simulation for a few ns
run 10ns

# forth test case
#set input values using the force command, signal names need to be in {} brackets
force {SW[3]} 1
force {SW[7]} 1
force {SW[8]} 1
force {SW[9]} 0
#run simulation for a few ns
run 10ns
