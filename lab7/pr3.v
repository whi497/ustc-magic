module time_count (
    input clk,rst,
    output reg [3:0] out,
    output reg [2:0] selsct
);
    wire clk_n,locked;
    wire pulse_10hz;
    reg [3:0] outm ;reg [3:0] outss;reg [3:0] outsg;reg [3:0] outst;
    reg [1:0] enable;
    reg [19:0] cout;
    clk_wiz_0 clk_wiz_0_insrt(.clk_in1(clk),.clk_out1(clk_n),.reset(rst),.locked(locked));
    always@(*)
    begin
        case(enable)
        2'd0:begin out=outst; selsct=3'd0; end
        2'd1:begin out=outsg; selsct=3'd1; end
        2'd2:begin out=outss; selsct=3'd2; end
        2'd3:begin out=outm; selsct=3'd3; end
        default:begin out=4'b0; selsct=3'd0; end
        endcase
    end
    always@(posedge clk_n or posedge rst)                     
    begin
        if(rst)
        begin
            cout<=20'b0;
            enable<=2'b0;
        end
        else
        begin
            if(cout>=20'd999999)
            cout<=20'b0;
            else cout<=cout+20'b1;
            enable<=enable+2'b1;
        end
    end
    assign pulse_10hz=(cout==20'd999999);
    always@(posedge clk_n or posedge rst)
    begin
        if(rst==1'b1)
        begin
            outm<=4'd1;
            outss<=4'd2;
            outsg<=4'd3;
            outst<=4'd4;
        end
        else
        begin
            if(pulse_10hz)
            begin
                if(outst>=4'd9)
                begin
                    outst<=4'b0;
                    if(outsg>=4'd9)
                    begin
                        outsg<=4'b0;                                                                                                                     
                        if(outss>=4'd5)
                        begin
                            outss<=4'b0;
                            outm<=outm+4'b1;
                        end
                        else outss<=outss+4'b1;
                    end
                    else outsg<=outsg+4'b1;
                end
                else outst<=outst+4'b1;
            end
        end
    end
endmodule

