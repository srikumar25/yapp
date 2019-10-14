
//typedef uvm_sequencer#(chan_seq_item) chan_sequencer;


class chan_sequencer extends uvm_sequencer#(chan_seq_item);
	`uvm_component_utils(chan_sequencer)

//chan_seq_item y1_item;
virtual chan_if c_vif;
virtual common i1_vif;


function new(string name="chan_env",uvm_component parent);
	super.new(name, parent);
endfunction


virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	//y1_item = chan_seq_item::type_id::create("y1_item");
	if(!uvm_config_db#(virtual common)::get(this,"","i1_vif",i1_vif))
		`uvm_error("CHAN_DRV","Virtual Common interface not found")
	else
		`uvm_info("CHAN_DRV",$sformatf("Obtained common virtual interface"),UVM_LOW)
endfunction

task run_phase(uvm_phase phase);
	//y1_item.randomize();
	//y1_item.print();
endtask

endclass

