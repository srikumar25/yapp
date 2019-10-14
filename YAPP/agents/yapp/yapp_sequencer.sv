
//typedef uvm_sequencer#(yapp_seq_item) yapp_sequencer;
//typedef yapp_sequencer extends uvm_sequencer#(yapp_seq_item); 
//yapp_sequencer;

class yapp_sequencer extends uvm_sequencer#(yapp_seq_item);
	
	`uvm_component_utils(yapp_sequencer)

function new(string name,uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
endfunction

task run_phase(uvm_phase phase);
endtask

endclass 

