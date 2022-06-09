module  hdmi_ctrl
(
    input   wire            sys_clk     ,
    input   wire            sys_clk_5x  ,
    input   wire            sys_rst_n   ,
    input   wire            hsync       ,
    input   wire            vsync       ,
    input   wire            rgb_valid   ,
    input   wire    [7:0]   rgb_r       ,
    input   wire    [7:0]   rgb_g       ,
    input   wire    [7:0]   rgb_b       ,

    output  wire            hdmi_r_p    ,
    output  wire            hdmi_r_n    ,
    output  wire            hdmi_g_p    ,
    output  wire            hdmi_g_n    ,
    output  wire            hdmi_b_p    ,
    output  wire            hdmi_b_n    ,
    output  wire            hdmi_clk_p  ,
    output  wire            hdmi_clk_n
);

wire [9:0] red          ;
wire [9:0] red_xilinx   ;
wire [9:0] green        ;
wire [9:0] blue         ;

encode  encode_inst_r
(
    .sys_clk    (sys_clk    ),
    .sys_rst_n  (sys_rst_n  ),
    .c0         (hsync      ),//h sync
    .c1         (vsync      ),//v sync
    .de         (rgb_valid  ),
    .data_in    (rgb_r      ),

    .data_out   (red        )
);

encode_xilinx   encode_xilinx_inst_r
(
    .clkin  (sys_clk    ),    // pixel clock input
    .rstin  (~sys_rst_n ),    // async. reset input (active high)
    .din    (rgb_r      ),    // data inputs: expect registered
    .c0     (hsync      ),    // c0 input
    .c1     (vsync      ),    // c1 input
    .de     (rgb_valid  ),    // de input
    .dout   (red_xilinx )     // data outputs
);

encode  encode_inst_g
(
    .sys_clk    (sys_clk    ),
    .sys_rst_n  (sys_rst_n  ),
    .c0         (hsync      ),//h sync
    .c1         (vsync      ),//v sync
    .de         (rgb_valid  ),
    .data_in    (rgb_g      ),

    .data_out   (green      )
);

encode  encode_inst_b
(
    .sys_clk    (sys_clk    ),
    .sys_rst_n  (sys_rst_n  ),
    .c0         (hsync      ),//h sync
    .c1         (vsync      ),//v sync
    .de         (rgb_valid  ),
    .data_in    (rgb_b      ),

    .data_out   (blue       )
);

par_to_ser  par_to_ser_inst_r
(
    .clk_5x     (sys_clk_5x ),
    .data_in    (red        ),

    .ser_p      (hdmi_r_p   ),
    .ser_n      (hdmi_r_n   )
);

par_to_ser  par_to_ser_inst_g
(
    .clk_5x     (sys_clk_5x ),
    .data_in    (green      ),

    .ser_p      (hdmi_g_p   ),
    .ser_n      (hdmi_g_n   )
);

par_to_ser  par_to_ser_inst_b
(
    .clk_5x     (sys_clk_5x ),
    .data_in    (blue       ),

    .ser_p      (hdmi_b_p   ),
    .ser_n      (hdmi_b_n   )
);

par_to_ser  par_to_ser_inst_clk
(
    .clk_5x     (sys_clk_5x         ),
    .data_in    (10'b11111_00000    ),

    .ser_p      (hdmi_clk_p         ),
    .ser_n      (hdmi_clk_n         )
);



endmodule
