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
    output  dout,
    input   wen,
    input   ren,
    output  empty,
    output  full
  );
  // Driver modport
  modport fifo_drv (
    output  din,
    input   dout,
    output  wen,
    output  ren,
    input   empty,
    input   full
  );

endinterface : fifo_if
