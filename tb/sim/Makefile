# Makefile for compiling and running simulation using Mentor QuestaSim

# File locations
RTL_DIR = ../../rtl
TB_TOP_DIR = ../top

# File list
TOP_SRCS = $(RTL_DIR)/design.sv $(TB_TOP_DIR)/testbench.sv

# Test name
TESTNAME = cfs_algn_test_random

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

# Run simulation
run:
	@echo "[Running Simulation...]" | tee $(SIM_LOG)
	@vsim -coverage -c -do "run -all; quit" work.testbench +UVM_TESTNAME=$(TESTNAME) +UVM_VERBOSITY=UVM_MEDIUM | tee -a $(SIM_LOG) | tee -a $(TRANSCRIPT)

# Clean up artifacts
clean:
	rm -rf $(WORKLIB) $(COMP_LOG) $(SIM_LOG) $(TRANSCRIPT) vsim.wlf

.PHONY: all comp run clean
