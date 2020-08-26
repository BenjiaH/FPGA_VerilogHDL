`timescale 1ns/1ns

module  tb_ram();

//inpout 
reg     sys_clk     ;
reg     sys_rst_n   ;
reg     wr_key      ;
reg     rd_key      ;

//output
wire    ds          ;
wire    oe          ;
wire    shcp        ;
wire    stcp        ;

initial
    begin
        sys_clk = 1'b1;
        sys_rst_n <= 1'b0;
        wr_key = 1'b1;
        rd_key = 1'b1;
        #20
        sys_rst_n <= 1'b1;
        #10000
//rd_key
        rd_key = 1'b0;
        #20
        rd_key = 1'b1;
        #20
        rd_key = 1'b0;
        #20
        rd_key = 1'b1;
        #20
        rd_key = 1'b0;
        #200
        rd_key = 1'b1;
        #20
        rd_key = 1'b0;
        #20
        rd_key = 1'b1;
        #20
        rd_key = 1'b0;
        #20
        rd_key = 1'b1;
        #200_000
//wr_key
        wr_key = 1'b0;
        #20
        wr_key = 1'b1;
        #20
        wr_key = 1'b0;
        #20
        wr_key = 1'b1;
        #20
        wr_key = 1'b0;
        #200
        wr_key = 1'b1;
        #20
        wr_key = 1'b0;
        #20
        wr_key = 1'b1;
        #20
        wr_key = 1'b0;
        #20
        wr_key = 1'b1;
        #10000
//rd_key
        rd_key = 1'b0;
        #20
        rd_key = 1'b1;
        #20
        rd_key = 1'b0;
        #20
        rd_key = 1'b1;
        #20
        rd_key = 1'b0;
        #200
        rd_key = 1'b1;
        #20
        rd_key = 1'b0;
        #20
        rd_key = 1'b1;
        #20
        rd_key = 1'b0;
        #20
        rd_key = 1'b1;
        #200_000
//rd_key
        rd_key = 1'b0;
        #20
        rd_key = 1'b1;
        #20
        rd_key = 1'b0;
        #20
        rd_key = 1'b1;
        #20
        rd_key = 1'b0;
        #200
        rd_key = 1'b1;
        #20
        rd_key = 1'b0;
        #20
        rd_key = 1'b1;
        #20
        rd_key = 1'b0;
        #20
        rd_key = 1'b1;       
    end

always #10 sys_clk = ~sys_clk;

defparam    ram_inst.key_fliter_wr_inst.CNT_MAX = 9;
defparam    ram_inst.key_fliter_rd_inst.CNT_MAX = 9;
defparam    ram_inst.ram_ctrl_inst.CNT_MAX = 99;

ram ram_inst
(
    .sys_clk    (sys_clk  ),
    .sys_rst_n  (sys_rst_n),
    .wr_key     (wr_key   ),
    .rd_key     (rd_key   ),

    .ds         (ds       ),
    .oe         (oe       ),
    .shcp       (shcp     ), 
    .stcp       (stcp     )
);

endmodule
