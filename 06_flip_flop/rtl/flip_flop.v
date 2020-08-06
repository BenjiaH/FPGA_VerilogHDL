module  flip_flop
(
    input   wire        sys_clk     ,   //50Mhz
    input   wire        sys_rst_n   ,
    input   wire        key_in      ,
    
    output  reg         led_out
);

//always@(posedge sys_clk or negedge sys_rst_n) //异步复位
always@(posedge sys_clk)   //同步复位
    if(sys_rst_n == 1'b0)
        //时序逻辑中赋值必须用非阻塞赋值
        led_out <= 1'b0;    //一般初值都为0
    else
        led_out <= key_in;
    

endmodule
