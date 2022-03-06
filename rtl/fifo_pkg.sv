package fifo_pkg;
  import uvm_pkg::*;

  typedef enum {wr, rd, nop, reset} fifo_op;

  virtual interface fifo_if glbl_fif;
  virtual interface clk_if  glbl_clk;

  localparam par_dw = 64; // 64 bits Data Width 
  localparam par_aw = 4;  // 16 positions deep

  //bit             verbose = 0;

  `include "uvm_macros.svh"

  // uvm_objects
  `include "interface_holder.svh"

  // uvm_transactions

  `include "fifo_output.svh" 
  `include "fifo_req.svh" 
  //`include "test_seq.svh" 

  // uvm_agents

  `include "driver.svh"
  //`include "monitor.svh"
  //`include "printer.svh"
  //`include "predictor.svh" 
  //`include "comparator.svh" 
  //`include "coverage.svh" 

  // uvm_environments
  //`include "fifo_env.svh"

  // uvm_tests
  //`include "fifo_test.svh"   
  //`include "verbose_test.svh" 


endpackage // fifo_pkg

