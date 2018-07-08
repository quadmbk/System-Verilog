`include "Environment.sv"

program automatic tb(
                      //intf.DRIVER driv_intf, //driver interface
                      //intf.MONITOR mon_intf  //monitor interface
                      intf i1
                     );

Environment env;

initial begin
  env = new(i1,10);
  //env.no_transaction = 4;
  env.reset();
  env.run();
  env.wrap_up();
  
  #200;
  
end
endprogram
