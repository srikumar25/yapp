

class chan_agent_cfg extends uvm_object;
	`uvm_object_utils(chan_agent_cfg)

virtual common c1_vif;
virtual chan_if y1_vif;
int has_chan_driver;
int has_chan_sequencer; 
uvm_active_passive_enum chan_agt_active;

function new(string name="chan_agent_cfg");
	super.new(name);
endfunction

endclass

