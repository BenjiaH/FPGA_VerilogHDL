//~ `New testbench
`timescale 1ns/1ns

module tb_seg_static();

// seg_static Inputs
reg   sys_clk   ;
reg   sys_rst_n ;

// seg_static Outputs
wire  [5:0]  sel;
wire  [7:0]  seg;


initial
    begin
        sys_clk = 1'b1;
        sys_rst_n <= 1'b0;
        #20
        sys_rst_n <= 1'b1;
    end

always #10 sys_clk = ~sys_clk;

seg_static 
#(
    .CNT_MAX (25'd24)
)
seg_static_inst
(
    .sys_clk                 (sys_clk          ),
    .sys_rst_n               (sys_rst_n        ),

    .sel                     (sel              ),
    .seg                     (seg              )
);

endmodule
