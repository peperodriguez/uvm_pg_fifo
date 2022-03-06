class fifo_output #(dw = 64) extends uvm_sequence_item;

  `uvm_object_utils(fifo_output)    

  rand logic [dw-1:0] data;
  logic empty;
  logic full;

  function new();
    super.new();
  endfunction : new

  function string convert2string();
    return $psprintf("data: %h, empty: %b, full: %b", data, empty, full);
  endfunction : convert2string

  function void do_copy(uvm_object rhs);
    fifo_output  RHS;
    super.do_copy(rhs);
    $cast(RHS, rhs);
    data  = RHS.data;
    empty = RHS.empty;
    full  = RHS.full;
  endfunction : do_copy

  function bit comp(uvm_object rhs);
    fifo_output RHS;
    $cast(RHS,rhs);
    return (data == RHS.data) && (empty==RHS.empty) && (full==RHS.full);
  endfunction : comp

endclass : fifo_output
