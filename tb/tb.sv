import uvm_pkg::*;
import fifo_tb_pkg::*;

module tb;

  fifo_if #(.DW(fifo_tb_pkg::PAR_DW))           ff_i();
  clk_if  #(PAR_CLK_PERIOD/2, PAR_CLK_PERIOD/2) clk_i();
  rst_if                                        rst_i();

  fifo_scd #(
    .DW   (fifo_tb_pkg::PAR_DW),
    .DEPTH(fifo_tb_pkg::PAR_DEPTH)
  ) dut (
    .clk    (clk_i.clk),
    .rst_n  (!rst_i.rst_rcv.rst),
    .din    (ff_i.fifo_cln.din),
    .re     (ff_i.fifo_cln.re),
    .we     (ff_i.fifo_cln.we),
    .dout   (ff_i.fifo_cln.dout),
    .empty  (ff_i.fifo_cln.empty),
    .full   (ff_i.fifo_cln.full)
  );

  initial begin
    string test_name;
    $dumpfile ("fifo_tb_results.vcd");
    $dumpvars (0,tb);

    fifo_tb_pkg::glbl_fif = ff_i;
    fifo_tb_pkg::glbl_clk = clk_i;
    fifo_tb_pkg::glbl_rst = rst_i;

    run_test();
  end

endmodule
