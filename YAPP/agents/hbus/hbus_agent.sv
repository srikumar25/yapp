
class hbus_agent extends uvm_agent;
	
	`uvm_component_utils(hbus_agent)

hbus_agent_cfg y_cfg;

hbus_sequencer h_sqr;
hbus_driver h_drv;
//hbus_monitor h_mnr;

function new(string name,uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	h_sqr = hbus_sequencer::type_id::create("h_sqr",this);
	h_drv = hbus_driver::type_id::create("h_drv",this);
//	uvm_config_db#(hbus_driver)::set(this,"*","y_drv",y_drv);
//	y_mnr = hbus_monitor::type_id::create("y_mnr",this);
endfunction

function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	h_drv.seq_item_port.connect(h_sqr.seq_item_export);
endfunction

endclass
