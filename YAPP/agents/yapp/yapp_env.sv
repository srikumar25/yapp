
class yapp_env extends uvm_env;
	
	`uvm_component_utils(yapp_env)


yapp_seq_item y1_item;
yapp_agent y1_agt;
//yapp_agent y1_agt,y2_agt;
hbus_agent h1_agt;
chan_agent c0_agt,c1_agt,c2_agt;
yapp_scoreboard y1_sbd;

function new(string name="yapp_env",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	y1_item = yapp_seq_item::type_id::create("y1_item");
	y1_agt = yapp_agent::type_id::create(.name("y1_agt"),.parent(this));
	h1_agt = hbus_agent::type_id::create("h1_agt",this);
	c0_agt = chan_agent::type_id::create("c0_agt",this);
	c1_agt = chan_agent::type_id::create("c1_agt",this);
	c2_agt = chan_agent::type_id::create("c2_agt",this);
	y1_sbd = yapp_scoreboard::type_id::create("y1_sbd",this);
	`uvm_info("YAPP_ENV",$sformatf("Value of c0_agent's instance ID is %d",c0_agt.get_inst_id()),UVM_LOW)
	`uvm_info("YAPP_ENV",$sformatf("Value of c1_agent's instance ID is %d",c1_agt.get_inst_id()),UVM_LOW)
	`uvm_info("YAPP_ENV",$sformatf("Value of c2_agent's instance ID is %d",c2_agt.get_inst_id()),UVM_LOW)

endfunction

