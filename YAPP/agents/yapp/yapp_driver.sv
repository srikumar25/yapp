
class yapp_driver extends uvm_driver#(yapp_seq_item);
	
	`uvm_component_utils(yapp_driver)

virtual yapp_if y_vif;
yapp_seq_item req_item;

function new(string name="yapp_driver",uvm_component parent=null);
	super.new("yapp_driver",null);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(virtual yapp_if)::get(this,"*","y_vif",y_vif))
		`uvm_fatal("YAPP_DRV","Failed to get virtual yapp interface ")
endfunction

function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
endfunction

task run_phase(uvm_phase phase);
	seq_item_port.get_next_item(req_item);
	seq_item_port.item_done();
endtask

endclass
