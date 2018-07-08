/*
            ---------------
 valid ---->|             |
            |			          |
    a -/--->|       	     |
            |   adder     |---/-> c
    b -/--->|             |
            |             |
            ---------------
               ^      ^ 
               |      |
              clk   reset

*/
module adder(
  input 	   clk	,
  input 	   reset,
  input  [3:0] a	,
  input  [3:0] b	,
  input        valid,
  output [6:0] c  		); 
  
  reg [6:0] tmp_c;
  
  //Reset 
  always @(posedge reset) 
    tmp_c <= 0;
   
  // Waddition operation
  always @(posedge clk) 
    if (valid)    tmp_c <= a + b;
  
  assign c = tmp_c;

endmodule

module directed_tb;
reg clk,reset;
reg [3:0]a,b;
reg valid;
wire [6:0] c;

adder a1(
   	   clk	,
   	   reset,
   a	,
   b	,
         valid,
  c  		); 
  
 initial begin
  clk = 0;
  forever #1 clk = ~clk;
 end   
 
 initial begin
   reset = 1;
   #5 reset = 0;
   #1 a = 3; b= 2; valid =1;
 end
endmodule