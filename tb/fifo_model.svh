class fifo_model #(fifo_size = 4) extends uvm_agent;
  `uvm_component_utils(fifo_model)

  uvm_tlm_analysis_fifo #(fifo_req) req_f;
  uvm_put_port #(fifo_output) rsp_p;


  logic [fifo_pkg::par_dw:0] mem[$:fifo_size - 1];
  logic empty;
  logic full;
  

  function new (string name = "", uvm_component parent);
    super.new(name, parent);
    mem   = {};
    empty = 1'b1;
    full  = 1'b0;
  endfunction : new

  function build_phase(uvm_phase phase);
    super.build_phase(phase);
    req_f = new("req_f", this);
    rsp_p = new("rsp_p", this);
  endfunction : build_phase 

  task run_phase(uvm_phase phase);
    fifo_req req;
    fifo_output rsp = new(), cln;

    forever begin : forever_loop
      req_f.get(req);
      case (req.op)
        reset : begin
          mem   = {};
          empty = 1'b1;
          full  = 1'b0;
        end
        wr : begin 
          if (!full) begin
            mem.push_back(req.data);
            if (mem.size() == fifo_size) full = 1'b1;
            empty = 1'b0;
          end
        end
        rd : begin
          if (!empty) begin
            mem.pop_front();
            if (mem.size() == 0) empty = 1'b1;
            full = 1'b0;
          end
        end
      endcase
      rsp.data = mem[0];
      rsp.empty = empty;
      rsp.full = full;
      $cast(cln,rsp.clone());
      rsp_p.put(cln);
      `uvm_info("run", $psprintf("fifo_model output %s", rsp.convert2string()), UVM_DEBUG);
    end : forever_loop
  endtask : run_phase
  

endclass : fifo_model
