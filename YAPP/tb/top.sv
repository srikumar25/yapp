
`timescale 1ns/1ps

`include "../common/common_pkg.sv"

module top();


import uvm_pkg::*;
import chan_pkg::*;
import hbus_pkg::*;
import yapp_pkg::*;
import common_pkg::*;

intf i1;


yapp_dut y1(
		// Common Signals
		clk,
		reset,
		// Yapp interface
                in_data,
		in_data_vld,
		in_suspend,
		// Channels
                data_0,data_vld_0,suspend_0,
                data_1,data_vld_1,suspend_1,
                data_2,data_vld_2,suspend_2,
		// Hbus interface
                hdata_in,
		hdata_out,
		haddr,hen,
		hw_rd,
                Error
		);

initial
begin
	i1.clk = 1'b0;
	i1.reset = 1'b0;
	#50 i1.reset = 1'b1;
	#100 $finish;
end

always #10 i1.clk = ~i1.clk;
	
                
endmodule
	
