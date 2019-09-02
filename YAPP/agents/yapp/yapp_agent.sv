
class yapp_agent extends uvm_agent;
	
	`uvm_component_utils(yapp_agent)

yapp_agent_cfg y_cfg;

yapp_sequencer y_sqr;
yapp_driver y_drv;
//yapp_monitor y_mnr;

function new(string name="yapp_agent",uvm_component parent);
	super.new("yapp_agent",parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	y_sqr = yapp_sequencer::type_id::create("y_sqr",this);
	y_drv = yapp_driver::type_id::create("y_drv",this);
//	uvm_config_db#(yapp_driver)::set(this,"*","y_drv",y_drv);
//	y_mnr = yapp_monitor::type_id::create("y_mnr",this);
endfunction

function void connect_phase(uvm_phase phase);
	//super.connect_phase(phase);
	y_drv.seq_item_port.connect(y_sqr.seq_item_export);
endfunction

endclass
