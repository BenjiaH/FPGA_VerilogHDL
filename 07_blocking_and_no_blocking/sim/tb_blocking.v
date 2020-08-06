`timescale 1ns/1ns

module tb_blocking();

reg             sys_clk     ;
reg             sys_rst_n   ;
reg     [1:0]   in          ;

wire    [1:0]   out         ;

initial
    begin
        sys_clk = 1'b1;
        sys_rst_n <= 1'b0;
        in <= 2'b0;
        #20
        sys_rst_n <= 1'b1;
    end
    
always #10 sys_clk = ~sys_clk;
always #20 in <= {$random} % 4;  //0 1 2 3

blocking    blocking_inst
(
    .sys_clk     (sys_clk),
    .sys_rst_n   (sys_rst_n),
    .in          (in),

    .out         (out)
);

endmodule
