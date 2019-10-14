
class chan_seq_item extends uvm_sequence_item;

bit [7:0] data_out[];
rand integer delay;


	`uvm_object_utils_begin(chan_seq_item)
		`uvm_field_array_int(data_out,UVM_DEFAULT)
		`uvm_field_int(delay,UVM_ALL_ON)
	`uvm_object_utils_end	

function new(string name="chan_seq_item");
	super.new("chan_seq_item");
endfunction

endclass

