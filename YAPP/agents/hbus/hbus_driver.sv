
`define DATA 8
`define ADDR 2

class hbus_driver extends uvm_driver#(hbus_seq_item);
	`uvm_component_utils(hbus_driver)

hbus_seq_item h1_item;
virtual common i1_vif;
virtual hbus_if h1_vif;

function new(string name="hbus_driver",uvm_component parent);
	super.new(name, parent);
endfunction


virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	h1_item = hbus_seq_item::type_id::create("h1_item");
	if(!uvm_config_db#(virtual hbus_if)::get(this,"","h1_vif",h1_vif))
		`uvm_error("HBUS_DRV","HBUS Virtual interface not found")
	else
		`uvm_info("HBUS_DRV",$sformatf("Obtained HBUS virtual interface"),UVM_LOW)
	if(!uvm_config_db#(virtual common)::get(this,"","i1_vif",i1_vif))
		`uvm_error("HBUS_DRV","Virtual Common interface not found")
	else
		`uvm_info("HBUS_DRV",$sformatf("Obtained common virtual interface"),UVM_LOW)
endfunction

task run_phase(uvm_phase phase);
hbus_seq_item req;
logic [`DATA-1:0] temp_data;
	wait(i1_vif.reset==1'b1)
	forever
	begin
	seq_item_port.get_next_item(req);
	`uvm_info("HBUS_DRV",$sformatf("Obtaining the configuration hbus basic seq"),UVM_LOW)
	h1_item = req;
	h1_item.print();
	@(posedge i1_vif.clk);
	h1_vif.hen = 1'b1;
	h1_vif.haddr = h1_item.haddr;
		if(req.wr_rd==WR)
		begin
			h1_vif.hwr_rd = 1'b1;
			h1_vif.hdata_in = h1_item.wdata;
		end
		else if(req.wr_rd == RD)
		begin
			h1_vif.hwr_rd = 1'b0;
			req.rdata = h1_vif.hdata_out;
		end
	@(posedge i1_vif.clk);
	h1_vif.hen = 1'b0;
	h1_vif.haddr = 'h0;
	h1_vif.hwr_rd = 1'b0;
	h1_vif.hdata_in = 'h0;
	seq_item_port.item_done(); 
	`uvm_info("HBUS_DRV",$sformatf("Finished with item_done"),UVM_LOW)
	end

endtask

endclass

