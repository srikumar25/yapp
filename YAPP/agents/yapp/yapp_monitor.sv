
class yapp_monitor extends uvm_driver#(yapp_seq_item);
	
	`uvm_component_utils(yapp_monitor)

virtual yapp_if y1_vif;
virtual common i1_vif;
yapp_seq_item yapp_pkt;
integer result;

uvm_analysis_port #(yapp_seq_item) put_port_c0;
uvm_analysis_port #(yapp_seq_item) put_port_c1;
uvm_analysis_port #(yapp_seq_item) put_port_c2;

function new(string name,uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	yapp_pkt = new("yapp_pkt");
	put_port_c0 = new("put_port_c0",this);
	put_port_c1 = new("put_port_c1",this);
	put_port_c2 = new("put_port_c2",this);

	if(!uvm_config_db#(virtual yapp_if)::get(this,"","y1_vif",y1_vif))
		`uvm_error("YAPP_MON","Failed to get virtual yapp interface ")
	else
		`uvm_info("YAPP_MON", $sformatf("Obtained the yapp interface"),UVM_HIGH)
	if(!uvm_config_db#(virtual common)::get(this,"","i1_vif",i1_vif))
		`uvm_error("YAPP_MON","Failed to get virtual common interface ") 
	else
		`uvm_info("YAPP_MON", $sformatf("Obtained the common interface"),UVM_HIGH)
endfunction

function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
endfunction

task run_phase(uvm_phase phase);
int count,done;
bit [7:0] parity,data_payload[]; 
bit [5:0] length;
bit [1:0] addr;

	`uvm_info("YAPP_MON_RUN_PHASE",$sformatf("Entering the monitor's run phase"),UVM_HIGH)
	
	forever
	begin
	fork
	begin
			@(posedge i1_vif.clk) 
			if(y1_vif.in_data_vld==1'b1)
			begin
				if(count>0 && count<length)
				begin
					`uvm_info("YAPP_MON_DONE",$sformatf("Value of done is %d",done),UVM_LOW)
					if(done==1'b1)
						done = 1'b0;
					`uvm_info("YAPP_MON",$sformatf("Values of address,length and count are %d,%h,%d",addr,length,count),UVM_LOW)
					for(int i=0;i<length-1;i++)
					begin
						@(posedge i1_vif.clk);
						data_payload[i] = y1_vif.in_data;
						count = count+1;
						
					end
				end
				else if(count == length && done==1'b0)
				begin
					@(posedge i1_vif.clk);
					yapp_pkt.parity = y1_vif.in_data;
					yapp_pkt.address = addr;
					yapp_pkt.length = length;
					yapp_pkt.payload = data_payload;
					//count = 0;
				end
				//count = count+1;
				`uvm_info("YAPP_MON",$sformatf("Value of count is %d",count),UVM_LOW)
			end
			else if(y1_vif.in_data_vld==1'b0) 
			begin
				if(count>0 && done==1'b0)
				begin
					`uvm_info("YAPP_MON",$sformatf("Entering loop with count value as %d",count),UVM_LOW)
					count = 0;
					addr = 0;
					length = 0;
					yapp_pkt.print();
					if(yapp_pkt.address==2'b0)
					begin
						`uvm_info("YAPP_MON_C0",$sformatf("Writing with address as 0 in put_port_c0"),UVM_LOW)
						put_port_c0.write(yapp_pkt);
						done = 1'b1;
						//count = 0;
						//addr = 0;
						//length = 0;
					end
					else if(yapp_pkt.address==2'b01)
					begin
						`uvm_info("YAPP_MON_C1",$sformatf("Writing with address as 1 in put_port_c1"),UVM_LOW)
						put_port_c1.write(yapp_pkt);
						done = 1'b1;
					end
					else if(yapp_pkt.address==2'b10)
					begin
						`uvm_info("YAPP_MON_C2",$sformatf("Writing with address as 2 in put_port_c2"),UVM_LOW)
						put_port_c2.write(yapp_pkt);
						done = 1'b1;
					end 
				end
			end
		end  
		begin
			//@(posedge y1_vif.in_data_vld)
			@(posedge i1_vif.clk)
			if(y1_vif.in_data_vld==1'b1)
				if(count==0)
				begin
					length = y1_vif.in_data[7:2];
					addr   = y1_vif.in_data[1:0];
					data_payload = new[length];
					//y1_vif.in_data[5:0];
					count = 1;
					`uvm_info("YAPP_MON",$sformatf("Values of address,length and count at the start are %h,%h,%d",addr,length,count),UVM_HIGH)
				end
			`uvm_info("YAPP_MON",$sformatf("Writing whenever in_data_vld is 1"),UVM_LOW)
		end
	join
	end
	//join_none
endtask


endclass
