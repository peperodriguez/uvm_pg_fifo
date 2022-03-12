package fifo_pkg;
  import uvm_pkg::*;

  typedef enum {wr, rd, nop, reset} fifo_op;

  localparam par_dw         = 64; // 64 bits Data Width 
  localparam par_aw         = 4;  // 16 positions deep
  localparam par_clk_period = 20; // Clock period

  virtual interface fifo_if #(par_dw) glbl_fif;
  virtual interface clk_if #(par_clk_period/2,par_clk_period/2) glbl_clk;
  virtual interface rst_if glbl_rst;

  //bit             verbose = 0;

  `include "uvm_macros.svh"

  // uvm_objects
  `include "fifo_if_holder.svh"

  // uvm_transactions

  `include "fifo_output.svh" 
  `include "fifo_req.svh" 
  `include "test_seq.svh" 

  // uvm_agents

  `include "driver.svh"
  `include "monitor.svh"
  `include "printer.svh"
  //`include "fifo_model.svh" 
  `include "scbd.svh" 
  //`include "coverage.svh" 

  // uvm_environments
  //`include "fifo_env.svh"

  // uvm_tests
  //`include "fifo_test.svh"   
  //`include "verbose_test.svh" 


endpackage // fifo_pkg