function void end_of_elaboration();
	if(!uvm_config_db#(virtual chan_if)::get(this,"","c0_vif",c0_agt.c_drv.c_vif))
		`uvm_error("CHAN_0_AGT","Failed to get virtual channel interface") 
	else
		`uvm_info("CHAN_0_AGT", $sformatf("Obtained the channel interface"),UVM_NONE) 

	if(!uvm_config_db#(virtual chan_if)::get(this,"","c1_vif",c1_agt.c_drv.c_vif))
		`uvm_error("CHAN_1_AGT","Failed to get virtual channel interface") 
	else
		`uvm_info("CHAN_1_AGT", $sformatf("Obtained the channel interface"),UVM_NONE) 

	if(!uvm_config_db#(virtual chan_if)::get(this,"","c2_vif",c2_agt.c_drv.c_vif))
		`uvm_error("CHAN_2_AGT","Failed to get virtual channel interface") 
	else
		`uvm_info("CHAN_2_AGT", $sformatf("Obtained the channel interface"),UVM_NONE) 

	if(!uvm_config_db#(virtual chan_if)::get(this,"","c0_vif",c0_agt.c_mnr.c_vif))
		`uvm_error("CHAN_0_MNR","Failed to get virtual channel interface") 
	else
		`uvm_info("CHAN_0_MNR_VIF", $sformatf("Obtained the channel interface"),UVM_LOW) 

	if(!uvm_config_db#(virtual chan_if)::get(this,"","c1_vif",c1_agt.c_mnr.c_vif))
		`uvm_error("CHAN_1_MNR","Failed to get virtual channel interface") 
	else
		`uvm_info("CHAN_1_MNR_VIF", $sformatf("Obtained the channel interface"),UVM_LOW) 

	if(!uvm_config_db#(virtual chan_if)::get(this,"","c2_vif",c2_agt.c_mnr.c_vif))
		`uvm_error("CHAN_2_MNR","Failed to get virtual channel interface") 
	else
		`uvm_info("CHAN_2_MNR_VIF", $sformatf("Obtained the channel interface"),UVM_LOW) 

	if(!uvm_config_db#(virtual chan_if)::get(this,"","c0_vif",c0_agt.c_sqr.c_vif))
		`uvm_error("CHAN_0_SQR","Failed to get virtual channel interface") 
	else
		`uvm_info("CHAN_0_SQR_VIF", $sformatf("Obtained the channel interface"),UVM_NONE) 

	if(!uvm_config_db#(virtual chan_if)::get(this,"","c1_vif",c1_agt.c_sqr.c_vif))
		`uvm_error("CHAN_1_SQR","Failed to get virtual channel interface") 
	else
		`uvm_info("CHAN_1_SQR_VIF", $sformatf("Obtained the channel interface"),UVM_NONE) 

	if(!uvm_config_db#(virtual chan_if)::get(this,"","c2_vif",c2_agt.c_sqr.c_vif))
		`uvm_error("CHAN_2_SQR","Failed to get virtual channel interface") 
	else
		`uvm_info("CHAN_2_SQR_VIF", $sformatf("Obtained the channel interface"),UVM_NONE) 


endfunction

function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	y1_agt.y_mnr.put_port_c0.connect(y1_sbd.y0_aep);
	y1_agt.y_mnr.put_port_c1.connect(y1_sbd.y1_aep);
	y1_agt.y_mnr.put_port_c2.connect(y1_sbd.y2_aep);

	//c0_agt.c_mnr.c_ap.connect(y1_sbd.c0_aep);
	//c1_agt.c_mnr.c_ap.connect(y1_sbd.c1_aep);
	//c2_agt.c_mnr.c_ap.connect(y1_sbd.c2_aep);

	c0_agt.c_ap.connect(y1_sbd.c0_aep);
	c1_agt.c_ap.connect(y1_sbd.c1_aep);
	c2_agt.c_ap.connect(y1_sbd.c2_aep);

endfunction


task run_phase(uvm_phase phase);

/*	if(!uvm_config_db#(virtual chan_if)::get(this,"","c0_vif",c0_agt.c_drv.c_vif))
		`uvm_error("CHAN_0_AGT","Failed to get virtual channel interface") 
	else
		`uvm_info("CHAN_0_AGT", $sformatf("Obtained the channel interface"),UVM_LOW) 

	if(!uvm_config_db#(virtual chan_if)::get(this,"","c1_vif",c1_agt.c_drv.c_vif))
		`uvm_error("CHAN_1_AGT","Failed to get virtual channel interface") 
	else
		`uvm_info("CHAN_1_AGT", $sformatf("Obtained the channel interface"),UVM_LOW) 

	if(!uvm_config_db#(virtual chan_if)::get(this,"","c2_vif",c2_agt.c_drv.c_vif))
		`uvm_error("CHAN_2_AGT","Failed to get virtual channel interface") 
	else
		`uvm_info("CHAN_2_AGT", $sformatf("Obtained the channel interface"),UVM_LOW) 

	if(!uvm_config_db#(virtual chan_if)::get(this,"","c0_vif",c0_agt.c_mnr.c_vif))
		`uvm_error("CHAN_0_MNR","Failed to get virtual channel interface") 
	else
		`uvm_info("CHAN_0_MNR_CIF", $sformatf("Obtained the channel interface"),UVM_LOW) 

	if(!uvm_config_db#(virtual chan_if)::get(this,"","c1_vif",c1_agt.c_mnr.c_vif))
		`uvm_error("CHAN_1_MNR","Failed to get virtual channel interface") 
	else
		`uvm_info("CHAN_1_MNR_CIF", $sformatf("Obtained the channel interface"),UVM_LOW) 

	if(!uvm_config_db#(virtual chan_if)::get(this,"","c2_vif",c2_agt.c_mnr.c_vif))
		`uvm_error("CHAN_2_MNR","Failed to get virtual channel interface") 
	else
		`uvm_info("CHAN_2_MNR_CIF", $sformatf("Obtained the channel interface"),UVM_LOW)  */

	`uvm_info("YAPP_ENV",$sformatf("Value of h1_agent's instance ID is %d",h1_agt.get_inst_id()),UVM_LOW)
	this.c2_agt.c_drv.c_vif.suspend = 1'b1;
	`uvm_info("YAPP_ENV",$sformatf("Post raising the suspend value as 1"),UVM_LOW)
endtask

endclass
