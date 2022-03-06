module fifo_scd
#(
  parameter aw = 8,
  parameter dw = 32
)
(
  input logic clk,
  input logic rst_n,

  input logic [dw-1:0] din,
  input logic ren,
  input logic wen,

  output logic [dw-1:0] dout,
  output logic empty,
  output logic full
)

localparam sz = 1<<aw;

logic [dw-1:0] m[dw-1:0];
logic empty_r;
logic full_r;
logic [aw:0] rp;
logic [aw:0] wp;

assign empty_r = wp == rp;
assign full_r = (wp[aw]!=rp[aw]) && (wp[aw-1:0]==rp[aw-1:0]);


assign empty = empty_r;
assign full = full_r;

always_ff @(posedge clk) begin : mem_handling
  if (wen && !full_r) m[wp[aw-1:0]] <= din;
  dout <= m[rp[aw-1:0]];
  end

  always_ff @(posedge clk) begin : ptr_handling
    if (!rst_n) begin
      rp <= 'd0;
      wp <= 'd0;
    end else begin
      if (wen && !full_r) begin
        wp <= wp + 1;
      end

      if (ren && !empty_r) begin
        rp <= rp +1;
      end

    end
  end
