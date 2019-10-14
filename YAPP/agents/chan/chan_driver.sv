
`define DATA 8
`define ADDR 2

class chan_driver extends uvm_driver#(chan_seq_item);
	`uvm_component_utils(chan_driver)

chan_seq_item c1_item;
virtual common i1_vif;
virtual chan_if c_vif;

function new(string name="chan_driver",uvm_component parent);
	super.new(name, parent);
endfunction

virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	c1_item = chan_seq_item::type_id::create("c1_item");
	req = chan_seq_item::type_id::create("req");
	//if(!uvm_config_db#(virtual chan_if)::get(this,"","c_vif",c_vif))
	//	`uvm_error("CHAN_DRV","channel Virtual interface not found")
	//else
	//	`uvm_info("CHAN_DRV",$sformatf("Obtained channel virtual interface"),UVM_LOW)
	if(!uvm_config_db#(virtual common)::get(this,"","i1_vif",i1_vif))
		`uvm_error("CHAN_DRV","Virtual Common interface not found")
	else
		`uvm_info("CHAN_DRV",$sformatf("Obtained common virtual interface"),UVM_LOW)
endfunction

task run_phase(uvm_phase phase);
chan_seq_item req;
logic [`DATA-1:0] temp_data; 

	req = chan_seq_item::type_id::create("req");
	`uvm_info("CHAN_DRV",$sformatf("Inside Channel UVC run_phase"),UVM_LOW)
	forever
	begin
		//seq_item_port.get_next_item(req);
		seq_item_port.get_next_item(req);
		c1_item = req;
		c1_item.print();

		`uvm_info("CHAN_DRV",$sformatf("Making sure that data valid is asserted"),UVM_LOW)

		//for(int j=0;j<`DATA;j++)
		//begin
		if(c_vif.data_vld==1'b1)
			if(c1_item.delay>0)
				for(int i=0;i<c1_item.delay;i++)
				begin
					@(posedge i1_vif.clk);
					c_vif.suspend=1'b1;
				end
			else
				c_vif.suspend = 1'b0;
		else
			c_vif.suspend = 1'b0;
		//end
		//`uvm_info("CHAN_DRV",$sformatf("Value of C1 item's data is %d",c1_item.data_out),UVM_LOW)
		c_vif.suspend = 1'b0;
		seq_item_port.item_done();
	end
endtask

endclass

