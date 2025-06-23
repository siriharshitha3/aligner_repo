# Makefile for compiling and running simulation using Mentor QuestaSim

# File locations
RTL_DIR = ../../rtl
TB_TOP_DIR = ../top

# File list
TOP_SRCS = $(RTL_DIR)/design.sv $(TB_TOP_DIR)/testbench.sv

# Test and UVM options
TESTNAME = cfs_algn_test_random
UVM_ARGS = +UVM_TESTNAME=$(TESTNAME) +UVM_MAX_QUIT_COUNT=1 +uvm_set_verbosity=*,REG_PREDICT,UVM_HIGH,run +access +rw

# Simulation libraries
WORKLIB = work

# Log files
COMP_LOG = compile.log
SIM_LOG = sim.log
TRANSCRIPT = transcript

# Default target
all: comp run

# Compile target
comp:
	@echo "[Compiling...]" | tee $(COMP_LOG)
	@rm -rf $(WORKLIB)
	@vlib $(WORKLIB) | tee -a $(COMP_LOG)
	@vmap $(WORKLIB) $(WORKLIB) | tee -a $(COMP_LOG)
	@vlog -sv -cover bcest -work $(WORKLIB) $(TOP_SRCS) +acc +define+QUESTA +incdir+$(RTL_DIR) +incdir+$(TB_TOP_DIR) | tee -a $(COMP_LOG) | tee -a $(TRANSCRIPT)

# Run simulation (command-line mode)
run:
	@echo "[Running Simulation...]" | tee $(SIM_LOG)
	@vsim -coverage -c -do "run -all; quit" work.testbench $(UVM_ARGS) | tee -a $(SIM_LOG) | tee -a $(TRANSCRIPT)

# Launch GUI with all DUT signals preloaded
gui:
	@echo "[Launching QuestaSim GUI with waveforms...]"
	@vsim -coverage work.testbench $(UVM_ARGS) -do "do wave.do;"

# Clean up artifacts
clean:
	rm -rf $(WORKLIB) $(COMP_LOG) $(SIM_LOG) $(TRANSCRIPT) vsim.wlf

.PHONY: all comp run gui clean
