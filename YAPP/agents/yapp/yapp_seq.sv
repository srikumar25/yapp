
class yapp_seq extends uvm_sequence #(yapp_seq_item);

	`uvm_object_utils(yapp_seq)

	function new(string name="yapp_seq");
		super.new(name);
	endfunction 

task body();
	//req = yapp_seq_item::type_id::create("req");
	start_item(req);
	assert(req.randomize());
	finish_item(req);
endtask

endclass

