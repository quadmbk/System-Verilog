import Monitor_pkg::*;
import Gen_pkg::*;
import Driver_pkg::*;
class Environment;
    Generator gen;
    Driver    drv;
    Monitor   mon;
    
    //mailbox
    mailbox gen2drv;
    
    virtual intf i1;
    
    //no of tansactions
    int no_transaction;
    
    //event to indicate gen has ended
    event gen_ended;
    
    function new(virtual intf vi1,int n);
      i1      = vi1;
      no_transaction = n;
 
      gen2drv = new();
      
      gen     = new(gen2drv, gen_ended,no_transaction);
      drv     = new(gen2drv, i1,no_transaction);
      mon     = new(i1);
    endfunction
    
    //build task
    task reset();
      $display("=================================");
      $display("@%t ns: ENV : reset() started",$time);
      $display("=================================");
      
      drv.reset();
     
      $display("=================================");
      $display("@%t ns: ENV : reset() ended",$time);
      $display("=================================");
      
    endtask
    
    task run();
      $display("=================================");
      $display("@%t ns: ENV : run() started",$time);
      $display("=================================");
      
      fork
        drv.run();
        gen.run();
        mon.run();
      join_any
    endtask
    
    task wrap_up();
      $display("=================================");
      $display("@%t ns: ENV : wrap_up() started",$time);
      $display("=================================");
      
      wait(gen_ended.triggered);
      wait(gen.no_transaction == drv.no_transaction);
      $display("=================================");
      $display("@%t ns: ENV : wrap_up() ended",$time);
      $display("=================================");
      $stop;
    endtask
endclass
