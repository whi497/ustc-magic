module hexdisplay (
    input [7:0] IN, 
    input clk,rst,
    output reg [3:0] OUT,
    output reg [2:0] selsct
);
    reg enable;
    wire clk_n,locked;
    clk_wiz_0 clk_wiz_0_insrt(.clk_in1(clk),.clk_out1(clk_n),.reset(rst),.locked(locked));
    always@(*)
    begin
        OUT<=(enable)?IN[7:4]:IN[3:0];
        selsct<=(enable)?(3'b1):(3'b0);
    end
    always@(posedge clk_n or posedge rst)
    begin
        if(rst==1'b1)
        begin
            enable<=1'b0;
            OUT<=1'b0;
        end
        else 
        begin
            enable<=enable+1'b1;
        end
    end
endmodule