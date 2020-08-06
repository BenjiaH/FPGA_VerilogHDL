module  complex_fsm
(
    input   wire    sys_clk         ,
    input   wire    sys_rst_n       ,
    input   wire    pi_money_half   ,
    input   wire    pi_money_one    ,

    output  reg     po_cola         ,
    output  reg     po_money     
);

//编码方式：独热码
/*//方式1
parameter   IDLE    =   5'b00001;
parameter   HALF    =   5'b00010;
parameter   ONE     =   5'b00100;
parameter   ONE_HALF=   5'b01000;
parameter   TWO     =   5'b10000;
*/
//方式2[简介]
parameter   IDLE    =   5'b00001,
            HALF    =   5'b00010,
            ONE     =   5'b00100,
            ONE_HALF=   5'b01000,
            TWO     =   5'b10000;

wire    [1:0]   pi_money;
reg     [4:0]   state   ;

assign  pi_money = {pi_money_one, pi_money_half};

//三段式状态机
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        state <= IDLE;
    else    case(state)
        IDLE    :   if(pi_money == 2'b01)
                        state <= HALF;
                    else    if(pi_money == 2'b10)
                        state <= ONE;
                    else
                        state <= state;
        HALF    :   if(pi_money == 2'b01)
                        state <= ONE;
                    else    if(pi_money == 2'b10)
                        state <= ONE_HALF;
                    else
                        state <= state;
        ONE     :   if(pi_money == 2'b01)
                        state <= ONE_HALF;
                    else    if(pi_money == 2'b10)
                        state <= TWO;
                    else
                        state <= state;
        ONE_HALF:   if(pi_money == 2'b01)
                        state <= TWO;
                    else    if(pi_money == 2'b10)
                        state <= IDLE;
                    else
                        state <= state;
        TWO     :   if(pi_money == 2'b01 || pi_money == 2'b10)
                        state <= IDLE;
                    else
                        state <= state;
        default :   state <= IDLE;
    endcase

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        po_cola <= 1'b0;
    else    if((state == ONE_HALF && pi_money == 2'b10) //1.5+1
            || (state == TWO && pi_money == 2'b01)      //2+0.5
            || (state == TWO && pi_money == 2'b10))     //2+1
        po_cola <= 1'b1;
    else 
        po_cola <= 1'b0;

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        po_money <= 1'b0;
    else    if(state == TWO && pi_money == 2'b10)       //2+1=2.5+0.5
        po_money <= 1'b1;
    else
        po_money <= 1'b0;

endmodule
