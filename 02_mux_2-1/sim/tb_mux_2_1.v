`timescale  1ns/1ns

module  tb_mux_2_1();

reg     in_1;
reg     in_2;
reg     sel ;

wire    out ;

initial
//begin end之间顺序执行，速度极快
    begin
        in_1    <= 1'b0;
        in_2    <= 1'b0;
        sel  <= 1'b0;
    end

//每隔10ns对in_1赋值
always  #10 in_1    <= {$random} % 2;//结果只能为1 0
always  #10 in_2    <= {$random} % 2;//结果只能为1 0
always  #10 sel     <= {$random} % 2;//结果只能为1 0

initial
    begin
        /*
        显示时间格式为10^-9 即纳秒
        0表示小数点后位数
        "ns"与-9对于
        6表示打印的最小数字字符
        */
        $timeformat(-9, 0, "ns", 6);
        $monitor("@time %t:in_1=%b in_2=%b sel=%b out=%b", $time, in_1, in_2, sel, out);
    end


/********实例化********/
//模块名 实例化名称
mux_2_1 mux_2_1_inst
(
    .in_1   (in_1), //将仿真模块in_1与被仿真模块in_1相连接
    .in_2   (in_2),
    .sel    (sel),  
    .out    (out)   
);

endmodule

