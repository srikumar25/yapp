
class hbus_basic_seq extends uvm_sequence #(hbus_seq_item);

	`uvm_object_utils(hbus_basic_seq)

	function new(string name="hbus_basic_seq");
		super.new(name);
	endfunction 
	
	task body();
		req = hbus_seq_item::type_id::create("req");
		//y1_sqr = env.y1_agt.y_sqr;
		`uvm_info("HBUS_SEQ",$sformatf("Inside the configuration hbus basic seq"),UVM_LOW)
		`uvm_info("HBUS_SEQ",$sformatf("Setting Router enable with single one"),UVM_LOW)
		start_item(req);
		assert(req.randomize() with {req.haddr=='h01;req.wdata=='h01;req.wr_rd==WR;});
		finish_item(req);
		start_item(req);
		assert(req.randomize() with {req.haddr=='h00;req.wdata=='h11;req.wr_rd==WR;});
		finish_item(req);
		req.print();

		//`uvm_do_with(req,{req.haddr=='h01;req.wdata=='h01;})
		`uvm_info("HBUS_SEQ",$sformatf("Setting Max Packet size with all ones"),UVM_LOW)
		//`uvm_do_with(req,{req.haddr=='h01;req.wdata=='hFF;})
		//wait_for_grant();
		//start_item(req);
		//assert(req.randomize());
		//wait_for_item_done();
		//finish_item(req);
	endtask

endclass
