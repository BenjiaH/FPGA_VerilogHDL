//~ `New testbench
`timescale  1ns / 1ps

module tb_beep;

// beep Parameters
parameter CNT_MAX        = 25'd24_999_99 ;
parameter CNT_500MS_MAX  = 3'd6          ;
parameter DO             = 18'd19083     ;
parameter RI             = 18'd17006     ;
parameter MI             = 18'd15151     ;
parameter FA             = 18'd14326     ;
parameter SO             = 18'd12755     ;
parameter LA             = 18'd11363     ;
parameter XI             = 18'd10121     ;

// beep Inputs
reg   sys_clk   ;
reg   sys_rst_n ;

// beep Outputs
wire  beep      ;


initial
    begin
        sys_clk = 1'b1;
        sys_rst_n <= 1'b0;
        #20
        sys_rst_n <= 1'b1;
    end

always #10 sys_clk = ~sys_clk;

beep 
#(
    .CNT_MAX       ( CNT_MAX       ),
    .CNT_500MS_MAX ( CNT_500MS_MAX ),
    .DO            ( DO            ),
    .RI            ( RI            ),
    .MI            ( MI            ),
    .FA            ( FA            ),
    .SO            ( SO            ),
    .LA            ( LA            ),
    .XI            ( XI            ))
 beep_inst
 (  
    .sys_clk    ( sys_clk     ),
    .sys_rst_n  ( sys_rst_n   ),
    
    .beep       ( beep        )
);

endmodule