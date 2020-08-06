module  divider_5
(
    input   wire        sys_clk     ,
    input   wire        sys_rst_n   ,
    
    // output  wire         clk_out     //因为使用assign进行赋值，所以使用wire
    output  reg         clk_flag     //因为使用always进行赋值，所以使用reg
);

reg     [2:0]   cnt     ;    //因为使用always进行赋值，所以使用reg
reg             clk_1   ;    //因为使用always进行赋值，所以使用reg
reg             clk_2   ;    //因为使用always进行赋值，所以使用reg

/*分频法*/
/* //计数器变量赋值
always@(posedge sys_clk or negedge sys_rst_n)   //异步复位
    if(sys_rst_n == 1'b0)
        cnt <= 3'd0;    //赋初值
    else    if(cnt == 3'd4)
        cnt <= 3'd0;
    else
        cnt <= cnt + 3'd1;

//clk_1赋值
always@(posedge sys_clk or negedge sys_rst_n)   //异步复位
    if(sys_rst_n == 1'b0)
        clk_1 <= 1'b0;
    else    if(cnt == 3'd2)
        clk_1 <= 1'b1;
    else    if(cnt == 3'd4)
        clk_1 <= 1'b0;
    else
        clk_1 <= clk_1;

//clk_2赋值
always@(negedge sys_clk or negedge sys_rst_n)   //异步复位[时钟下降沿采样]
    if(sys_rst_n == 1'b0)
        clk_2 <= 1'b0;
    else    if(cnt == 3'd2)
        clk_2 <= 1'b1;
    else    if(cnt == 3'd4)
        clk_2 <= 1'b0;
    else
        clk_2 <= clk_2;

//输出信号赋值
assign  clk_out = clk_1 | clk_2; */

/*降频法*/
//计数器变量赋值
always@(posedge sys_clk or negedge sys_rst_n)   //异步复位
    if(sys_rst_n == 1'b0)
        cnt <= 3'd0;
    else    if(cnt == 3'd4) //5分频
        cnt <= 3'd0;
    else
        cnt <= cnt + 3'd1;

//输出信号赋值
always@(posedge sys_clk or negedge sys_rst_n)   //异步复位
    if(sys_rst_n == 1'b0)
        clk_flag <= 1'b0;
    else    if(cnt == 3'd3) //5分频
        clk_flag <= 1'b1;
    else
        clk_flag <= 1'b0;

endmodule
