package Transaction_pkg;
class Transaction;
    rand bit [3:0] a,b;
    rand bit valid;
    
    
    virtual function void display();
      $display("@%t ns: The vlaues are: ",$time);
      $display("a= %3h, b=%3h, valid=%3h",a,b,valid); 
    endfunction
    
    virtual function Transaction copy();
      //returns an object 
      copy = new;
      copy.a = this.a;
      copy.b = this.b;
      copy.valid = this.valid;
      
      return copy;
    endfunction
    
    virtual function Transaction wrap(input logic [3:0] a, b, input logic valid);
      if($isunknown(a) || $isunknown(b) || $isunknown(valid) )
       begin
         $display("UNKNOWN VALUE FOUND");
         $stop;
       end 
     else
       begin
         Transaction temp;
         temp = new;
         temp.a = a;
         temp.b = b;
         temp.valid = valid;
         
         return temp;
       end
   endfunction
endclass
endpackage