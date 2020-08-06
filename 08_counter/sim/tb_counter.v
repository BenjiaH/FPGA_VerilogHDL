`timescale 1ns/1ns

module tb_counter();

reg     sys_clk     ;
reg     sys_rst_n   ;

wire    led_out     ;

initial
    begin
        sys_clk = 1'b1;
        sys_rst_n <= 1'b0;
        #20
        sys_rst_n <= 1'b1;
    end
    
always #10 sys_clk = ~sys_clk;  //50Mhz

initial
    begin
        $timeformat(-9, 0, "ns", 6);
        $monitor("@ time %t:led_out=%b", $time, led_out);
    end

counter
#(
    .CNT_MAX(25'd24)
)
counter_inst    //注意位置
(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n),

    .led_out    (led_out)
);

endmodule
