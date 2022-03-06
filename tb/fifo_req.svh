class fifo_req #(dw = 64) extends fifo_output#(dw);

  `uvm_object_utils(fifo_output)    

  rand fifo_op op;

  function new();
    super.new();
  endfunction : new

  function string convert2string();
    return {super.convert2string()," ", $psprintf("op: %s", op)};
  endfunction : convert2string

  function void do_copy(uvm_object rhs);
    fifo_output  RHS;
    super.do_copy(rhs);
    $cast(RHS, rhs);
    op  = RHS.op;
  endfunction : do_copy


endclass : fifo_req
