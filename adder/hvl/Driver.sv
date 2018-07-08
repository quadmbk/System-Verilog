package Driver_pkg;
import Transaction_pkg::*;
class Driver;
    mailbox gen2drv;
    
    virtual intf.DRIVER add_vif;
    
    int no_transaction;
    
    function new(mailbox gen2drv, virtual intf.DRIVER i1,int no);
      this.gen2drv = gen2drv;
      add_vif      = i1;
      //no_transaction = no;
    endfunction
    
    extern task reset();
    extern task run();
endclass

task Driver::reset();
       $display("=================================");
       $display("@%t ns: DRIVER : reset() started",$time);
       $display("=================================");  
       
       add_vif.reset <= 1;
       #5 add_vif.reset <= 0;
       $display("=================================");
       $display("@%t ns: DRIVER : reset() ended",$time);
       $display("=================================");  

endtask

task Driver::run();
       $display("=================================");
       $display("@%t ns: DRIVER : run() started",$time);
       $display("=================================");  
       
      
       forever begin
          Transaction trans;
         gen2drv.get(trans);
         
         @(add_vif.driv_cb);
        $display("Driving Transaction: ");
         trans.display();
         add_vif.driv_cb.a <= trans.a;
         add_vif.driv_cb.b <= trans.b;
         add_vif.driv_cb.valid <= trans.valid;
         no_transaction++;
        // @(add_vif.driv_cb);
       end
       
       $display("=================================");
       $display("@%t ns: DRIVER : run() ended",$time);
       $display("=================================");  
       
endtask
endpackage