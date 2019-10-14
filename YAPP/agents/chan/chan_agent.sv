
`ifndef CHAN_AGENT
`define CHAN_AGENT

class chan_agent extends uvm_agent;
	
	`uvm_component_utils(chan_agent)

chan_agent_cfg c_cfg;

chan_sequencer c_sqr;
chan_driver c_drv;
chan_monitor c_mnr;

uvm_analysis_port #(chan_seq_item) c_ap;

function new(string name,uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	c_sqr = chan_sequencer::type_id::create("c_sqr",this);
	c_drv = chan_driver::type_id::create("c_drv",this);
	c_mnr = chan_monitor::type_id::create("c_mnr",this);
	//uvm_config_db#(chan_monitor)::set(this,"*","c_mnr",mnr)
	c_ap = new("c_ap",this);
endfunction

function void connect_phase(uvm_phase phase);
	//super.connect_phase(phase);
	c_drv.seq_item_port.connect(c_sqr.seq_item_export);
	c_mnr.c_ap.connect(c_ap);
endfunction

endclass

`endif
