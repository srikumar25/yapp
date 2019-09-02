
`ifndef HBUS_PKG
`define HBUS_PKG
package hbus_pkg;

`define DATA 8
`define ADDR 2

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "hbus_seq_item.sv"
`include "hbus_driver.sv"
`include "hbus_sequencer.sv"
//`include "hbus_monitor.sv"
`include "hbus_agent_cfg.sv"
`include "hbus_agent.sv"
`include "hbus_env.sv"

endpackage
`endif
