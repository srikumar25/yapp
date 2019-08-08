
class yapp_basic_test extends uvm_test;
	`uvm_component_utils(yapp_basic_test)

yapp_env env;


function new(string name="yapp_basic_test",uvm_component parent);
	super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	env = yapp_env::type_id::create("env",this);
endfunction

task run_phase(uvm_phase phase);
	phase.raise_objection(this);
		#10;
		env.y1_item.randomize();
		env.y1_item.print();
	phase.drop_objection(this);
endtask

endclass
