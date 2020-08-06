`timescale 1ns/1ns

module  tb_top_seg_595();

//input
reg             sys_clk     ;
reg             sys_rst_n   ;

//output
wire            ds          ;
wire            oe          ;
wire            shcp        ;
wire            stcp        ;

initial
    begin
        sys_clk = 1'b1;
        sys_rst_n <= 1'b0;
        #30
        sys_rst_n <= 1'b1;
    end

always #10 sys_clk = ~sys_clk;

defparam    top_seg_595_inst.data_gen_inst.CNT_MAX = 23'd49;
defparam    top_seg_595_inst.seg_595_dynamic_inst.seg_dynamic_inst.CNT_MAX = 16'd19;

top_seg_595 top_seg_595_inst
(
    .sys_clk     (sys_clk),
    .sys_rst_n   (sys_rst_n),

    .ds          (ds  ),
    .oe          (oe  ),
    .shcp        (shcp),
    .stcp        (stcp)
);


endmodule
