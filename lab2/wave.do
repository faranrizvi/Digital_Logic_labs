# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part3code.v

#load simulation using mux as the top level simulation module
vsim part3

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
#run simulation for a few ns
run 10ns

#second test case, change input values and run for another 10ns
# SW[0] should control LED[0]
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
run 10ns

#third test case, change input values and run for another 10ns
# SW[0] should control LED[0]
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
run 10ns

#forth test case, change input values and run for another 10ns
# SW[0] should control LED[0]
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1
run 10ns

#fifth test case, change input values and run for another 10ns
# SW[0] should control LED[0]
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
run 10ns

#sixth test case, change input values and run for another 10ns
# SW[0] should control LED[0]
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
run 10ns




