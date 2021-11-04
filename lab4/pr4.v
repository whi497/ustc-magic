module sub_test (
    input a,b,
    output c
);
   assign c=(a<b)?a:b; 
endmodule

module top_module (
    input a,b,c,
    output o
);
   wire temp;
   sub_test test1(.a(a),.b(b),.c(temp));
   sub_test test2(temp,c,o); 
endmodule