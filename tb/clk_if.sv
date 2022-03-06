interface clk_if;
  #(
      parameter clk_high  = 10,
      parameter clk_low   = 10
    );
  
  logic clk;

  initial begin : clk_gen
    clk = 0;
    forever begin
      #clk_low;
      clk = 1;
      #clk_high;
      clk = 0;
    end
  end

endinterface : clk_if
