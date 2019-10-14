
class chan_basic_seq extends uvm_sequence #(chan_seq_item);

	`uvm_object_utils(chan_basic_seq)
  	`uvm_declare_p_sequencer(chan_sequencer) 

	function new(string name="chan_basic_seq");
		super.new(name);
	endfunction 

	task pre_body();
		`uvm_info("CHAN_SEQ",$sformatf("Inside the chan basic seq pre_body"),UVM_NONE)
	endtask
	
	task body();
		`uvm_info("CHAN_SEQ",$sformatf("Inside the chan basic seq"),UVM_NONE)
		//req = chan_seq_item::type_id::create("req");
		forever
		begin
		//start_item(req);
		//	assert(req.randomize() with {req.delay=='h00;});
		//finish_item(req);
		//req.print();
			@(posedge p_sequencer.i1_vif.clk iff p_sequencer.c_vif.data_vld==1'b1);
			`uvm_do_with(req,{req.delay=='h1;})
		end
	endtask

	task post_body();
	endtask

		//`uvm_do_with(req,{req.haddr=='h01;req.wdata=='h01;})
		//`uvm_info("CHAN_SEQ",$sformatf("Setting Max Packet size with all ones"),UVM_LOW)
		//`uvm_do_with(req,{req.haddr=='h01;req.wdata=='hFF;})
		//wait_for_grant();
		//start_item(req);
		//assert(req.randomize());
		//wait_for_item_done();
		//finish_item(req);

endclass
