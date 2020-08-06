module  simple_fsm
(
    input   wire    sys_clk     ,
    input   wire    sys_rst_n   ,
    input   wire    pi_money    ,

    output  reg     po_cola     
);

//编码方式：独热码
parameter   IDLE    =   3'b001;
parameter   ONE     =   3'b010;
parameter   TWO     =   3'b100;

/*
//编码方式：二进制
parameter   IDLE    =   2'b00;
parameter   ONE     =   2'b01;
parameter   TWO     =   2'b10;

//编码方式：格雷码
parameter   IDLE    =   2'b00;
parameter   ONE     =   2'b01;
parameter   TWO     =   2'b11;
*/

reg     [2:0]   state;

//三段式状态机
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        state <= IDLE;
    else    case(state)
        IDLE:   if(pi_money == 1'b1)
                    state <= ONE;
                else
                    state <= state;
        ONE:    if(pi_money == 1'b1)
                    state <= TWO;
                else
                    state <= state;
        TWO:    if(pi_money == 1'b1)
                    state <= IDLE;
                else
                    state <= state;
        default:state <= IDLE;
    endcase

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        po_cola <= 1'b0;
    else    if(state == TWO && pi_money == 1'b1)
        po_cola <= 1'b1;
    else 
        po_cola <= 1'b0;

endmodule
