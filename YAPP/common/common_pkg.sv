
//`include "chan_pkg.sv"
//`include "hbus_pkg.sv"
//`include "yapp_pkg.sv"

package common_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;

`define DATA 8
`define ADDR 2

//`include "../agents/yapp/yapp_env_cfg.sv"
//`include "../agents/yapp/yapp_env.sv"
//`include "yapp_env.sv"
//`include "../agents/yapp/yapp_seq.sv"
//`include "../agents/yapp/yapp_test.sv"

endpackage

`include "intf.sv"
`include "yapp_if.sv"
`include "hbus_if.sv"
`include "chan_if.sv"

