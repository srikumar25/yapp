
typedef uvm_sequencer#(chan_seq_item) chan_sequencer;

/*
class chan_sequencer extends uvm_sequencer;
	`uvm_component_utils(chan_env)

//chan_seq_item y1_item;

function new(string name="chan_env",uvm_component parent);
	super.new(name, parent);
endfunction


virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	//y1_item = chan_seq_item::type_id::create("y1_item");
endfunction

task run_phase(uvm_phase phase);
	//y1_item.randomize();
	//y1_item.print();
endtask

endclass
*/
