class scbd extends uvm_agent;
  `uvm_component_utils(scbd)

  uvm_tlm_analysis_fifo #(fifo_output) actual_f;
  uvm_get_port          #(fifo_output) predicted_f;

  fifo_output actual, predicted;

  function new(string name = "", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    predicted_f = new("req_f",this);
    actual_f = new("actual_f",this);
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    forever begin : forever_loop
      actual_f.get(actual);
      `uvm_info("run", $psprintf("SCBD Actual: %s", actual.convert2string()), UVM_DEBUG)
      predicted_f.get(predicted);
      `uvm_info("run", $psprintf("SCBD Predicted: %s", actual.convert2string()), UVM_DEBUG)

      if (actual.comp(predicted))
        `uvm_info("run", $psprintf("passed: %s", actual.convert2string()), UVM_MEDIUM)
      else
        `uvm_error("run", $psprintf("FAILED: Expected:  %s Actual: %s", predicted.convert2string(), actual.convert2string()))

    end : forever_loop
  endtask : run_phase
  
endclass : scbd
