# uvm_pg_fifo

UVM Playground with a simple single-clock FIFO.



## EDA Playground Instructions

The playgroung is at https://www.edaplayground.com and it is named "edapg_uvm_fifo".

Files can only be uploaded manually to EDA Playground.

The file `uvm_pg_fifo/filelist`contains a list of the files passed by the EDA Playground run script to incisive.

### Settings

Tools & Simulators : "Cadence Xcelium 20.09"

Compile options : "-timescale 1ns/1ns -sysv"

Run options : "-access +rw -f filelist +UVM_TESTNAME=fifo_tc"

Deselect both "run.do" and "run.bash"
