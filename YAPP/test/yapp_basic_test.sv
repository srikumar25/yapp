
class yapp_basic_test extends uvm_test;
	`uvm_component_utils(yapp_basic_test)

yapp_env env;
yapp_basic_seq seq;
hbus_basic_seq h_seq;
chan_basic_seq c_seq;
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
    	uvm_config_wrapper::set(this, "env.c0_agt.c_sqr.run_phase",
                            "default_sequence",
                            chan_basic_seq::type_id::get());
    	uvm_config_wrapper::set(this, "env.c1_agt.c_sqr.run_phase",
                            "default_sequence",
                            chan_basic_seq::type_id::get());
    	uvm_config_wrapper::set(this, "env.c2_agt.c_sqr.run_phase",
                            "default_sequence",
                            chan_basic_seq::type_id::get());
endfunction

function void end_of_elaboration();
	uvm_top.print_topology();
endfunction


/*task configure_phase(uvm_phase phase);
	phase.raise_objection(this);
	`uvm_info("BASIC_TEST_CONFIGURE_PHASE",$sformatf("Trying to configure the HBUS interface"),UVM_LOW)
	h_seq = hbus_basic_seq::type_id::create("h_seq");
	`uvm_info("BASIC_TEST_CONFIGURE_PHASE",$sformatf("Value of HBUS_SEQ instance ID is %d",h_seq.get_inst_id()),UVM_LOW)
	h_seq.start(env.h1_agt.h_sqr);
	//h_seq.req.print();
	phase.drop_objection(this); 
endtask  */

task run_phase(uvm_phase phase);
//task main_phase(uvm_phase phase);
	phase.raise_objection(this);

	`uvm_info("BASIC_TEST",$sformatf("Value of env object instance ID is %d",env.get_inst_id()),UVM_LOW)
	//`uvm_info("BASIC_TEST_CONFIGURE_PHASE",$sformatf("Trying to configure the HBUS interface"),UVM_LOW)
	seq = yapp_basic_seq::type_id::create("seq");
	h_seq = hbus_basic_seq::type_id::create("h_seq");
	c_seq = chan_basic_seq::type_id::create("c_seq");
	`uvm_info("BASIC_TEST_CONFIGURE_PHASE",$sformatf("Value of HBUS_SEQ instance ID is %d",h_seq.get_inst_id()),UVM_LOW)
	h_seq.start(env.h1_agt.h_sqr);
/*	fork
		begin
			`uvm_info("C0_SEQ",$sformatf("Let's see if c_seq gets started"),UVM_LOW)
			c_seq.start(env.c0_agt.c_sqr);
		end
		begin
			`uvm_info("C1_SEQ",$sformatf("Let's see if c_seq gets started"),UVM_LOW)
			c_seq.start(env.c1_agt.c_sqr);
		end
		begin
			`uvm_info("C2_SEQ",$sformatf("Let's see if c_seq gets started"),UVM_LOW)
			c_seq.start(env.c2_agt.c_sqr);
		end */
//		begin
			seq.start(env.y1_agt.y_sqr);
				//#10;
				`uvm_info("BASIC_TEST",$sformatf("Inside the basic test's run phase"),UVM_NONE)
				//`uvm_info("BASIC_TEST", $sformatf("Let's hope this is the one"),UVM_LOW)
				//void'(env.y1_item.randomize());
				//#10;
			seq.req.print();
				//env.y1_item.print();
//		end
//		join_any
		uvm_test_done.set_drain_time(this,5000ns);
	phase.drop_objection(this);
	//phase.phase_done.set_drain_time(this,5000ns);
endtask

endclass
