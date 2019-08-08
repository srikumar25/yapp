
class yapp_env extends uvm_env;
	
	`uvm_component_utils(yapp_env)

function void new("yapp_env",null);
	super.new(yapp_env,null);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
endfunction

endclass
