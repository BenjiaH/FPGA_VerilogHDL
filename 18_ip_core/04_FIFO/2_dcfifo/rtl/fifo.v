module  fifo
(
    input   wire            wr_clk      ,
    input   wire            wr_req      ,
    input   wire    [7:0]   wr_data     ,
    input   wire            rd_clk      ,
    input   wire            rd_req      ,

    output  wire    [15:0]  rd_data     ,
    output  wire            wr_empty    ,
    output  wire            wr_full     ,
    output  wire    [8:0]   wr_usedw    ,
    output  wire            rd_empty    ,
    output  wire            rd_full     ,
    output  wire    [7:0]   rd_usedw    
);

dcfifo_8x256_to_16x128  dcfifo_8x256_to_16x128_inst
(
    .data       (wr_data    ),
    .rdclk      (rd_clk     ),
    .rdreq      (rd_req     ),
    .wrclk      (wr_clk     ),
    .wrreq      (wr_req     ),

    .q          (rd_data    ),
    .rdempty    (rd_empty   ),
    .rdfull     (rd_full    ),
    .rdusedw    (rd_usedw   ),
    .wrempty    (wr_empty   ),
    .wrfull     (wr_full    ),
    .wrusedw    (wr_usedw   )
);

endmodule
