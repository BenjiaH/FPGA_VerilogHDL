`timescale 1ns/1ns

module  tb_bcd_8421();

//input
reg             sys_clk     ;
reg             sys_rst_n   ;
reg     [19:0]  data        ;

//output
wire    [3:0]   unit        ;
wire    [3:0]   ten         ;
wire    [3:0]   hun         ;
wire    [3:0]   tho         ;
wire    [3:0]   t_tho       ;
wire    [3:0]   h_hun       ;
    
initial
    begin
        sys_clk = 1'b1;
        sys_rst_n <= 1'b0;
        data <= 20'd0;
        #30
        sys_rst_n <= 1'b1;
        data <= 20'd123_456;
        #3000
        data <= 20'd654_321;
        #3000
        data <= 20'd987_654;
        #3000
        data <= 20'd999_999;
    end

always #10 sys_clk = ~sys_clk;

bcd_8421    bcd_8421_inst
(
    .sys_clk     (sys_clk),
    .sys_rst_n   (sys_rst_n),
    .data        (data),

    .unit        (unit),    //个位
    .ten         (ten),     //十位
    .hun         (hun),     //百位
    .tho         (tho),     //千位
    .t_tho       (t_tho),   //万位
    .h_hun       (h_hun)    //十万位
);

endmodule
