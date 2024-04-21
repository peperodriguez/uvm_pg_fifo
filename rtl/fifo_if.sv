interface fifo_if #(
    parameter DW = 32
  );

  // Port List
  logic [DW-1:0]  dout;
  logic [DW-1:0]  din;
  logic           we;
  logic           re;
  logic           empty;
  logic           full;

  // Monitor modport
  modport fifo_mon (
    output   din,
    output   dout,
    output   we,
    output   re,
    output   empty,
    output   full
  );

  // Server modport (i.e. the FIFO)
  modport fifo_srv (
    input   din,
    output  dout,
    input   we,
    input   re,
    output  empty,
    output  full
  );

  // Client modport (i.e. the user of the FIFO)
  modport fifo_cln (
    output  din,
    input   dout,
    output  we,
    output  re,
    input   empty,
    input   full
  );

endinterface : fifo_if
