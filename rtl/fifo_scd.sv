// Module : fifo_scd
//
// Descripion:
//              This module implements a single clock FIFO.
//              It instantiates the mem_dp module.
//

module fifo_scd #(
  parameter int       DEPTH = 8,      // FIFO depth in words which are DW wide.
  parameter int       DW    = 32      // FIFO data width
)(
  input   logic           clk,        // Input clock
  input   logic           rst_n,      // Input synch reset. Active low.
  input   logic           re,         // Read Enable
  input   logic           we,         // Write Enable
  input   logic [DW-1:0]  din,        // Data input

  output  logic [DW-1:0]  dout,       // Data output
  output  logic           empty,      // FIFO empty indication
  output  logic           full        // FIFO full indication
);

  // Memory Address Width calculation
  localparam      AW = $clog2(DEPTH);

  logic [AW:0]    rp;     // Read pointer
  logic [AW:0]    wp;     // Write pointer

  assign empty = (rp == wp);
  assign full  = (rp[AW-1:0] == wp[AW-1:0]) & (rp[AW] != wp[AW]);

  always_ff @(posedge clk) begin : pointers_proc
    if (rst_n == 1'b0) begin
      wp  <= '0;
      rp  <= '0;
    end else begin
      if (we & !full) begin
        wp  <= wp + 1;
      end
      if (re & !empty) begin
        rp  <= rp + 1;
      end
    end
  end : pointers_proc

  mem_dp #(
    .DW     ( DW ),
    .AW     ( AW )
  ) mem_dp_i (
    .clk    ( clk ),
    .wr     ( we & !full ),
    .wa     ( wp[AW-1:0] ),
    .ra     ( rp[AW-1:0] ),
    .din    ( din ),
    .dout   ( dout )
  );
endmodule
