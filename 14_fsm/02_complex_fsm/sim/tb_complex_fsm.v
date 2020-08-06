//~ `New testbench
`timescale  1ns / 1ps     

module tb_complex_fsm;     

// complex_fsm Inputs
reg   sys_clk       ;
reg   sys_rst_n     ;
reg   pi_money_half ;
reg   pi_money_one  ;

// complex_fsm Outputs
wire  po_cola   ;
wire  po_money  ;

reg   random_data;

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
        random_data <= 1'b0;
    else
        random_data <= {$random} % 2;

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        pi_money_half <= 1'b0;
    else
        pi_money_half <= random_data;

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        pi_money_one <= 1'b0;
    else
        pi_money_one <= ~random_data;
        
wire    [1:0]   pi_money = complex_fsm_inst.pi_money;
wire    [4:0]   state = complex_fsm_inst.state;

initial
    begin
        $timeformat(-9, 0, "ns", 6);
        $monitor("@time %t:pi_money_half=%b,pi_money_one=%b,pi_money=%b,state=%b,po_cola=%b,po_money=%b",$time, pi_money_half, pi_money_one, pi_money, state, po_cola, po_money);
    end

complex_fsm  complex_fsm_inst
(
    .sys_clk        ( sys_clk         ),
    .sys_rst_n      ( sys_rst_n       ),
    .pi_money_half  ( pi_money_half   ),
    .pi_money_one   ( pi_money_one    ),
    
    .po_cola        ( po_cola         ),
    .po_money       ( po_money        )
);

endmodule