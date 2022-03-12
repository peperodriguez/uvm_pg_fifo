class fifo_model #(fifo_size = 4) extends uvm_agent;
  `uvm_component_utils(fifo_model)

  uvm_tlm_analysis_fifo #(fifo_req) req_f;
  uvm_put_port #(fifo_output) rsp_f;


  logic [fifo_pkg::par_dw:0] mem[$:fifo_size - 1];
  logic empty;
  logic full;
  

  function new (string name = "", uvm_component parent)
    super.new(name, parent);
    mem   = {};
    empty = 1'b1;
    full  = 1'b0;
  endfunction : new

  function build_phase(uvm_phase phase);
    super.build_phase(phase);
    req_f = new("req_f", this);
    rsp_f = new("rsp_f", this);
  endfunction : build_phase 

  task run_phase(uvm_phase phase);
  endtask : run_phase
  

endclass : fifo_model
