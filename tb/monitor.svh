class monitor extends uvm_agent

  `uvm_component_utils(monitor);

  virtual interface fifo_if i;
  virtual interface clk_if c;
  virtual interface rst_if r;

  uvm_analysis_port #(fifo_output) rsp_p;
  uvm_analysis_port #(fifo_req) req_p;

  function new( string name = "", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function build_phase(uvm_phase phase);
    super.build_phase(phase);
    i = fifo_pkg::glbl_fif.fifo_mon;
    c = fifo_pkg::glbl_clk;
    r = fifo_pkg::glbl_rst.rst_rcv;

    rsp_p = new("rsp_p",this);
    req_p = new("req_p",this);
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    fifo_output rsp = new();
    fifo_req    req = new();

    // Wait for reset deasserted
    wait (r.rst == 1'b0);

    forever begin : forever_loop
      @posedge(c.clk);
      #1 // Why?
      if (i.rst || i.wen  || i.ren) begin : got_an_op
        rsp.data  = i.dout;
        req.data  = i.din;
        req.empty = i.empty;
        req.full  = i.full;
        if (i.rst) 
          req.op = rst;
        else 
          req.op = i.wen ? wr : rd;
        rsp_p.write(rsp);
        req_p.write(req);
        `uvm_info("run",
                  $psprintf("Monitor detected req %s",
                            req.convert2string()),
                  UVM_DEBUG);
        `uvm_info("run",
                  $psprintf("Monitor detected rsp %s",
                            rsp.convert2string()),
                  UVM_DEBUG);
      end : got_an_op
    end : forever_loop

  endtask : run_phase

endclass : monitor
