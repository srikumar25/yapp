
`timescale 1ns/1ps

module top();

import uvm_pkg::*;
import common_pkg::*;
import yapp_pkg::*;
import chan_pkg::*;
import hbus_pkg::*;

common i1_if();
yapp_if y_if();
hbus_if h_if();
chan_if c0_if(),c1_if(),c2_if();
yapp_env e1;

yapp_dut y1(
		// Common Signals
		.clk(i1_if.clk),
		.reset(i1_if.rst),
		// Yapp interface
                .in_data(y_if.in_data),
		.in_data_vld(y_if.in_data_vld),
		.in_suspend(y_if.in_suspend),
		// Channels
                .data_0(c0_if.data),.data_vld_0(c0_if.data_vld),.suspend_0(c0_if.suspend),
                .data_1(c1_if.data),.data_vld_1(c1_if.data_vld),.suspend_1(c1_if.suspend),
                .data_2(c2_if.data),.data_vld_2(c2_if.data_vld),.suspend_2(c2_if.suspend),
		// Hbus interface
                .hdata_in(h_if.hdata_in),
		.hdata_out(h_if.hdata_out),
		.haddr(h_if.haddr),
		.hen(h_if.hen),
		.hw_rd(h_if.hwr_rd),
                .error(i1_if.error)
		);


initial
begin
	i1_if.clk = 1'b0;
	i1_if.rst = 1'b0;
	#30 i1_if.rst = 1'b1;
	//e1.y1_item.print();
	//#100 $finish;
end

initial
begin
`ifdef CADENCE
	//$recordfile("debug_results.trn");
	$recordfile("new.trn");
	$recordvars(top.y1);
`endif
	run_test("yapp_basic_test");
end

always #10 i1_if.clk = ~i1_if.clk;

initial
begin
//	uvm_config_db#(virtual yapp_if)::set(null,"uvm_test_top","y1_vif",y_if);
	uvm_config_db#(virtual yapp_if)::set(null,"*","y1_vif",y_if);
	uvm_config_db#(virtual hbus_if)::set(null,"*","h1_vif",h_if);
	uvm_config_db#(virtual common)::set(null,"*","i1_vif",i1_if);
	uvm_config_db#(virtual chan_if)::set(null,"*","c0_vif",c0_if);
	uvm_config_db#(virtual chan_if)::set(null,"*","c1_vif",c1_if);
	uvm_config_db#(virtual chan_if)::set(null,"*","c2_vif",c2_if);
	//e1 = yapp_env::type_id::create("e1",null);
	//void'(e1.y1_item.randomize());
	//e1.y1_item.print();
end
	
                
endmodule
	
