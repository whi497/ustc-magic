module test(
   input a,
   output reg b 
);
   always@(*)
   begin
       if(a) b=1'b0;
       else  b=1'b1;
   end 
endmodule