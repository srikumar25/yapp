
PRJ_HOME = ..
#PRJ_HOME = /cygdrive/f/new_YAPP

DIRS = +incdir+${PRJ_HOME}/agents/hbus \
	+incdir+${PRJ_HOME}/agents/yapp \
	+incdir+${PRJ_HOME}/agents/chan \
	+incdir+${PRJ_HOME}/seq \
	+incdir+${PRJ_HOME}/test \
	+incdir+${PRJ_HOME}/common \
	+incdir+${PRJ_HOME}/rtl \
	+incdir+${PRJ_HOME}/tb 

I_DIRS = -incdir ${PRJ_HOME}/agents/hbus \
	-incdir ${PRJ_HOME}/agents/yapp \
	-incdir ${PRJ_HOME}/agents/chan \
	-incdir ${PRJ_HOME}/rtl \
	-incdir ${PRJ_HOME}/seq \
	-incdir ${PRJ_HOME}/test \
	-incdir ${PRJ_HOME}/common \
	-incdir ${PRJ_HOME}/tb 

${INTF}:
	${PRJ_HOME}/common/intf.sv \
	${PRJ_HOME}/agents/hbus/hbus_if.sv \
	${PRJ_HOME}/agents/yapp/yapp_if.sv \
	${PRJ_HOME}/agents/chan/chan_if.sv

${PKGS}:
	${PRJ_HOME}/agents/hbus/hbus_pkg.sv \
	${PRJ_HOME}/agents/chan/chan_pkg.sv \
	${PRJ_HOME}/agents/yapp/yapp_pkg.sv \
	${PRJ_HOME}/common/common_pkg.sv

compile:
#	vlib work
#	vmap work work
#	-- WORKING CMD 
# 	qrsh -V -cwd -verbose -q medium vlog -sv +uvm -l compile.log ${DIRS} +define+DATA=8 +define+ADDR=2 -F tb.f ${PRJ_HOME}/agents/yapp/yapp_pkg.sv ${PRJ_HOME}/common/common_pkg.sv ${PRJ_HOME}/tb/top.sv
#	-- END OF WORKING CMD 
	vlog -sv +uvm -l compile.log ${DIRS} ${PRJ_HOME}/common/common_pkg.sv ${PRJ_HOME}/agents/chan/chan_pkg.sv ${PRJ_HOME}/agents/hbus/hbus_pkg.sv ${PRJ_HOME}/agents/yapp/yapp_pkg.sv ${PRJ_HOME}/rtl/yapp_dut.v ${PRJ_HOME}/tb/top.sv

sim:
	#qrsh -V -cwd -verbose -q medium vsim -L ${PRJ_HOME}/sim/work work.top
	#vsim -i -vopt +access+rw -L ${PRJ_HOME}/sim/work work.top
	vsim -i -novopt -L ${PRJ_HOME}/sim/work work.top

clean:
	rm -rf INCA_libs/ *.log *.history *.dsn *.trn *.vcd *.vpd work modelsim.ini transcript

iclean:
	rm -rf INCA_libs/ *.log *.history *.dsn *.trn 

irun1: irun_dirs
	qrsh -V -cwd -verbose -q medium irun -sv -uvm +access+rw -disable_sem2009 +define+NCV -incdir ${PRJ_HOME}/common -incdir ${PRJ_HOME}/agents/yapp ${PRJ_HOME}/common/common_pkg.sv ${PRJ_HOME}/agents/yapp/yapp_pkg.sv ${PRJ_HOME}/rtl/yapp_dut.v ${PRJ_HOME}/tb/top.sv

irun: 
	qrsh -V -cwd -verbose -q medium irun -sv -uvm +access+rw -disable_sem2009 +define+NCV ${I_DIRS} ${PRJ_HOME}/rtl/yapp_dut.v ${PRJ_HOME}/common/common_pkg.sv ${PRJ_HOME}/agents/yapp/yapp_pkg.sv ${PRJ_HOME}/tb/top.sv
