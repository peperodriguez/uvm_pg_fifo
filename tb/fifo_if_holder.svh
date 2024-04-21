class fifo_if_holder extends uvm_object;

  virtual interface  fifo_if  fif;

  function new(virtual interface fifo_if i);

    fif = i;

  endfunction : new

endclass : fifo_if_holder
