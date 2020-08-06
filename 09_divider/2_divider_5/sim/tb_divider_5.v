`timescale 1ns/1ns

module  tb_divider_5();

reg     sys_clk     ;
reg     sys_rst_n   ;

wire    clk_flag     ;

//初始化时钟 复位
initial
    begin
        sys_clk = 1'b1;
        sys_rst_n <= 1'b0;
        #20
        sys_rst_n <= 1'b1;
    end

always #10 sys_clk <= ~sys_clk;

divider_5   divider_5_inst
(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n),

    .clk_flag    (clk_flag)//因为使用always进行赋值，所以使用reg
);

endmodule