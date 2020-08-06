module  divider_6
(
    input   wire        sys_clk     ,
    input   wire        sys_rst_n   ,
    
    //output  reg         clk_out     //因为使用always进行赋值，所以使用reg
    output  reg         clk_flag     //因为使用always进行赋值，所以使用reg
);

reg     [2:0]   cnt;    //因为使用always进行赋值，所以使用reg

/*分频法*/
/* //计数器变量赋值
always@(posedge sys_clk or negedge sys_rst_n)   //异步复位
    if(sys_rst_n == 1'b0)
        cnt <= 3'd0;
    else    if(cnt == 3'd2) //6分频
        cnt <= 3'd0;
    else
        cnt <= cnt + 3'd1;

//输出信号赋值
always@(posedge sys_clk or negedge sys_rst_n)   //异步复位
    if(sys_rst_n == 1'b0)
        clk_out <= 1'b0;
    else    if(cnt == 2'd2) //6分频
        clk_out <= ~clk_out;
    else
        clk_out <= clk_out; */

/*降频法*/
//计数器变量赋值
always@(posedge sys_clk or negedge sys_rst_n)   //异步复位
    if(sys_rst_n == 1'b0)
        cnt <= 3'd0;
    else    if(cnt == 3'd5) //6分频
        cnt <= 3'd0;
    else
        cnt <= cnt + 3'd1;

//输出信号赋值
always@(posedge sys_clk or negedge sys_rst_n)   //异步复位
    if(sys_rst_n == 1'b0)
        clk_flag <= 1'b0;
    else    if(cnt == 3'd4) //6分频
        clk_flag <= 1'b1;
    else
        clk_flag <= 1'b0;

endmodule
