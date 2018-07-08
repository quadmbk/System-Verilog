interface intf(input bit clk);
  logic valid;
  logic [3:0]a,b; //operands
  logic [6:0]c;   //sum and carry
  logic reset;
clocking driv_cb @(negedge clk);
  //clocking block drives and samples tb signals on negegde
  output a,b;
  output valid;
endclocking : driv_cb

/*clocking mon_cb @(negedge clk);
  input a,b;
  input c;
  input valid;
endclocking : mon_cb
*/
modport DRIVER    (clocking driv_cb,output reset);
modport MONITOR       (/*clocking mon_cb*/ input a,b,c,valid , input reset,input clk);

endinterface
