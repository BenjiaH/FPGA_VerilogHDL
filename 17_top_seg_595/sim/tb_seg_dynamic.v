`timescale 1ns/1ns

module  tb_seg_dynamic();

//input
reg             sys_clk     ;
reg             sys_rst_n   ;
reg     [19:0]  data        ;
reg     [5:0]   point       ;
reg             sign        ;
reg             seg_en      ;

//output
wire    [5:0]   sel         ;     
wire    [7:0]   seg         ;

initial
    begin
        sys_clk = 1'b1;
        sys_rst_n <= 1'b0;
        data <= 20'd0;
        point <= 6'b0;
        sign <= 1'b0;
        seg_en <= 1'b0;
        #30
        sys_rst_n <= 1'b1;
        data <= 20'd9876;
        point <= 6'b000_010;
        sign <= 1'b1;
        seg_en <= 1'b1; 
    end

always #10 sys_clk = ~sys_clk;

defparam    seg_dynamic_inst.CNT_MAX = 20'd5;

seg_dynamic seg_dynamic_inst
(
    .sys_clk     (sys_clk  ),
    .sys_rst_n   (sys_rst_n),
    .data        (data     ),
    .point       (point    ),
    .sign        (sign     ),
    .seg_en      (seg_en   ),

    .sel         (sel      ),
    .seg         (seg      )
);

endmodule
