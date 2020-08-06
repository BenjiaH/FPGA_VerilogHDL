module  key_fliter
#(
    parameter   CNT_MAX = 20'd999_999
)
(
    input   wire        sys_clk     ,
    input   wire        sys_rst_n   ,
    input   wire        key_in      ,
    
    output  reg         key_flag
);

reg     [19:0]  cnt_20ms;

//cnt_20ms赋值
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        cnt_20ms <= 20'd0;
    else    if(key_in == 1'b1)
        cnt_20ms <= 20'd0;
    else    if(cnt_20ms == CNT_MAX)
        cnt_20ms <= cnt_20ms;
    else
        cnt_20ms <= cnt_20ms + 20'd1;

//key_flag赋值
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        key_flag <= 1'b0;
    else    if(cnt_20ms == CNT_MAX - 20'd1)
        key_flag <= 1'b1;
    else
        key_flag <= 1'b0;
        
endmodule
