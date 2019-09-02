
`timescale 1ns/1ps
interface hbus_if;
	logic [`DATA-1:0] hdata_in;
	logic [`DATA-1:0] hdata_out;
	logic [`ADDR-1:0] haddr;
	logic hen;
	logic hwr_rd;
endinterface
