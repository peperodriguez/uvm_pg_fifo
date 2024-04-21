class fifo_req #(DW = 64) extends uvm_sequence_item;

  `uvm_object_param_utils(fifo_req #(DW))

  rand fifo_op 			op;
  rand logic [(DW-1):0] data;

  function new(string name="", uvm_component parent=null);
    super.new(name);
  endfunction : new

  function string convert2string();
    return $psprintf("data: %h, op: %s", data, op.name());
  endfunction : convert2string

  function void do_copy(uvm_object rhs);
    fifo_req  RHS;
    super.do_copy(rhs);
    $cast(RHS, rhs);
    op  	= RHS.op;
    data  	= RHS.data;
  endfunction : do_copy
  
  function bit comp(uvm_object rhs);
    fifo_req RHS;
    $cast(RHS,rhs);
    return (data == RHS.data) && (op==RHS.op);
  endfunction : comp

endclass : fifo_req
