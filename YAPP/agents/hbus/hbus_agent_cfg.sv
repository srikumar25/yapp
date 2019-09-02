

class hbus_agent_cfg extends uvm_object;
	`uvm_object_utils(hbus_agent_cfg)

//virtual hbus_if h1_vif;
//hbus_driver h_drv;

function new(string name="hbus_agent_cfg");
	super.new(name);
	//y_agt = hbus_agent::type_id::create("y_agt",this);
endfunction

/*function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	h_drv = hbus_driver::type_id::create("h_drv",this);
	if(!uvm_config_db#(virtual hbus_if)::get(this,"","y1_vif",y1_vif))
		`uvm_fatal("YAPP_DRV","Failed to get virtual hbus interface ")
	if(!uvm_config_db#(virtual common)::get(this,"","c1_vif",c1_vif))
		`uvm_fatal("YAPP_DRV","Failed to get virtual common interface ")
endfunction 

task run_phase(uvm_phase phase);
endtask */

endclass

