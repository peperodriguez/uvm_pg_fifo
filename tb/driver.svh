class driver extends uvm_driver #(fifo_req,fifo_output);
  `uvm_component_utils(driver);

  uvm_object                tmp;
  virtual interface fifo_if i;
  virtual interface clk_if  ck;
  fifo_req                  req;
  fifo_output               rsp;

  function new(string name="", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function build_phase(uvm_phase phase);
    super.build_phase(phase);
    i   = fifo_pkg::glbl_fif.fifo_drv;
    ck  = fifo_pkg::glbl_clk;
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    forever begin : main_driver_loop
      @(negedge ck.clk);
      i.wen = 0;
      i.ren = 0;
      i.din = 0;
      seq_item_port.get_next_item(req);
      if (req != null) begin : got_req
        seq_item_port.item_done();
        case (req.op)
          wr : begin
            i.din = req.data;
            i.wen = 1;
            i.ren = 0;
          end
          rd : begin
            i.ren = 1;
            i.wen = 0;
          end
          nop : begin 
          end
          reset : begin 
          end
        endcase
      end : got_req
      @(posedge ck.clk);
      rsp       = new;
      rsp.data  = i.dout;
      rsp.empty = i.empty;
      rsp.full  = i.full;
      rsp.set_id_info(req);
      set_item_port.put_response(rsp);
    end : main_driver_loop
  endtask



endclass
