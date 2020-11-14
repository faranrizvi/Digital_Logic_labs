# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog lab3part3.v

#load simulation using mux as the top level simulation module
vsim part3

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# ripple carry test case 1
#set input values using the force command, signal names need to be in {} brackets
force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 0
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 0

#run simulation for a few ns
run 10ns

# ripple carry test case 2
#set input values using the force command, signal names need to be in {} brackets
force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 0
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1

#run simulation for a few ns
run 10ns

# ripple carry test case 2
#set input values using the force command, signal names need to be in {} brackets
force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 0
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1

#run simulation for a few ns
run 10ns

# A + B test case 
#set input values using the force command, signal names need to be in {} brackets
force {KEY[0]} 1
force {KEY[1]} 0
force {KEY[2]} 0
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 1

#run simulation for a few ns
run 10ns

# B bit extension test case 
#set input values using the force command, signal names need to be in {} brackets
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 0
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1

#run simulation for a few ns
run 10ns

# 011 test case 
#set input values using the force command, signal names need to be in {} brackets
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 1
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1

#run simulation for a few ns
run 10ns

# 100 test case 1
#set input values using the force command, signal names need to be in {} brackets
force {KEY[0]} 1
force {KEY[1]} 0
force {KEY[2]} 0
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1

#run simulation for a few ns
run 10ns

# 100 test case 2
#set input values using the force command, signal names need to be in {} brackets
force {KEY[0]} 1
force {KEY[1]} 0
force {KEY[2]} 0
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1

#run simulation for a few ns
run 10ns

# concatonate test case 
#set input values using the force command, signal names need to be in {} brackets
force {KEY[0]} 1
force {KEY[1]} 0
force {KEY[2]} 1
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 0

#run simulation for a few ns
run 10ns



