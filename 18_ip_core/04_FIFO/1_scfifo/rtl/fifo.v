module  fifo
(
    input   wire            sys_clk ,
    input   wire    [7:0]   pi_data ,
    input   wire            rd_req  ,
    input   wire            wr_req  ,

    output  wire            empty   ,
    output  wire            full    ,
    output  wire    [7:0]   po_data ,
    output  wire    [7:0]   usedw   
);

scfifo_8x256    scfifo_8x256_inst
(
    .clock  (sys_clk),
    .data   (pi_data),
    .rdreq  (rd_req ),
    .wrreq  (wr_req ),

    .empty  (empty  ),
    .full   (full   ),
    .q      (po_data),
    .usedw  (usedw  )
);

endmodule
