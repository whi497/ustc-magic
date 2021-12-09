module top_module (
    input clk,
    input in,
    output out
);
    reg temp_in,out1;
    initial
    begin
      out1<=0;
    end
    always @(posedge clk) begin
        temp_in <= in;
       	out1 <= ~temp_in & in;
    end
    assign out=out1;
endmodule