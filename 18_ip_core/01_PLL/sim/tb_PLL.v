`timescale 1ns/1ns

module  tb_PLL();

//input
reg     sys_clk ;

//output
wire    clk_mul_2   ;
wire    clk_div_2   ;
wire    clk_pha_90  ;
wire    clk_duc_20  ;
wire    locked      ;

initial sys_clk = 1'b1;

always  #10 sys_clk = ~sys_clk;

PLL PLL_inst
(
    .sys_clk     (sys_clk   ),

    .clk_mul_2   (clk_mul_2 ),
    .clk_div_2   (clk_div_2 ),
    .clk_pha_90  (clk_pha_90),
    .clk_duc_20  (clk_duc_20),
    .locked      (locked    )
);

endmodule
