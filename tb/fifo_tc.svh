`include "uvm_macros.svh"

class fifo_tc extends uvm_test;
  `uvm_component_utils(fifo_tc)

  fifo_env e;

  function new(string name = "", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e = fifo_env::type_id::create("e",this);
  endfunction : build_phase
  
  virtual task run_phase (uvm_phase phase);
    phase.raise_objection(this);
    
    phase.drop_objection(this);
  endtask : run_phase

endclass : fifo_tc
