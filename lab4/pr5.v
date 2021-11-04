module sub_test (
    input a,b,
    output o
);
   assign o=a+b; 
endmodule

module top_module (
    input a,b,
    output c
);
   sub_test test(a,b,c); 
endmodule