module top;
  bit clk;
  
//CLOCK GENERATOR
initial 
  forever #1 clk = !clk; //period = 2ns

//interface instantiation
intf i1(clk);
adder add_dut(
  	             .clk(clk)	,
	              .reset(i1.reset),
                .a(i1.a)	,
                .b(i1.b)	,
                .valid(i1.valid),
                .c(i1.c)  		);
                
tb test (i1);
endmodule
