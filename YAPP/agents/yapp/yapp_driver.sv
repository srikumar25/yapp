
class yapp_driver extends uvm_driver#(yapp_seq_item);
	
	`uvm_component_utils(yapp_driver)

virtual yapp_if y1_vif;
virtual common i1_vif;
//yapp_seq_item req_item;
integer result;

function new(string name,uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	//result = uvm_config_db#(virtual yapp_if)::get(this,"","y1_vif",y1_vif);
	//if(result==1'b0)
	if(!uvm_config_db#(virtual yapp_if)::get(this,"","y1_vif",y1_vif))
		`uvm_error("YAPP_DRV","Failed to get virtual yapp interface ")
	else
		`uvm_info("YAPP_DRV", $sformatf("Obtained the yapp interface"),UVM_LOW)
	if(!uvm_config_db#(virtual common)::get(this,"","i1_vif",i1_vif))
		`uvm_error("YAPP_DRV","Failed to get virtual common interface ") 
	else
		`uvm_info("YAPP_DRV", $sformatf("Obtained the common interface"),UVM_LOW)
endfunction

function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
endfunction

task run_phase(uvm_phase phase);
	`uvm_info("YAPP_DRV_RUN_PHASE",$sformatf("Entering the driver's run phase"),UVM_LOW)
	//wait(i1_vif.reset==1'b1)
	forever
	begin
			seq_item_port.get_next_item(req);
			`uvm_info("YAPP_DRV_RUN_PHASE",$sformatf("Printing the seq_item from YAPP_DRIVER"),UVM_LOW)
			req.print();
			
		if(i1_vif.rst==1'b0)
		begin
			@(negedge i1_vif.clk);
			y1_vif.in_data_vld = 1'b0;
			y1_vif.in_data = 'h0;
		end
		else if(i1_vif.rst==1'b1)
		begin
				@(negedge i1_vif.clk);
				`uvm_info("YAPP_DRV_RUN_PHASE",$sformatf("Reset value is %d",i1_vif.rst),UVM_LOW)
				`uvm_info("YAPP_DRV",$sformatf("Address and length are %d, %d",req.address,req.length),UVM_LOW)
				for(int i=0;i<=req.length+1;i++)
				begin
				@(negedge i1_vif.clk);
				y1_vif.in_suspend = 1'b0;
					`uvm_info("YAPP_DRV",$sformatf("Value of payload's %d is %h",i,req.payload[i]),UVM_LOW)
					if(i==0)
					begin
						y1_vif.in_data_vld = 1'b1;
						//y1_vif.in_data = {req.address,req.length};
						y1_vif.in_data = {req.length,req.address};
					end
					else if(i>0 && i<=req.length)
					begin
						y1_vif.in_data_vld = 1'b1;
						y1_vif.in_data = req.payload[i-1];
					end
					else if(i>req.length)
					begin
						y1_vif.in_data_vld = 1'b1;
						y1_vif.in_data = calc_parity();
					end
				end
				@(negedge i1_vif.clk);
				y1_vif.in_data_vld = 1'b0;
		end
			seq_item_port.item_done();
	end
endtask

function bit [`DATA-1:0] calc_parity();
bit [`DATA-1:0] temp_data;
	for(int k=0;k<req.length;k++)
	begin
		temp_data = req.payload[k] ^ temp_data;
		`uvm_info("CALC_PARITY",$sformatf("Value of temp_data is %d",temp_data),UVM_LOW)
	end
	`uvm_info("CALC_PARITY",$sformatf("Value of calculated parity is %d",temp_data),UVM_LOW)
	calc_parity = temp_data;
endfunction


endclass
