// Module : mem_dp
//
// Descripion:
//              This module implements a simple dual-port memory.
//              The reason to use a module for this is to be able to
//              instantiate an eventual tech-dependent memory model.
//              The actual beh model does not reset the memory contents.
//


module mem_dp #(
  parameter int               DW = 16,  // Data width.
  parameter int               AW = 4    // Address bus width.
)(
  input   logic               clk,      // Input clock.
  input   logic               wr,       // Write enable signal.
  input   logic [AW-1:0]      wa,       // Write Address.
  input   logic [AW-1:0]      ra,       // Read Address.

  input   logic [DW-1:0]      din,      // Data to write, when wr is asserted.
  output  logic [DW-1:0]      dout      // Data read.
);

  // Memory depth calculation
  localparam      MD = 1<<AW;

  // Memory register
  logic [DW-1:0]  m [MD-1:0];

  assign dout = m[ra];

  always_ff @(posedge clk) begin : mem_write_proc
    if (wr) begin
      m[wa] <= din;
    end
  end : mem_write_proc

endmodule
