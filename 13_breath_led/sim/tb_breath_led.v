`timescale 1ns/1ns

module  tb_breath_led();

reg     sys_clk     ;
reg     sys_rst_n   ;

wire    led_out;

initial
    begin
        sys_clk = 1'b1;
        sys_rst_n <= 1'b0;
        #20
        sys_rst_n <= 1'b1;
    end

always #10 sys_clk = ~sys_clk;

breath_led
#(
    .CNT_1US_MAX (6'd4),
    .CNT_1MS_MAX (10'd9),
    .CNT_1S_MAX  (10'd9)
)
breath_led_inst
(
    .sys_clk     (sys_clk),
    .sys_rst_n   (sys_rst_n),

    .led_out     (led_out)
);



endmodule
