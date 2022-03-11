interface fifo_if;
  #(
    parameter dw = 32
  );

  // Port List
  logic [dw-1:0]  dout;
  logic [dw-1:0]  din;
  logic           wen;
  logic           ren;
  logic           empty;
  logic           full;

  // Monitor modport
  modport fifo_mon (
    input   din,
    input   dout,
    input   wen,
    input   ren,
    input   empty,
    input   full
  );

  // Server modport (i.e. the FIFO)
  modport fifo_srv (
    input   din,
    output  dout,
    input   wen,
    input   ren,
    output  empty,
    output  full
  );

  // Client modport (i.e. the user of the FIFO)
  modport fifo_cln (
    output  din,
    input   dout,
    output  wen,
    output  ren,
    input   empty,
    input   full
  );

endinterface : fifo_if
