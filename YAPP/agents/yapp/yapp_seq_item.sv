
class yapp_seq_item extends uvm_sequence_item;

rand bit [5:0] length;
rand bit [1:0] address;
bit [7:0] parity;
rand bit [7:0] payload[];

	`uvm_object_utils_begin(yapp_seq_item)
		`uvm_field_int(length,UVM_ALL_ON)
		`uvm_field_int(address,UVM_ALL_ON)
		`uvm_field_int(parity,UVM_ALL_ON)
		`uvm_field_array_int(payload,UVM_ALL_ON)
	`uvm_object_utils_end	

constraint l1_array {
		payload.size==length;
}

constraint LEN {
	length != 0;
}

constraint ADDR {
	address  <= 2;
}

function new(string name="yapp_seq_item");
	super.new("yapp_seq_item");
endfunction

endclass

