class fifo_if_holder extends uvm_object;

  virtual interface  fifo_if  fif;

  function new(virtual interface fifo_if ifif);

    fif = ifif;

  endfunction : new

endclass : fifo_if_holder
