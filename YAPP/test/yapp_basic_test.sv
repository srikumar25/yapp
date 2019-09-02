
class yapp_basic_test extends uvm_test;
	`uvm_component_utils(yapp_basic_test)

yapp_env env;
yapp_basic_seq seq;
hbus_basic_seq h_seq;
virtual yapp_if y1_vif;


function new(string name="yapp_basic_test",uvm_component parent);
	super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	env = yapp_env::type_id::create("env",this);
	if(uvm_config_db#(virtual yapp_if)::get(this,"uvm_test_top","y1_vif",y1_vif)==0)
		`uvm_info("BASIC_TEST",$sformatf("Not obtained the interface"),UVM_LOW)
	else
		`uvm_info("BASIC_TEST",$sformatf("Obtained the interface in test too"), UVM_LOW)
endfunction


task configure_phase(uvm_phase phase);
	phase.raise_objection(this);
	`uvm_info("BASIC_TEST_CONFIGURE_PHASE",$sformatf("Trying to configure the HBUS interface"),UVM_LOW)
	h_seq = hbus_basic_seq::type_id::create("h_seq");
	`uvm_info("BASIC_TEST_CONFIGURE_PHASE",$sformatf("Value of HBUS_SEQ instance ID is %d",h_seq.get_inst_id()),UVM_LOW)
	h_seq.start(env.h1_agt.h_sqr);
	h_seq.req.print();
	phase.drop_objection(this); 
endtask 


//task run_phase(uvm_phase phase);
task main_phase(uvm_phase phase);
	phase.raise_objection(this);
	seq = yapp_basic_seq::type_id::create("seq");
	//seq.y1_sqr = env.y1_agt.y_sqr;
	`uvm_info("BASIC_TEST",$sformatf("Value of env object instance ID is %d",env.get_inst_id()),UVM_LOW)
	seq.start(env.y1_agt.y_sqr);
		//#10;
		`uvm_info("BASIC_TEST",$sformatf("Inside the basic test's run phase"),UVM_LOW)
		//`uvm_info("BASIC_TEST", $sformatf("Let's hope this is the one"),UVM_LOW)
		//void'(env.y1_item.randomize());
		//#10;
		seq.req.print();
		//env.y1_item.print();
	phase.drop_objection(this);
	phase.phase_done.set_drain_time(this,5000ns);
endtask

endclass
