module  touch_ctrl_led
(
    input   wire    sys_clk     ,
    input   wire    sys_rst_n   ,
    input   wire    touch_key   ,
    
    output  reg     led_out
);

reg     touch_key_1 ;
reg     touch_key_2 ;
wire    touch_flag  ;

//边沿检测

//touch_key_1、touch_key_2赋值
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        begin
            touch_key_1 <= 1'b1;
            touch_key_2 <= 1'b1;
        end
    else
        begin
            touch_key_1 <= touch_key;
            touch_key_2 <= touch_key_1;
        end

//touch脉冲赋值
/*使用组合逻辑，无延迟*/
assign  touch_flag = (touch_key_1 == 1'b0) && (touch_key_2 == 1'b1);    //采集下降沿
// assign  touch_flag = (touch_key_1 == 1'b1) && (touch_key_2 == 1'b0); //采集上升沿
/******************************************************************************************/
/******************************************************************************************/
/* //使用时序逻辑、采集下降沿、逻辑与运算
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        touch_flag <= 1'b0;
    else    if((touch_key_1 == 1'b0) && (touch_key_2 == 1'b1))  //逻辑与运算
        touch_flag <= 1'b1;
    else
        touch_flag <= 1'b0;
//使用时序逻辑、采集下降沿、逻辑或运算
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        touch_flag <= 1'b0;
    else    if((touch_key_1 == 1'b1) || (touch_key_2 == 1'b0))  //逻辑或运算
        touch_flag <= 1'b0;
    else
        touch_flag <= 1'b1; */

//输出信号赋值
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        led_out <= 1'b1;
    else    if(touch_flag == 1'b1)
        led_out <= ~led_out;
    else
        led_out <= led_out;

endmodule
