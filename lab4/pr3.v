module test (
    output [7:0] c,d,e,f,g,h,i,j,k
);
   wire [7:0] a,b;
   assign a=8'b0011_0011;
   assign b=8'b1111_0000;
   assign c=a&b;
   assign d=a|b;
   assign e=a^b;
   assign f=~a;
   assign g={a[3:0],b[3:0]};
   assign h=a>>3;
   assign i=&b;
   assign j=(a>b)?a:b;
   assign k=a-b;
endmodule