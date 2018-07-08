package Monitor_pkg;
class Monitor;
  virtual intf.MONITOR mon_vif;
  
  function new(virtual intf.MONITOR i1);
    mon_vif = i1;
  endfunction
  
  extern task run;
  extern function void check(input logic[3:0] a,b, input logic[6:0]c, input logic valid );
endclass

task Monitor::run;
       $display("=================================");
       $display("@%t ns: MONITOR : run() started",$time);
       $display("=================================");  
    
  
    forever begin
      logic [3:0] a,b;
    logic valid;
    logic [6:0]c;
    
    @(posedge mon_vif.clk);
    a = mon_vif.a;
    b = mon_vif.b;
    valid = mon_vif.valid;
    @(negedge mon_vif.clk);
    c = mon_vif.c;
    check(a,b,c,valid);
      
    end
       $display("=================================");
       $display("@%t ns: MONITOR : run() ended",$time);
       $display("=================================");  
    
endtask

function void Monitor::check(input logic[3:0] a,b, input logic[6:0]c,input logic valid);
  if(valid)begin
    $display("@%t ns: Monitor says Valid = 1 Checking.",$time);
    $display("a=%3h, b=%3h, c=%b ",a,b,c);
    if((a+b)==c)$display("PASS");
    else begin $display("FAIL"); $stop;end
    
  end
  else
    $display("@ %t ns :a=%3h, b=%3h, Valid=0, MONITOR says :Looking for next. STOP WASTING MY TIME.",$time,a,b);
endfunction
endpackage