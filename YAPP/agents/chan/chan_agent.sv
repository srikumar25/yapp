
class chan_agent extends uvm_agent;
	
	`uvm_component_utils(chan_agent)

chan_agent_cfg y_cfg;

chan_sequencer y_sqr;
chan_driver y_drv;
//chan_monitor y_mnr;

function new(string name="chan_agent",uvm_component parent);
	super.new("chan_agent",parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	y_sqr = chan_sequencer::type_id::create("y_sqr",this);
	y_drv = chan_driver::type_id::create("y_drv",this);
//	uvm_config_db#(chan_driver)::set(this,"*","y_drv",y_drv);
//	y_mnr = chan_monitor::type_id::create("y_mnr",this);
endfunction

function void connect_phase(uvm_phase phase);
	//super.connect_phase(phase);
	y_drv.seq_item_port.connect(y_sqr.seq_item_export);
endfunction

endclass
