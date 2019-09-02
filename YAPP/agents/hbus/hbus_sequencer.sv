
typedef uvm_sequencer#(hbus_seq_item) hbus_sequencer;

/*
class hbus_sequencer extends uvm_sequencer;
	`uvm_component_utils(hbus_env)

//hbus_seq_item y1_item;

function new(string name="hbus_env",uvm_component parent);
	super.new(name, parent);
endfunction


virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	//y1_item = hbus_seq_item::type_id::create("y1_item");
endfunction

task run_phase(uvm_phase phase);
	//y1_item.randomize();
	//y1_item.print();
endtask

endclass
*/
