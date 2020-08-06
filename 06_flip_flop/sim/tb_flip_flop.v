`timescale  1ns/1ns

module  tb_flip_flop();

reg sys_clk     ;
reg sys_rst_n   ;
reg key_in      ;

wire    led_out;

initial
    begin
        sys_clk = 1'b1;
        sys_rst_n <= 1'b0;
        key_in <= 1'b0;
        #20
        sys_rst_n <= 1'b1;  //先拉低再拉高
        #210
        sys_rst_n <= 1'b0;
        #40
        sys_rst_n <= 1'b1;
    end

always  #10 sys_clk = ~sys_clk; //50Hz
always  #20 key_in <= {$random} % 2;    //20ns不会产生毛刺

initial
    begin
        $timeformat(-9, 0, "ns", 6);
        $monitor("@ time %t:key_in=%b,led_out=%b", $time, key_in, led_out);
    end

flip_flop   flip_flop
(
    .sys_clk     (sys_clk),   //50Mhz
    .sys_rst_n   (sys_rst_n),
    .key_in      (key_in),

    .led_out     (led_out)
);

endmodule
