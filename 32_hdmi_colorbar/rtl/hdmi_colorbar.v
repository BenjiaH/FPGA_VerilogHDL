module  hdmi_colorbar
(
    input   wire            sys_clk     ,
    input   wire            sys_rst_n   ,

    output  wire            ddc_scl     ,
    output  wire            ddc_sda     ,
    output  wire            hdmi_r_p    ,
    output  wire            hdmi_r_n    ,
    output  wire            hdmi_g_p    ,
    output  wire            hdmi_g_n    ,
    output  wire            hdmi_b_p    ,
    output  wire            hdmi_b_n    ,
    output  wire            hdmi_clk_p  ,
    output  wire            hdmi_clk_n
);

wire            clk         ;
wire            clk_5x      ;
wire            locked      ;
wire            rst_n       ;
wire    [9:0]   pix_x       ;
wire    [9:0]   pix_y       ;
wire            rgb_valid   ;
wire            hsync       ;
wire            vsync       ;
wire    [15:0]  rgb         ;
wire    [15:0]  pix_data    ;

assign  rst_n = (sys_rst_n & locked);
assign  ddc_scl = 1'b1;
assign  ddc_sda = 1'b1;

clk_gen clk_gen_inst
(
    .areset (~sys_rst_n ),
    .inclk0 (sys_clk    ),
    .c0     (clk        ),
    .c1     (clk_5x     ),
    .locked (locked     )
);

vga_ctrl    vga_ctrl_inst
(
    .vga_clk    (clk        ),   //输入工作时钟,频率25MHz
    .sys_rst_n  (rst_n      ),   //输入复位信号,低电平有效
    .pix_data   (pix_data   ),   //输入像素点色彩信息

    .pix_x      (pix_x      ),   //输出VGA有效显示区域像素点X轴坐标
    .pix_y      (pix_y      ),   //输出VGA有效显示区域像素点Y轴坐标
    .rgb_valid  (rgb_valid  ),
    .hsync      (hsync      ),   //输出行同步信号
    .vsync      (vsync      ),   //输出场同步信号
    .rgb        (rgb        )    //输出像素点色彩信息
);

vga_pic vga_pic_inst
(
    .vga_clk    (clk        ),   //输入工作时钟,频率25MHz
    .sys_rst_n  (rst_n      ),   //输入复位信号,低电平有效
    .pix_x      (pix_x      ),   //输入VGA有效显示区域像素点X轴坐标
    .pix_y      (pix_y      ),   //输入VGA有效显示区域像素点Y轴坐标

    .pix_data   (pix_data   )    //输出像素点色彩信息
);

hdmi_ctrl   hdmi_ctrl_inst
(
    .sys_clk    (clk                ),
    .sys_clk_5x (clk_5x             ),
    .sys_rst_n  (rst_n              ),
    .hsync      (hsync              ),
    .vsync      (vsync              ),
    .rgb_valid  (rgb_valid          ),
    .rgb_r      ({rgb[4:0], 3'b0}   ),
    .rgb_g      ({rgb[10:5], 2'b0}  ),
    .rgb_b      ({rgb[15:11], 3'b0} ),

    .hdmi_r_p   (hdmi_r_p           ),
    .hdmi_r_n   (hdmi_r_n           ),
    .hdmi_g_p   (hdmi_g_p           ),
    .hdmi_g_n   (hdmi_g_n           ),
    .hdmi_b_p   (hdmi_b_p           ),
    .hdmi_b_n   (hdmi_b_n           ),
    .hdmi_clk_p (hdmi_clk_p         ),
    .hdmi_clk_n (hdmi_clk_n         )
);

endmodule
