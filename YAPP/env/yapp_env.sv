
class yapp_env extends uvm_env;
	
	`uvm_component_utils(yapp_env)


yapp_seq_item y1_item;
yapp_agent y1_agt,y0_agt;

function new(string name="yapp_env",uvm_component parent);
//function new(string name,uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	y1_item = yapp_seq_item::type_id::create("y1_item");
	y1_agt = yapp_agent::type_id::create("y1_agt",this);
endfunction

function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
endfunction

task run_phase(uvm_phase phase);
endtask

endclass
