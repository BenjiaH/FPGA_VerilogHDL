`timescale 1ns/1ns

module  tb_hdmi_colorbar();

//input
reg     sys_clk     ;
reg     sys_rst_n   ;

//output
wire    ddc_scl     ;
wire    ddc_sda     ;
wire    hdmi_r_p    ;
wire    hdmi_r_n    ;
wire    hdmi_g_p    ;
wire    hdmi_g_n    ;
wire    hdmi_b_p    ;
wire    hdmi_b_n    ;
wire    hdmi_clk_p  ;
wire    hdmi_clk_n  ;

initial
    begin
        sys_clk = 1'b1;
        sys_rst_n <= 1'b0;
        #30
        sys_rst_n <= 1'b1;
    end

always #10 sys_clk = ~sys_clk;

hdmi_colorbar   hdmi_colorbar_inst
(
    .sys_clk    (sys_clk    ),
    .sys_rst_n  (sys_rst_n  ),

    .ddc_scl    (ddc_scl    ),
    .ddc_sda    (ddc_sda    ),
    .hdmi_r_p   (hdmi_r_p   ),
    .hdmi_r_n   (hdmi_r_n   ),
    .hdmi_g_p   (hdmi_g_p   ),
    .hdmi_g_n   (hdmi_g_n   ),
    .hdmi_b_p   (hdmi_b_p   ),
    .hdmi_b_n   (hdmi_b_n   ),
    .hdmi_clk_p (hdmi_clk_p ),
    .hdmi_clk_n (hdmi_clk_n )
);

endmodule
