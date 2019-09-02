

class chan_agent_cfg extends uvm_object;
	`uvm_object_utils(chan_agent_cfg)

virtual common c1_vif;
virtual chan_if y1_vif;
chan_driver y_drv;

function new(string name="chan_agent_cfg");
	super.new(name);
	//y_agt = chan_agent::type_id::create("y_agt",this);
	//y_drv = chan_driver::type_id::create("y_drv",this);
endfunction

function void build_phase(uvm_phase phase);
//	super.build_phase(phase);
/*	if(!uvm_config_db#(virtual chan_if)::get(this,"","y1_vif",y1_vif))
		`uvm_fatal("YAPP_DRV","Failed to get virtual chan interface ")
	if(!uvm_config_db#(virtual common)::get(this,"","c1_vif",c1_vif))
		`uvm_fatal("YAPP_DRV","Failed to get virtual common interface ") */
endfunction

task run_phase(uvm_phase phase);
endtask

endclass

