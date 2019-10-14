

class chan_env extends uvm_env;
	`uvm_component_utils(chan_env)

//chan_agent y1_agt;
//chan_agent c1_agt;
//hbus_agent h1_agt;

function new(string name="chan_env",uvm_component parent);
	super.new(name, parent);
endfunction


virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	//y1_agt = chan_agent::type_id::create("y1_agt",this);
	//c1_agt = chan_agent::type_id::create("c1_agt",this);
	//h1_agt = hbus_agent::type_id::create("h1_agt",this);
endfunction

virtual function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
endfunction

task run_phase(uvm_phase phase);
endtask

endclass

