`timescale 1ns/1ns

module  tb_touch_ctrl_led();

reg     sys_clk     ;
reg     sys_rst_n   ;
reg     touch_key   ;

wire    led_out     ;

initial
    begin
        sys_clk = 1'b1;
        sys_rst_n <= 1'b0;
        touch_key <= 1'b1;
        #20
        sys_rst_n <= 1'b1;
        #200
        touch_key <= 1'b0;
        #2000
        touch_key <= 1'b1;
        #1000
        touch_key <= 1'b0;
        #3000
        touch_key <= 1'b1;
    end

always  #10 sys_clk = ~sys_clk;

touch_ctrl_led  touch_ctrl_led_inst
(
    .sys_clk     (sys_clk),
    .sys_rst_n   (sys_rst_n),
    .touch_key   (touch_key),

    .led_out     (led_out)
);
  
endmodule
