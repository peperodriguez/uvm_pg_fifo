package fifo_tb_pkg;
  import uvm_pkg::*;

  typedef enum {wr, rd, nop, reset} fifo_op;

  localparam int PAR_DW         = 64; // 64 bits Data Width
  localparam int PAR_DEPTH      = 16; // 16 positions deep
  localparam int PAR_CLK_PERIOD = 20; // Clock period

  virtual interface fifo_if #(PAR_DW)                             glbl_fif;
  virtual interface clk_if  #(PAR_CLK_PERIOD/2,PAR_CLK_PERIOD/2)  glbl_clk;
  virtual interface rst_if                                        glbl_rst;

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
  `include "fifo_model.svh"
  `include "scbd.svh"
  //`include "coverage.svh"

  // uvm_environments
  `include "fifo_env.svh"

  // uvm_tests
  `include "fifo_tc.svh"
  //`include "verbose_tc.svh"

endpackage // fifo_tb_pkg
