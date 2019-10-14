
`uvm_analysis_imp_decl(_y0)
`uvm_analysis_imp_decl(_y1)
`uvm_analysis_imp_decl(_y2)

`uvm_analysis_imp_decl(_c0)
`uvm_analysis_imp_decl(_c1)
`uvm_analysis_imp_decl(_c2)

//class yapp_scoreboard extends uvm_scoreboard#(yapp_seq_item);
class yapp_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(yapp_scoreboard)

integer c0_size,c1_size,c2_size;
integer c0_mismatch,c1_mismatch,c2_mismatch;



uvm_analysis_imp_y0#(yapp_seq_item,yapp_scoreboard) y0_aep;
uvm_analysis_imp_y1#(yapp_seq_item,yapp_scoreboard) y1_aep;
uvm_analysis_imp_y2#(yapp_seq_item,yapp_scoreboard) y2_aep;

uvm_analysis_imp_c0#(chan_seq_item,yapp_scoreboard) c0_aep;
uvm_analysis_imp_c1#(chan_seq_item,yapp_scoreboard) c1_aep;
uvm_analysis_imp_c2#(chan_seq_item,yapp_scoreboard) c2_aep;

uvm_tlm_analysis_fifo y0_fifo;
uvm_tlm_analysis_fifo y1_fifo;
uvm_tlm_analysis_fifo y2_fifo;
uvm_tlm_analysis_fifo c0_fifo;
uvm_tlm_analysis_fifo c1_fifo;
uvm_tlm_analysis_fifo c2_fifo;

bit [7:0] y0_ary[],y1_ary[],y2_ary[],c0_ary[],c1_ary[],c2_ary[];


function new(string name, uvm_component parent);
	super.new(name,parent);
	//yapp_export = new("yapp_export",this);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	y0_aep = new("y0_aep",this);
	y1_aep = new("y1_aep",this);
	y2_aep = new("y2_aep",this);
	c0_aep = new("c0_aep",this);
	c1_aep = new("c1_aep",this);
	c2_aep = new("c2_aep",this);

	`ifdef TLM_FIFO 
		c0_fifo = new("c0_fifo",this);
		c1_fifo = new("c1_fifo",this);
		c2_fifo = new("c2_fifo",this);
		y0_fifo = new("y0_fifo",this);
		y1_fifo = new("y1_fifo",this);
		y2_fifo = new("y2_fifo",this);
	`endif
endfunction

function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
endfunction

function void write_y0(yapp_seq_item pkt);
	pkt.print();
	c0_size = pkt.payload.size();
	y0_ary = new[c0_size];
	c0_ary = new[c0_size];
	y0_ary = pkt.payload;
	`uvm_info("YAPP_MON_Y0_AEP",$sformatf("Size of payload packet is %d",c0_size),UVM_LOW)
endfunction

function void write_y1(yapp_seq_item pkt);
	pkt.print();
	c1_size = pkt.payload.size();
	y1_ary = new[c1_size];
	c1_ary = new[c1_size];
	y1_ary = pkt.payload;
	`uvm_info("YAPP_MON_Y1_AEP",$sformatf("Size of payload packet is %d",c1_size),UVM_LOW)
endfunction

function void write_y2(yapp_seq_item pkt);
	pkt.print();
	c2_size = pkt.payload.size();
	y2_ary = new[c2_size];
	c2_ary = new[c2_size];
	y2_ary = pkt.payload;
	`uvm_info("YAPP_MON_Y2_AEP",$sformatf("Size of payload packet is %d",c2_size),UVM_LOW)
endfunction

function void write_c0(chan_seq_item pkt);
	`uvm_info("CHAN_MON_C0_AEP",$sformatf("Inside the write function of chan_monitor"),UVM_LOW)
	pkt.print();
	c0_ary = pkt.data_out;
	`uvm_info("CHAN_MON_C0",$sformatf("Size of y0_array and c0_array are %d,%d",y0_ary.size(),c0_ary.size()),UVM_LOW)
	for(int i=0;i<c0_size;i++)
	begin
		if(c0_ary[i]!==y0_ary[i])
			c0_mismatch++;
		else if(c0_ary==y0_ary)
			c0_mismatch=c0_mismatch;
	end
	if(c0_mismatch>0)
		`uvm_error("C0_DATA_ERROR","Error in channel_0 data") 
	else 
		`uvm_info("C0_DATA_CHECK_PASS",$sformatf("Data check passed for channel 0"),UVM_LOW)
endfunction

function void write_c1(chan_seq_item pkt);
	`uvm_info("CHAN_MON_C1_AEP",$sformatf("Inside the write function of chan_monitor"),UVM_LOW)
	pkt.print();
	c1_ary = pkt.data_out;
	`uvm_info("CHAN_MON_C1",$sformatf("Size of y1_array and c1_array are %d,%d",y1_ary.size(),c1_ary.size()),UVM_LOW)
	for(int j=0;j<c1_size;j++)
	begin
		if(c1_ary[j]!==y1_ary[j])
			c1_mismatch++;
		else if(c1_ary==y1_ary)
			c1_mismatch=c1_mismatch;
	end
	if(c1_mismatch>0)
		`uvm_error("C1_DATA_ERROR","Error in channel_1 data") 
	else 
		`uvm_info("C1_DATA_CHECK_PASS",$sformatf("Data check passed for channel 1"),UVM_LOW)
endfunction

function void write_c2(chan_seq_item pkt);
	`uvm_info("CHAN_MON_C2_AEP",$sformatf("Inside the write function of chan_monitor"),UVM_LOW)
	pkt.print();
	c2_ary = pkt.data_out;
	`uvm_info("CHAN_MON_C2",$sformatf("Size of y2_array and c2_array are %d,%d",y2_ary.size(),c2_ary.size()),UVM_LOW)
	for(int k=0;k<c0_size;k++)
	begin
		if(c2_ary[k]!==y2_ary[k])
			c2_mismatch++;
		else if(c2_ary==y2_ary)
			c2_mismatch=c2_mismatch;
	end
	if(c2_mismatch>0)
		`uvm_error("C2_DATA_ERROR","Error in channel_2 data") 
	else 
		`uvm_info("C2_DATA_CHECK_PASS",$sformatf("Data check passed for channel 2"),UVM_LOW)
endfunction

task run_phase(uvm_phase phase);
endtask

function void extract_phase(uvm_phase phase);
endfunction

function void check_phase(uvm_phase phase);


endfunction

endclass
