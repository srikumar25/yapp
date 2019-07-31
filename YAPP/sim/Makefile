
${DIRS}:
	-incdir ../agents/hbus \
	-incdir ../agents/yapp \
	-incdir ../agents/chan \
	-incdir ../seq \
	-incdir ../test \
	-incdir ../common \
	-incdir ../tb \

${INTF}:
	../common/intf.sv \
	../agents/hbus/hbus_if.sv \
	../agents/yapp/yapp_if.sv \
	../agents/chan/chan_if.sv

${PKGS}:
	../agents/hbus/hbus_pkg.sv \
	../agents/yapp/yapp_pkg.sv \
	../agents/chan/chan_pkg.sv 

compile:
#	qrsh -V -cwd -verbose -q medium irun -sv -uvm +access+rw top.sv +define+NCV
#	qrsh -V -cwd -verbose -q medium irun -compile -sv -uvm +access+rw -disable_sem2009 +define+NCV -incdir ${DIRS} ../tb/top.sv
	qrsh -V -cwd -verbose -q medium ncvlog -sv ${DIRS} ${INTF} ${PKGS} ../tb/top.sv

clean:
	rm -rf INCA_libs/ *.log *.history *.dsn *.trn *.vcd *.vpd
