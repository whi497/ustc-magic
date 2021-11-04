module test(
    input [7:0] a,
    output reg [7:0] b
);
   always@(*) 
   begin
       b=a;
   end
endmodule