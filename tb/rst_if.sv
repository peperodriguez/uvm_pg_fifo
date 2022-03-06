interface rst_if;
  
  logic rst;

  modport rst_drv ( input  rst );
  modport rst_rcv ( output rst );

endinterface : clk_if
