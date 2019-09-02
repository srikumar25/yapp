
`define DATA 8
`define ADDR 2

class chan_driver extends uvm_driver#(chan_seq_item);
	`uvm_component_utils(chan_driver)

chan_seq_item c1_item;
virtual yapp_if y1_vif;
virtual common i1_vif;
virtual chan_if c1_vif;

function new(string name="chan_driver",uvm_component parent);
	super.new(name, parent);
endfunction

virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	c1_item = chan_seq_item::type_id::create("c1_item");
	if(!uvm_config_db#(virtual chan_if)::get(this,"","c1_vif",c1_vif))
		`uvm_error("CHAN_DRV","channel Virtual interface not found")
	else
		`uvm_info("CHAN_DRV",$sformatf("Obtained channel virtual interface"),UVM_LOW)
	if(!uvm_config_db#(virtual common)::get(this,"","i1_vif",i1_vif))
		`uvm_error("CHAN_DRV","Virtual Common interface not found")
	else
		`uvm_info("CHAN_DRV",$sformatf("Obtained common virtual interface"),UVM_LOW)
endfunction

task run_phase(uvm_phase phase);
chan_seq_item req;
logic [`DATA-1:0] temp_data; 
	forever
	begin
		seq_item_port.get_next_item(req);
		//y1_item = req;
		//y1_item.print();

		wait(c1_vif.data_vld)
		`uvm_info("CHAN_DRV",$sformatf("Making sure that data valid is asserted"),UVM_LOW)
		/*fork
		begin
			if(y1_vif.in_suspend==1'b1)
				y1_vif.in_data = temp_data;
			else if(y1_vif.in_suspend==1'b0)
			begin
				for(int i=0;i<=y1_item.length;i++)
				begin
					if(i==0)
						y1_vif.in_data = {y1_item.address,y1_item.length};
					else 
						y1_vif.in_data = y1_item.payload[i-1];
				end
			end
		end
		begin
			@(i1_vif.clk);
			temp_data = y1_vif.in_data;
		end
		join
		y1_vif.in_data_vld = 1'b0;
		*/
		seq_item_port.item_done();
	end
endtask

endclass

