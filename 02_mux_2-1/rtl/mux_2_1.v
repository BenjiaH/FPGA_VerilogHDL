module  mux_2_1
(
    input   wire        [0:0]   in_1,
    input   wire                in_2,
    input   wire                sel ,    //选通信号
    output  reg                 out     //always必须是reg型
);

//always@(in_1, in_2, sel)
always@(*)
    if(sel == 1'b1)
        begin//如果执行的语句只有一条bengin end可以省略，类似于{}
        out = in_1;
        end
    else
        begin
        out = in_2;
        end

/*
//out:组合逻辑输出选择结果
always@(*)
    case(sel)
        1'b1    : out = in1;

        1'b0    : out = in2;

        default : out = in1;    //如果sel不能列举出所有的情况一定要加default。此处sel只有两种情况,并且完全列举了,所以default可以省略
    endcase
*/

/*
out:组合逻辑输出选择结果
assign out = (sel == 1'b1) ? in1 : in2; //此处使用的是条件运算符（三元运算符）,当括号里面的条件成立时,执行"?”后面的结果；如果括号里面的条件不成立时,执行“:”后面的结果
*/


endmodule
