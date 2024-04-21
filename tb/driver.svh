class driver extends uvm_driver #(fifo_req,fifo_output);
  `uvm_component_utils(driver)

  uvm_object                tmp;
  virtual interface fifo_if #(.DW(fifo_tb_pkg::PAR_DW)) i;
  virtual interface clk_if  ck;
  virtual interface rst_if  rst;
  fifo_req                  req;
  fifo_output               rsp;

  function new(string name="", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    i   = fifo_tb_pkg::glbl_fif.fifo_srv;
    ck  = fifo_tb_pkg::glbl_clk;
    rst = fifo_tb_pkg::glbl_rst;
  endfunction : build_phase

  task do_reset(int cycles);
    // Assert the reset for cycles cc
    rst.rst = 1;
    repeat(cycles) @(posedge ck.clk);

    // De-assert and wait 2 cc
    rst.rst = 0;
    repeat(2) @(posedge ck.clk);

  endtask : do_reset

  task run_phase(uvm_phase phase);
    forever begin : main_driver_loop
      @(negedge ck.clk);
      i.we  = 0;
      i.re  = 0;
      i.din = 0;
      seq_item_port.get_next_item(req);
      if (req != null) begin : got_req
        seq_item_port.item_done();
        case (req.op)
          wr : begin
            i.din = req.data;
            i.we  = 1;
            i.re  = 0;
          end
          rd : begin
            i.re  = 1;
            i.we  = 0;
          end
          nop : begin
          end
          reset : begin
            do_reset(4);
            i.we = 0;
            i.re = 0;
          end
        endcase
      end : got_req
      @(posedge ck.clk);
      rsp       = new;
      rsp.data  = i.dout;
      rsp.empty = i.empty;
      rsp.full  = i.full;
      rsp.set_id_info(req);
      seq_item_port.put_response(rsp);
    end : main_driver_loop
  endtask

endclass
