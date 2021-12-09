module counter (
    input clk,button,
    input [2:0] sw,
    output reg [3:0] out,
    output reg [2:0] selsct
);
    wire clk_n;
    wire button_n;
    wire button_edge;
    reg enable;
    reg [7:0] result;
    jtrclr clr(.clk(clk),.button(button),.button_n(button_n));
    signal_edge cedge(.clk(clk),.button(button_n),.button_edge(button_edge));
    clk_wiz_0 clk_wiz_0_insrt(.clk_in1(clk),.clk_out1(clk_n),.reset(sw[1]),.locked(locked));
    always@(posedge clk or posedge sw[1])
    begin
        if(sw[1])
        begin
            result<=8'h1f;
        end
        else
        begin
            if(button_edge)
            begin
                if(sw[0]) result<=result+8'b1;
                else result<=result-8'b1;
            end
        end
    end
    always@(posedge clk_n or posedge sw[1])                     
    begin
        if(sw[1]) enable<=1'b0;
        else enable<=enable+1'b1;
    end
    always@(*)
    begin
        case(enable)
        1'b0:begin selsct=3'b0; out=result[3:0]; end
        1'b1:begin selsct=3'b1; out=result[7:4]; end
        default:begin selsct=3'b0; out=result[3:0]; end
        endcase
    end
endmodule



module jtrclr (
    input clk,button,
    output button_n
);
    reg [3:0] cnt;
    always@(posedge clk)
    begin
        if(button==1'b0) cnt<=4'h0;
        else if(cnt<4'h8)cnt<=cnt+4'b1;
    end
    assign button_n=cnt[3];
endmodule

module signal_edge(
    input clk,button,
    output button_edge
);
    reg button_r1,button_r2;
    always@(posedge clk)
    begin
        button_r1<=button;
    end
    always@(posedge clk)
    begin
        button_r2<=button_r1;
    end
    assign button_edge=button_r1&(~button_r2);
endmodule