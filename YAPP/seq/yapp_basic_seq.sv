
class yapp_basic_seq extends uvm_sequence #(yapp_seq_item);

	`uvm_object_utils(yapp_basic_seq)

	//yapp_sequencer y1_sqr;

	function new(string name="yapp_basic_seq");
		super.new(name);
		`uvm_info("YAPP_SEQ",$sformatf("Lets hope this is the one"),UVM_LOW)
		//`uvm_error("YAPP_SEQ","This is an error")
	endfunction 
	
	/*function void build_phase(string name="yapp_basic_seq");
		super.build_phase(name);
		y1_sqr = yapp_sequencer::type_id::create("y1_sqr");
	endfunction */
		

	task body();
		//y1_sqr = env.y1_agt.y_sqr;
		`uvm_info("YAPP_SEQ",$sformatf("Inside the initial yapp basic seq"),UVM_LOW)
		for(int i=0;i<=2;i++)
		begin
		req = yapp_seq_item::type_id::create("req");
			 //Working cadence seq 
			 //`uvm_do_with(req,{req.address==i+1;})
			 //End of working macro

			//repeat(5)
			//begin
			//`uvm_do_with(req,{req.address=='h2;})
			//end
			//`uvm_do_with(req,{req.address=='h0;})
			//`uvm_do(req)
			//wait_for_grant();
		start_item(req);
		assert(req.randomize() with {req.address==i;});
		//if(req.randomize() with {req.addr==i;})
		//begin
		//	`uvm_info("YAPP_TRIAL_SEQ",$sformatf("Req sequence item is randomized and it is getting printed"),UVM_LOW)
		//	req.print();
		//end
		//wait_for_item_done();
		finish_item(req);
		end
	endtask

endclass

