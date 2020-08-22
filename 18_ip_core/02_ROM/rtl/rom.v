module  rom
(
    input   wire    sys_clk     ,
    input   wire    sys_rst_n   ,
    input   wire    key1        ,
    input   wire    key2        ,

    output  wire    ds          ,
    output  wire    oe          ,
    output  wire    shcp        ,
    output  wire    stcp
);

wire            key1_flag   ;
wire            key2_flag   ;
wire    [7:0]   addr        ;
wire    [7:0]   data        ;

key_fliter
#(
    .CNT_MAX (20'd999_999)
)
//通过例化名区分
key_fliter_inst1
(
    .sys_clk     (sys_clk  ),
    .sys_rst_n   (sys_rst_n),
    .key_in      (key1   ),
            
    .key_flag    (key1_flag )
);

key_fliter
#(
    .CNT_MAX (20'd999_999)
)
key_fliter_inst2
(
    .sys_clk     (sys_clk  ),
    .sys_rst_n   (sys_rst_n),
    .key_in      (key2   ),
            
    .key_flag    (key2_flag )
);

rom_ctrl
#(
    .CNT_MAX (24'd9_999_999)
)
rom_ctrl_inst
(
    .sys_clk     (sys_clk  ),
    .sys_rst_n   (sys_rst_n),
    .key1        (key1_flag   ),
    .key2        (key2_flag   ),

    .addr        (addr     )
);

rom_8x256   rom_8x256_inst
(
    .address    (addr),
    .clock      (sys_clk),
    .q          (data)
);

seg_595_dynamic seg_595_dynamic_inst
(
    .sys_clk     (sys_clk  ),
    .sys_rst_n   (sys_rst_n),
    .data        ({12'b0, data}),
    .point       (6'b000_000),
    .sign        (1'b0),
    .seg_en      (1'b1),

    .ds          (ds       ),
    .oe          (oe       ),
    .shcp        (shcp     ),
    .stcp        (stcp     )
);

endmodule
