import uvm_pkg::*;
import fifo_pkg::*;

module top;

  fifo_if #(.dw(fifo_pkg::par_dw)) ff_i();
  clk_if #(par_clk_period/2, par_clk_period/2) ck_i();
  rst_if rst_i();

  fifo_scd 
  #(
    .dw(fifo_pkg::par_dw),
    .aw(fifo_pkg::par_aw)
  ) DUT (
    .clk    (clk_i.clk),
    .rst_n  (!rst_i.rst),

    .din    (ff_i.fifo_drv.din),
    .ren    (ff_i.fifo_drv.ren),
    .wen    (ff_i.fifo_drv.wen),

    .dout   (ff_i.fifo_drv.dout),
    .empty  (ff_i.fifo_drv.empty),
    .full   (ff_i.fifo_drv.full)
  )

  initial begin
    string test_name;
    $dumpfile ("fifo_tb_results.vcd");
    $dumpvars (0,top);

    fifo_pkg::glbl_fif = ff_i;
    fifo_pkg::glbl_clk = clk_i;
    fifo_pkg::glbl_rst = rst_i;

    run_test();

  end

endmodule
