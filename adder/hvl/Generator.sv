package Gen_pkg;
import Transaction_pkg::*;
import Driver_pkg::*;
class Generator;
  mailbox gen2drv;
  
  int no_transaction;
  Transaction trans;
  
  event done;
  
  function new(mailbox gen2drv,event finish,int no);
    this.gen2drv = gen2drv;
    done = finish;
    
    no_transaction = no;
    trans = new;  
  endfunction
  
  
  extern task run();
endclass

task Generator::run;
    
       $display("=================================");
       $display("@%t ns:%d GENERATOR : run() started",$time,no_transaction);
       $display("=================================");  
         
       repeat(no_transaction) begin
        assert(trans.randomize);
        trans.display();
        gen2drv.put(trans.copy);
       end
    ->done;
    
       $display("=================================");
       $display("@%t ns: GENERATOR : run() ended",$time);
       $display("=================================");  
    
endtask
endpackage