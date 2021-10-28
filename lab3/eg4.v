module d_ff (
    input clk,d,
    output reg q
);
    always@(posedge clk) 
        q<=d;
endmodule

module d_ff_r (
    input clk,rst_n,d,
    output reg q
);
    always@(posedge clk)
    begin
        if(rst_n==0)
            q<=1'b0;
        else
            q<=d;
    end
endmodule

module d_ff_s (
    input clk,rst_n,d,
    output reg q
);
    always@(posedge clk or negedge rst_n)
    begin
        if(rst_n==0)
            q<=1'b0;
        else
            q<=d;
    end
endmodule