class test_seq extends uvm_sequence #(fifo_req,fifo_output);
  `uvm_objects_utils(test_seq)

  fifo_req req;
  fifo_output rsp;

  function new(string name = "");
    super.new(name);
  endfunction: new
  
  task body();

    // Reset
    req = new();
    start_item(req);
    req.op = reset;
    `uvm_info("test_seq",{"Sending transaction ",req.convert2string()}, UVM_MEDIUM);
    finish_item(req);
    get_response(rsp);
    `uvm_info("test_seq",{"Got back: ",rsp.convert2string()},UVM_MEDIUM);

    // Write once
    req = new();
    start_item(req);
    req.op = wr;
    req.data = fifo_pkg::par_dw'h1;
    `uvm_info("test_seq",{"Sending transaction ",req.convert2string()}, UVM_MEDIUM);
    finish_item(req);
    get_response(rsp);
    `uvm_info("test_seq",{"Got back: ",rsp.convert2string()},UVM_MEDIUM);


    // Read once
    req = new();
    start_item(req);
    req = new();
    start_item(req);
    req.op = rd;
    req.data = fifo_pkg::par_dw'h1;
    `uvm_info("test_seq",{"Sending transaction ",req.convert2string()}, UVM_MEDIUM);
    finish_item(req);
    get_response(rsp);
    `uvm_info("test_seq",{"Got back: ",rsp.convert2string()},UVM_MEDIUM);
    
  endtask : body

endclass : test_seq
