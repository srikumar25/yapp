

class yapp_env extends uvm_env;
	`uvm_component_utils(yapp_env)

yapp_seq_item y1_item;

function new(string name="yapp_env",uvm_component parent);
	super.new(name, parent);
endfunction


virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	y1_item = yapp_seq_item::type_id::create("y1_item");
endfunction

task run_phase(uvm_phase phase);
	y1_item.randomize();
	y1_item.print();
endtask

endclass

