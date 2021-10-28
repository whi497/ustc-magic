module test (
    input a,b,c,
    output s1,s2
); 
   assign s1=~a&~b&c | ~a&b&~c | a&~b&~c | a&b&c;
   assign s2=~a&b&c | a&~b&c | a&b&~c | ~a&~b&~c;
endmodule