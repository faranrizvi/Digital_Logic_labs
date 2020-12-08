# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog lab7part1sim.v

#load simulation using mux as the top level simulation module
vsim -L altera_mf_ver part1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# 5 test cases:

# load F into address F (we = 1)

force {SW[0]} 1       
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1
force {SW[8]} 0 
force {SW[9]} 1
force {KEY[0]} 1
run 10ns

#read data at address F (we = 0)

force {SW[0]} 0       
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1
force {SW[8]} 0 
force {SW[9]} 0
force {KEY[0]} 1
run 10ns

# load 4 into address F1 (we = 1)

force {SW[0]} 0       
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1
force {SW[8]} 1 
force {SW[9]} 1
force {KEY[0]} 1
run 10ns

#read data at address F1 (we = 0)

force {SW[0]} 0       
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1
force {SW[8]} 1 
force {SW[9]} 0
force {KEY[0]} 1
run 10ns

#read data at address 6 (we = 0) should have no data

force {SW[0]} 0       
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 0
force {SW[8]} 0 
force {SW[9]} 0
force {KEY[0]} 1
run 10ns

#when clock is 0

force {SW[0]} 1      
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 1
force {SW[6]} 0
force {SW[7]} 1
force {SW[8]} 0 
force {SW[9]} 1
force {KEY[0]} 0
run 10ns