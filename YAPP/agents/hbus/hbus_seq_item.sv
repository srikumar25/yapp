
typedef enum {WR, RD} e_WR_RD;
class hbus_seq_item extends uvm_sequence_item;

rand logic [`DATA-1:0] wdata;
logic [`DATA-1:0] rdata;
rand logic [`ADDR-1:0] haddr;
//rand enum wr_rd;
rand e_WR_RD wr_rd;

	`uvm_object_utils_begin(hbus_seq_item)
		`uvm_field_int(wdata,UVM_ALL_ON)
		`uvm_field_int(rdata,UVM_ALL_ON)
		`uvm_field_int(haddr,UVM_ALL_ON)
		`uvm_field_enum(e_WR_RD,wr_rd,UVM_ALL_ON)
	`uvm_object_utils_end	

/*constraint l1_array {
		payload.size==length;
}*/

constraint DIR {
		wr_rd==WR;
}

function new(string name="hbus_seq_item");
	super.new("hbus_seq_item");
endfunction

endclass

