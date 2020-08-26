`timescale 1ns/1ns

module  tb_fifo();

//input
reg             sys_clk     ;
reg             sys_rst_n   ;
reg     [7:0]   pi_data     ;
reg             rd_req      ;
reg             wr_req      ;

//output
wire            empty       ;
wire            full        ;
wire    [7:0]   po_data     ;
wire            usedw       ;

//var
reg     [1:0]   cnt         ;

initial
    begin
        sys_clk = 1'b1;
        sys_rst_n <= 1'b0;
        #20
        sys_rst_n <= 1'b1;

    end

always #10 sys_clk = ~sys_clk;

//cnt
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        cnt <= 2'd0;
    else    if(cnt == 2'd3)
        cnt <= 2'd0;
    else
        cnt <= cnt + 1'b1;

//pi_data
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        pi_data <= 8'd0;
    else    if(pi_data == 8'd255 && wr_req == 1'b1)
        pi_data <= 8'd0;
    else    if(wr_req == 1'b1)
        pi_data <= pi_data + 1'b1;

//rd_req
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        rd_req <= 1'b0;
    else    if(full == 1'b1)
        rd_req <= 1'b1;
    else    if(empty == 1'b1)
        rd_req <= 1'b0;

//wr_req
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        wr_req <= 1'b0;
    else    if(cnt == 2'd0 && rd_req == 1'b0)
        wr_req <= 1'b1;
    else
        wr_req <= 1'b0;

fifo    fifo_inst
(
    .sys_clk (sys_clk),
    .pi_data (pi_data),
    .rd_req  (rd_req ),
    .wr_req  (wr_req ),

    .empty   (empty  ),
    .full    (full   ),
    .po_data (po_data),
    .usedw   (usedw  )
);

endmodule
