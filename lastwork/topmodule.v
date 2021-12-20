`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:
// Design Name: 
// Module Name:
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module topmodule (
    input clk,button,
    input rx,
    input [7:0] sw,
    output [7:0] led,
    output tx,
    output reg [3:0] out,
    output reg [2:0] selsct
);
    wire rst;
    wire clk_n;
    wire button_n;
    wire button_edge;
    wire rst_n,rst_edge;
    jtrclr clr(.clk(clk),.button(button),.button_n(button_n));
    signal_edge cedge(.clk(clk),.button(button_n),.button_edge(button_edge));
    clk_wiz_0 clk_wiz_0_insrt(.clk_in1(clk),.clk_out1(clk_n),.reset(rst),.locked(locked));

    parameter IDLE  = 4'd0;
    parameter LOCKED= 4'd1;
    parameter ERROR = 4'd2;
    parameter ERRORLOCKED= 4'd3;
    parameter WORK = 4'd4;
    parameter CLOCK = 4'd5;

    parameter A = 2'd0;
    parameter B = 2'd1;
    parameter C = 2'd2;
    parameter E = 2'd3;

    reg usercheck;
    reg er;
    reg [1:0] error_cout;
    reg [3:0] curr_state;
    reg [3:0] next_state;

    wire is_reset_cmd;
    wire is_check_cmd;
    wire is_start_cmd;
    wire is_setcl_cmd;
    wire is_exit_cmd;
    wire is_shutdown_cmd;
    reg [1:0] inputcout;
    reg [1:0] pa_custate;
    reg [1:0] pa_nestate;
    reg [7:0] password1;
    reg [7:0] password2;
    reg [7:0] password3;

    wire wr_ry;
    reg [19:0] cout;
    reg [3:0] clock [6:0];
    wire [3:0] cltemp [6:1];
    wire clockfinished;
    reg clockstart;
    wire pulse_10hz;

    reg [3:0] hexdisplay [7:0];

    iouart IO(.clk(clk),.rst(rst),.rx(rx),.tx(tx),.er(er),
            .is_check_cmd(is_check_cmd),.is_start_cmd(is_start_cmd),
            .is_reset_cmd(is_reset_cmd),.is_setcl_cmd(is_setcl_cmd),
            .is_exit_cmd(is_exit_cmd),.is_shutdown_cmd(is_shutdown_cmd),
            .wr_ry(wr_ry),
            .clock1(cltemp[1]),.clock2(cltemp[2]),.clock3(cltemp[3]),
            .clock4(cltemp[4]),.clock5(cltemp[5]),.clock6(cltemp[6]));   
    assign rst=is_reset_cmd||is_shutdown_cmd;
    always@(posedge clk or posedge rst)
    begin
        if(rst)begin
            curr_state  <= IDLE;
        end
        else
            curr_state  <= next_state;
    end
    always@(*)
    begin
        if(rst)next_state=IDLE;
        else begin
        case(curr_state)
        IDLE: begin if(is_start_cmd) next_state=LOCKED; else next_state=IDLE; end
        LOCKED: begin
            if(is_check_cmd) begin 
                if(usercheck) next_state=WORK; 
                else begin 
                    if(error_cout==2'd2) next_state=ERRORLOCKED;
                    else next_state=ERROR;
                end
            end
            else next_state=LOCKED;
        end
        ERROR:begin
            next_state = LOCKED;
        end
        ERRORLOCKED: begin
            if(clockfinished) next_state=LOCKED;
            else next_state=ERRORLOCKED;
        end
        WORK: begin
            if(is_exit_cmd) next_state=LOCKED;
            else if(is_setcl_cmd) next_state=CLOCK; 
            else next_state=WORK;
        end
        CLOCK:begin 
            if(is_exit_cmd) next_state=WORK;
            else next_state=CLOCK;
        end
        default: next_state=IDLE; 
        endcase
    end
    end

    always@(posedge clk)
    begin
        if(rst)er<=0;
        else 
        begin 
            if(curr_state==LOCKED&&is_check_cmd&&~usercheck)
            er<=1;
            else er<=0;
        end
    end 

    always@(posedge clk or posedge rst)begin
        if(rst)begin
            usercheck<=1'b0;
            pa_custate<=A;
        end
        else begin
            if(pa_custate==C&&pa_nestate==A) usercheck<=1;
            else if(is_check_cmd) usercheck<=0;
            pa_custate<=pa_nestate;
        end
    end
    always@(posedge clk or posedge rst)begin
        if(rst)
            inputcout <= 2'b0;
        else begin
            if(button_edge)
            begin 
                inputcout<=inputcout+2'b1;
            end
        end
    end
    always@(posedge clk or posedge rst)begin
        if(rst)error_cout<=2'b0;
        else if(is_check_cmd&&(~usercheck))
        begin
            if(error_cout==2'd2)error_cout<=2'b0;
            else error_cout<=error_cout+2'b1;
        end
    end
    always@(*)begin
        if(is_check_cmd) pa_nestate=A;
        if(button_edge&&curr_state==LOCKED)begin
            case(pa_custate)
            A: begin 
                if(sw==password1)
                    pa_nestate=B;
                else pa_nestate=E;
            end
            B: begin
                if(sw==password2)
                    pa_nestate=C;
                else pa_nestate=E;
            end
            C: begin
                if(sw==password3)
                    pa_nestate=A;
                else pa_nestate=E;
            end
            E: begin
                if(inputcout==2'd3)
                    pa_nestate=A;
                else pa_nestate=E;
            end
            default: pa_nestate=A;
            endcase
        end
    end


    always@(posedge clk_n or posedge rst)                     
    begin
        if(rst)begin
            cout<=20'b0;
        end
        else begin
            if(cout>=20'd999999)
            cout<=20'b0;
            else cout<=cout+20'b1;
        end
    end
    assign pulse_10hz=(cout==20'd999999);
    always@(posedge clk)
    begin
        if(rst || clockfinished || (is_exit_cmd&&(curr_state==WORK||curr_state==CLOCK))) begin
            clock[0]<=4'b0;clock[1]<=4'b0;clock[2]<=4'b0;
            clock[3]<=4'b0;clock[4]<=4'b0;clock[5]<=4'b0;
            clock[6]<=4'b0;clock[7]<=4'b0;
            clockstart <= 1'b0;
        end
        else if(curr_state==CLOCK && button_edge)begin
            clockstart <= 1'b1;
        end
        else if(wr_ry)begin
            clock[6]<=cltemp[1];clock[5]<=cltemp[2];clock[4]<=cltemp[3];
            clock[3]<=cltemp[4];clock[2]<=cltemp[5];clock[1]<=cltemp[6];
        end
        else if(error_cout==2'd2)begin
            clock[2] <= 4'd6;
            clockstart <=1'b1;
        end
        else
            begin
                if(clockstart)
                begin
                    if(pulse_10hz)
                    begin
                        if(clock[0]==4'b0)begin
                            clock[0]<=4'd9;
                            if(clock[1]==4'b0)begin
                                clock[1]<= 4'd9;
                                if(clock[2]==4'b0)begin
                                    clock[2]<= 4'd6;
                                    if(clock[3]==4'b0)begin
                                        clock[3]<= 4'd9;
                                        if(clock[4]==4'b0)begin
                                            clock[4]<=4'd6;
                                            if(clock[5]==4'b0)begin
                                                clock[5]<= 4'd9;
                                                clock[6]<= clock[6]-4'b1;
                                            end
                                            else clock[5]<=clock[5]-4'b1;
                                        end
                                        else clock[4]<= clock[4]-4'b1;
                                    end
                                    else clock[3]<=clock[3]-4'b1;
                                end
                                else clock[2]<=clock[2]-4'b1;
                            end
                            else clock[1]<=clock[1]-4'b1;
                        end
                        else clock[0]<=clock[0]-4'b1;
                    end
                end
            end
    end
    assign clockfinished = ((clockstart&&clock[0]==1&&~clock[1]&&~clock[2]&&(curr_state==ERRORLOCKED))
                            ||(clockstart&&clock[0]==1&&~clock[1]&&~clock[2]&&~clock[3]&&~clock[4]&&
                            ~clock[5]&&~clock[6]&&(curr_state==CLOCK)));

    reg [2:0] enable;
    always@(posedge clk_n)
    begin
        if(rst||curr_state==IDLE)enable<=3'b0;
        else enable=enable+3'b1;
    end
    always@(*)
    begin
        case(enable)
        3'd0: begin out=hexdisplay[0];selsct=3'd0; end
        3'd1: begin out=hexdisplay[1];selsct=3'd1; end
        3'd2: begin out=hexdisplay[2];selsct=3'd2; end
        3'd3: begin out=hexdisplay[3];selsct=3'd3; end
        3'd4: begin out=hexdisplay[4];selsct=3'd4; end
        3'd5: begin out=hexdisplay[5];selsct=3'd5; end
        3'd6: begin out=hexdisplay[6];selsct=3'd6; end
        3'd7: begin out=hexdisplay[7];selsct=3'd7; end
        default:begin out=hexdisplay[0];selsct=3'b0; end
        endcase
    end

    always@(posedge clk)
    begin
        if(curr_state==ERRORLOCKED)
        begin
            hexdisplay[0]<=clock[0];
            hexdisplay[1]<=clock[1];
            hexdisplay[2]<=clock[2];
            hexdisplay[3]<=clock[3];
            hexdisplay[4]<=clock[4];
            hexdisplay[5]<=clock[5];
            hexdisplay[6]<=clock[6];
        end
        else begin
            hexdisplay[0]<=0;
            hexdisplay[1]<=0;
            hexdisplay[2]<=0;  
            hexdisplay[3]<=0;
            hexdisplay[4]<=0;  
            hexdisplay[5]<=0;
            hexdisplay[6]<=0;
            hexdisplay[7]<=0;
        end
    end

    assign led={2'b0,pa_custate,curr_state};

    initial begin
        usercheck=0;error_cout=0;er=0;
        password1=0;password2=0;password3=0;
        clockstart=0;
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