//~ `New testbench
`timescale  1ns / 1ps     

module tb_simple_fsm;     



// simple_fsm Inputs
reg   sys_clk   ;
reg   sys_rst_n ;
reg   pi_money  ;

// simple_fsm Outputs
wire  po_cola   ;

initial
    begin
        sys_clk = 1'b1;
        sys_rst_n <= 1'b0;
        #20
        sys_rst_n <= 1'b1;
    end

always #10 sys_clk = ~sys_clk;

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        pi_money <= 1'b0;
    else
        pi_money <= {$random} % 2;

wire    [2:0]   state = simple_fsm_inst.state;

initial
    begin
        $timeformat(-9, 0, "ns", 6);
        $monitor("@time %t:pi_money=%b,state=%b,po_cola=%b",$time, pi_money, state, po_cola);
    end

simple_fsm  simple_fsm_inst
(
    .sys_clk    (sys_clk  ),
    .sys_rst_n  (sys_rst_n),
    .pi_money   (pi_money ),
    
    .po_cola    (po_cola  )
);


endmodule