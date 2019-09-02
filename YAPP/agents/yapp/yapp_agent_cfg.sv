

class yapp_agent_cfg extends uvm_object;
	`uvm_object_utils(yapp_agent_cfg)

virtual common c1_vif;
virtual yapp_if y1_vif;
yapp_driver y_drv;

function new(string name="yapp_agent_cfg");
	super.new(name);
	//y_agt = yapp_agent::type_id::create("y_agt",this);
	//y_drv = yapp_driver::type_id::create("y_drv",this);
endfunction

function void build_phase(uvm_phase phase);
//	super.build_phase(phase);
/*	if(!uvm_config_db#(virtual yapp_if)::get(this,"","y1_vif",y1_vif))
		`uvm_fatal("YAPP_DRV","Failed to get virtual yapp interface ")
	if(!uvm_config_db#(virtual common)::get(this,"","c1_vif",c1_vif))
		`uvm_fatal("YAPP_DRV","Failed to get virtual common interface ") */
endfunction

task run_phase(uvm_phase phase);
endtask

endclass

