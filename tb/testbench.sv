import uvm_pkg::*;
import fifo_pkg::*;

module top;

  fifo_if #(.dw(fifo_pkg::par_dw)) ff_if();
  fifo_scd 
  #(
    .dw(fifo_pkg::par_dw),
    .aw(fifo_pkg::par_aw)
  ) DUT (
    .clk    (),
    .rst_n  (),

    .din    (ff_if.fifo_drv.din),
    .ren    (ff_if.fifo_drv.ren),
    .wen    (ff_if.fifo_drv.wen),

    .dout   (ff_if.fifo_drv.dout),
    .empty  (ff_if.fifo_drv.empty),
    .full   (ff_if.fifo_drv.full)
  )

  initial begin
    string test_name;
    $dumpfile ("fifo_tb_results.vcd");
    $dumpvars (0,top);
    fifo_pkg::glbl_fif = ff_if;

    run_test();

  end

endmodule
