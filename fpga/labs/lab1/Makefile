##
## A first Makefile example to automate the Xilinx XSim simulation flow. 
##

## list of VHDL sources to be compiled
SOURCES := Inverter.vhd MUX_Inverter.vhd BufferTri.vhd tb_Inverter.vhd


## top-level module (testbench)
TOP := tb_Inverter


## some useful aliases
RM := rm -f -v
RMDIR := rm -rf -v


## compile VHDL sources (xvhdl)
compile:
	@xvhdl $(SOURCES) -log $@.log


## elaborate the design (xelab)
elaborate:
	@xelab -debug all $(TOP) -log $@.log


## run the simulation (xsim)
simulate: xsim.dir/work.$(TOP)
	@xsim -gui -tclbatch run.tcl work.$(TOP) -wdb $(TOP).wdb -log $@.log


## one-step compilation/elaboration/simulation
sim: compile elaborate simulate


## load waveforms into XSim GUI
waves: $(TOP).wdb
	@xsim -gui $(TOP).wdb -nolog


## delete all log files and simulation outputs
clean:
	@$(RM) *.log *.jou *.pb *.wdb *.wcfg *.str
	@$(RMDIR) xsim.dir .Xil
