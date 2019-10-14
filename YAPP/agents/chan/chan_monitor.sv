
class chan_monitor extends uvm_driver#(chan_seq_item);
	
	`uvm_component_utils(chan_monitor)

virtual chan_if c_vif;
virtual common i1_vif;
chan_seq_item chan_pkt;
integer result;

uvm_analysis_port #(chan_seq_item) c_ap;
//uvm_analysis_port #(chan_seq_item) port_c1;
//uvm_analysis_port #(chan_seq_item) port_c2;

function new(string name,uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	chan_pkt = new("chan_pkt");
	c_ap = new("put_port_c0",this);

	//if(!uvm_config_db#(virtual chan_if)::get(this,"","c_vif",c_vif))
	//	`uvm_error("CHAN_MON_VIF","Failed to get virtual chan interface ")
	//else
	//	`uvm_info("CHAN_MON_VIF", $sformatf("Obtained the chan interface"),UVM_LOW)

	if(!uvm_config_db#(virtual common)::get(this,"","i1_vif",i1_vif))
		`uvm_error("CHAN_MON","Failed to get virtual common interface ") 
	else
		`uvm_info("CHAN_MON", $sformatf("Obtained the common interface"),UVM_LOW)
endfunction

function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
endfunction

task run_phase(uvm_phase phase);
int count,done='h0;
bit [7:0] parity,data_payload[]; 
bit [5:0] length;
bit [1:0] addr;

	`uvm_info("CHAN_MON_RUN_PHASE",$sformatf("Entering the monitor's run phase"),UVM_LOW)
	
/*	begin
			@(posedge i1_vif.clk) 
			if(c0_vif.in_data_vld==1'b1)
			begin
				if(count>0 && count<length)
				begin
					`uvm_info("CHAN_MON",$sformatf("Values of address,length and count are %d,%h,%d",addr,length,count),UVM_LOW)
					for(int i=0;i<length-1;i++)
					begin
						@(posedge i1_vif.clk);
						data_payload[i] = c0_vif.in_data;
						count = count+1;
						
					end
				end
				else if(count == length)
				begin
					@(posedge i1_vif.clk);
					chan_pkt.parity = c0_vif.in_data;
					chan_pkt.address = addr;
					chan_pkt.length = length;
					chan_pkt.payload = data_payload;
					//count = 0;
				end
				//count = count+1;
				`uvm_info("CHAN_MON",$sformatf("Value of count is %d",count),UVM_LOW)
			end
			else if(c0_vif.in_data_vld==1'b0) 
			begin
				if(count>0)
				begin
					`uvm_info("CHAN_MON",$sformatf("Entering loop with count value as %d",count),UVM_LOW)
					chan_pkt.print();
					if(addr==2'b0)
					begin
						`uvm_info("CHAN_MON",$sformatf("Writing with address as 0 in put_port_c0"),UVM_LOW)
						put_port_c0.write(chan_pkt);
					end
					else if(addr==2'b01)
					begin
						`uvm_info("CHAN_MON",$sformatf("Writing with address as 1 in put_port_c1"),UVM_LOW)
						put_port_c1.write(chan_pkt);
					end
					else if(addr==2'b10)
					begin
						`uvm_info("CHAN_MON",$sformatf("Writing with address as 2 in put_port_c2"),UVM_LOW)
						put_port_c2.write(chan_pkt);
					end 
				count = 0;
				addr = 0;
				length = 0;
				end
			end
	end  
	end */
		data_payload = new[256];
		count = 'h0;
	forever
	begin
		@(posedge i1_vif.clk)
		if(c_vif.data_vld==1'b1)
		begin
			`uvm_info("CHAN_MON_DATA_VLD",$sformatf("Data_valid is asserted"),UVM_LOW)
			//length = c_vif.data[7:2];
			//addr   = c_vif.data[1:0];
			data_payload[count] = c_vif.data ;
			count++;
			done = 1'b1;
		end
		else if(c_vif.data_vld==1'b0)
			if(done==1'b1)
			begin
			`uvm_info("CHAN_MON_DONE",$sformatf("Writing into the Analysis_Ports of CHAN_MON with channel_pkt "),UVM_LOW)
				chan_pkt.data_out = data_payload;
				done = 1'b0;
				c_ap.write(chan_pkt);
			end
	end
endtask


endclass
