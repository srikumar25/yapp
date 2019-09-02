
`ifndef CHAN_PKG
`define CHAN_PKG
package chan_pkg;

`define DATA 8
`define ADDR 2

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "chan_seq_item.sv"
`include "chan_driver.sv"
`include "chan_sequencer.sv"
//`include "chan_monitor.sv"
`include "chan_agent_cfg.sv"
`include "chan_agent.sv"
`include "chan_env.sv"

endpackage
`endif
