`timescale 1ns/1ns

module  tb_key_fliter();

reg             sys_clk     ;
reg             sys_rst_n   ;
reg             key_in      ;
reg     [7:0]   tb_cnt      ;

wire    key_flag    ;

initial
    begin
        sys_clk = 1'b1;
        sys_rst_n <= 1'b0;
        #20
        sys_rst_n <= 1'b1;
    end
    
always #10 sys_clk = ~sys_clk;
    
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        tb_cnt <= 8'd0;
    else    if(tb_cnt == 8'd249)
        tb_cnt <= 8'd0;
    else
        tb_cnt <= tb_cnt + 8'd1;

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        key_in <= 1'b1;
    else    if((tb_cnt >= 8'd19 && tb_cnt <= 8'd49) 
            || (tb_cnt >= 8'd149 && tb_cnt <= 8'd199))
        key_in <= {$random} % 2;
    else    if(tb_cnt <= 8'd19 && tb_cnt >= 8'd199) 
        key_in <= 1'b1;
    else
        key_in <= 1'b0;

key_fliter
#(
    .CNT_MAX(20'd24)
)key_fliter_inst
(
    .sys_clk     (sys_clk),
    .sys_rst_n   (sys_rst_n),
    .key_in      (key_in),

    .key_flag    (key_flag)
);

endmodule
