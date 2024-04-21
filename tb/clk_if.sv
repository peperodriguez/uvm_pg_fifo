interface clk_if #(
  parameter int CLK_HIGH  = 10,
  parameter int CLK_LOW   = 10
);

  logic clk;

  initial begin : clk_gen
    clk = 0;
    forever begin
      #CLK_LOW;
      clk = 1;
      #CLK_HIGH;
      clk = 0;
    end
  end

endinterface : clk_if
