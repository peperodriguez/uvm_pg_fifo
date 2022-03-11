class printer #(type T=fifo_output) extends uvm_agent;
  typedef printer#(T) thistype;
  `uvm_component_param_utils(thistype)

  uvm_tlm_analysis_fifo #(T) d_f;

  function new(string name = "", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    d_f = new("d_f",this);
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    T d;
    forever begin
      d_f.get(d);
      `uvm_info("run",d.convert2string(),UVM_MEDIUM);
    end
  endtask : run_phase
  
endclass : printer
