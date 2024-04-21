class test_seq extends uvm_sequence #(fifo_req,fifo_output);
  `uvm_object_utils(test_seq)

  fifo_req req;
  fifo_output rsp;

  function new(string name = "");
    super.new(name);
  endfunction: new
  
  task do_write(logic [(fifo_tb_pkg::PAR_DW-1):0] d);
    req       = new();
    start_item(req);
    req.op    = wr;
    req.data  = d;
    `uvm_info("test_seq",{"Sending transaction ",req.convert2string()}, UVM_MEDIUM);
    finish_item(req);
    get_response(rsp);
    `uvm_info("test_seq",{"Got back: ",rsp.convert2string()},UVM_MEDIUM);
  endtask: do_write
  
  task do_read();
	req = new();
	start_item(req);
	req.op    = rd;
	req.data  = '{fifo_tb_pkg::PAR_DW{1}};
	`uvm_info("test_seq",{"Sending transaction ",req.convert2string()}, UVM_MEDIUM);
	finish_item(req);
	get_response(rsp);
	`uvm_info("test_seq",{"Got back: ",rsp.convert2string()},UVM_MEDIUM);
  endtask: do_read

  task body();

    // Reset
    req     = new();
    start_item(req);
    req.op  = reset;
    `uvm_info("test_seq",{"Sending transaction ",req.convert2string()}, UVM_MEDIUM);
    finish_item(req);
    get_response(rsp);
    `uvm_info("test_seq",{"Got back: ",rsp.convert2string()},UVM_MEDIUM);

    // Write
    do_write(64'h1234abcd6789cafe);
    do_write(64'h1234abcd6789beef);

    // Read
    do_read();
    do_read();
    do_read();
    
    // Write loop
    for (int i = 0; i < 20; i++) begin
    	do_write(64'h1234abcd6789beef);
    end

  endtask : body

endclass : test_seq
