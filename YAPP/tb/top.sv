
`timescale 1ns/1ps

module top();

import uvm_pkg::*;
//import chan_pkg::*;
//import hbus_pkg::*;
import common_pkg::*;
import yapp_pkg::*;

yapp_seq_item seq_item;


common i1();
yapp_env e1;

yapp_dut y1(
		// Common Signals
		clk(i1.clk),
		reset(i1.reset),
		// Yapp interface
                in_data(),
		in_data_vld(),
		in_suspend(),
		// Channels
                data_0(),data_vld_0(),suspend_0(),
                data_1(),data_vld_1(),suspend_1(),
                data_2(),data_vld_2(),suspend_2(),
		// Hbus interface
                hdata_in(),
		hdata_out(),
		haddr,hen,
		hw_rd,
                Error(i1.error)
		);

initial
begin
	e1 = yapp_env::type_id::create("e1");
	e1.y1_item.randomize();
	e1.y1_item.print();
end

initial
begin
	i1.clk = 1'b0;
	i1.reset = 1'b0;
	#50 i1.reset = 1'b1;
	e1.y1_item.print();
	#100 $finish;
end

initial
begin
	run_test();
end

always #10 i1.clk = ~i1.clk;
	
                
endmodule
	
