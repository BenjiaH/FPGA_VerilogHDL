module  top_seg_595
(
    input   wire            sys_clk     ,
    input   wire            sys_rst_n   ,
    
    output  wire            ds          ,
    output  wire            oe          ,
    output  wire            shcp        ,
    output  wire            stcp
);

wire    [19:0]  data    ;
wire    [5:0]   point   ;
wire            sign    ;
wire            seg_en  ;

data_gen
#(
    .CNT_MAX    (23'd4999_999)  ,
    .DATA_MAX   (20'd999_999)
)
data_gen_inst
(
    .sys_clk     (sys_clk),
    .sys_rst_n   (sys_rst_n),

    .data        (data  ),
    .point       (point ),
    .sign        (sign  ),
    .seg_en      (seg_en)
);

seg_595_dynamic seg_595_dynamic_inst
(
    .sys_clk     (sys_clk  ),
    .sys_rst_n   (sys_rst_n),
    .data        (data     ),
    .point       (point    ),
    .sign        (sign     ),
    .seg_en      (seg_en   ),

    .ds          (ds  ),
    .oe          (oe  ),
    .shcp        (shcp),
    .stcp        (stcp)
);

endmodule
