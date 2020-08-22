`timescale 1ns/1ns

module  tb_rom_ctrl();

//input
reg            sys_clk      ;
reg            sys_rst_n    ;
reg            key1         ;
reg            key2         ;

//output
wire    [7:0]   addr        ;

initial
    begin
        sys_clk = 1'b1;
        sys_rst_n <= 1'b0;
        key1 <= 1'b0;
        key2 <= 1'b0;
        #30
        sys_rst_n <= 1'b1;
        #700_000
//key1
        key1 <= 1'b1;
        #20
        key1 <= 1'b0;
        #20_000
        key1 <= 1'b1;
        #20
        key1 <= 1'b0;
        #600_000
//key2
        key2 <= 1'b1;
        #20
        key2 <= 1'b0;
        #20_000
        key2 <= 1'b1;
        #20
        key2 <= 1'b0;
        #600_000
//
        key1 <= 1'b1;
        #20
        key1 <= 1'b0;
        #20_000
        key2 <= 1'b1;
        #20
        key2 <= 1'b0;
        #20_000
        key2 <= 1'b1;
        #20
        key2 <= 1'b0;
    end

always #10 sys_clk = ~sys_clk;

rom_ctrl
#(
    .CNT_MAX     (24'd99)
)rom_ctrl_inst
(
    .sys_clk     (sys_clk  ),
    .sys_rst_n   (sys_rst_n),
    .key1        (key1     ),
    .key2        (key2     ),

    .addr        (addr     )
);

endmodule
