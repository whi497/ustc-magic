`timescale 1ns / 1ps
/*
模块功能简介
接收来自rx_pin 的 uart 数据v
将接收到的数据完成后，将我们的数据的rx_data_valid 置位有效

# 然后将收到的数据 通过rx_data 发送出去


*/


module uart_rx

#( 
    parameter clk_fre = 50,
    parameter baud_rate = 115200
)
(

    input clk,
    input rst_n,
    
    input rx_pin,
    
        
    input rx_data_ready,
    
    output reg rx_data_valid,
    output reg [7:0] rx_data
);
//calculates the clock cycle for baud rate 
localparam cycle = clk_fre * 1000000/baud_rate;
parameter rx_idle=3'b000;
parameter rx_start=3'b001;
parameter rx_rcv_byte=3'b010;
parameter rx_stop=3'b011;
parameter rx_data_state =3'b100;

reg [2:0]rx_state=0;
reg [2:0]next_stae;
reg rx_d0;
reg rx_d1;

wire rx_negedge;
reg [7:0] rx_bits=0;
reg [15:0] cycle_cnt=0;
reg [2:0] bit_cnt=0;

assign rx_negedge = rx_d1 && ~rx_d0;


// This part is for detecting the start of the translation f
always @(posedge clk or negedge rst_n)
begin
    if (rst_n ==1'b0)
        begin
            rx_d0 <=0;
            rx_d1 <=0;
        
        end
    else 
    begin
        rx_d0 <= rx_pin;
        rx_d1 <= rx_d0; 
    end
end


always@(posedge clk or negedge rst_n)
begin
    if (rst_n == 1'b0)
        begin
            rx_state <= rx_idle;
            rx_data_valid <= 1'b0;
            
        end
    else 
        begin
            case(rx_state)
            rx_idle:
                begin
                    if(rx_negedge == 1'b1)
                        rx_state <= rx_start;
                    else
                        rx_state <= rx_idle;
                 end
            rx_start:
                begin
                    if(cycle_cnt == cycle -1)
                        begin
                            rx_state <= rx_rcv_byte;
                            cycle_cnt <= 16'd0;
                        end
                    else
                        begin
                            rx_state <= rx_start;
                            cycle_cnt <= cycle_cnt + 16'd1;
                        end
                end
            rx_rcv_byte:
                begin
                    if(cycle_cnt == cycle - 1)
                    //分成两种情况，达到8个bit/没到8个字节
                    begin
                        if(bit_cnt == 3'd7)
                            begin
                                rx_state <= rx_stop;
                                bit_cnt <= 3'd0;
                                cycle_cnt <= 16'd0;
                            end
                        else
                            begin
                                bit_cnt <= bit_cnt + 3'd1;
                                cycle_cnt <= 16'd0;
                            end
                        
                    end
                    else if (cycle_cnt == cycle/2 -1)
                        begin
                            rx_bits[bit_cnt] <= rx_pin;
                            cycle_cnt <= cycle_cnt + 16'd1;
                        end
                    else
                        cycle_cnt <= cycle_cnt + 16'd1;
                        
                end
            rx_stop:
                begin
                
                    if(cycle_cnt == cycle/2 -1)
                        begin
                            rx_state <= rx_data_state;      
                            rx_data <= rx_bits;//latch received data
                            cycle_cnt <= 16'd0;    
                            rx_data_valid <=1'b1;
                            
                        end
                    else
                        begin   
                            rx_state <= rx_stop;
                            rx_data_valid <=1'b0;
                            cycle_cnt <= cycle_cnt + 16'd1;
                        end
                end
            rx_data_state:
                begin                   
                    
                    if(rx_data_ready) // 低电平时候，就一直处在则个等待数据接收的状态
                        begin
                            rx_state <= rx_idle;
                            rx_data_valid <=1'b0;
                        end
                    else
                        begin                   
                            rx_data_valid <=1'b1;
                            rx_state <= rx_data_state;
                        end
                end
          default:
                rx_state <= rx_idle;
        endcase
    end
end

endmodule