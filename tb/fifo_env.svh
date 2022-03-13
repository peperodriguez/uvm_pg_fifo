`include "uvm_macros.svh"

class fifo_env extends uvm_env;
  `uvm_component_utils(fifo_env)

  test_seq seq;
  driver d;

  uvm_sequencer #(fifo_req, fifo_output) sqr;

  monitor m;
  //coverage cov;
  scbd s;
  fifo_model mdl;

  printer #(fifo_req) p_req;
  printer #(fifo_output) p_rsp;

  uvm_tlm_fifo #(fifo_req) t2d_f;
  uvm_tlm_fifo #(fifo_output) mdl2s_f;

  function new(string name = "", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Sequence and driver. These are the ones sending stuff to the DUT
    seq = test_seq::type_id::create("seq",this);
    d = driver::type_id::create("d",this); 

    sqr = new("sqr",this);

    // Listeners
    m = monitor::type_id::create("m",this);
    //cov = coverage::type_id::create("cov",this);

    // Analysis
    p_req = printer#(fifo_req)::type_id::create("p_req",this);
    p_rsp = printer#(fifo_output)::type_id::create("p_rsp",this);
    t2d_f = new("t2d_f",this);
    s = scbd::type_id::create("s",this);
    mdl = fifo_model::type_id::create("mdl",this);
    mdl2s_f = new("mdl2s_f",this);
      
  endfunction : build_phase 

  function connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // Driver connected to sequencer
    d.seq_item_port.connect(sqr.seq_item_export);

    // Model connected to scoreboard through a fifo mdl2s_f
    // The fifo_model instance writes to the fifo (through the rsp_p)
    // and the scbd instance reads from the fifo (thropugh the predicted_p)
    mdl.rsp_p.connect(mdl2s_f.blocking_put_export);
    s.predicted_p.connect(mdl2s_f.blocking_get_export);

    // Monitor as a broadcaster of reqs and rsps captured at the DUT

    // Requests sent to the fifo model, the requests printer and the coverage
    m.req_p.connect(mdl.req_f.analysis_export);
    m.req_p.connect(p_req.d_f.analysis_export);
    //m.req_p.connect(cov.req_f.analysis_export);

    // Responses sent to the scbd, the responses printer and the coverage
    m.rsp_p.connect(s.actual_f.analysis_export);
    m.rsp_p.connect(p_rsp.d_f.analysis_export);
    //m.rsp_p.connect(cov.output_f.analysis_export);
     
  endfunction : connect_phase

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(sqr);
    phase.drop_objection(this);
  endtask : run_phase

endclass : fifo_env
