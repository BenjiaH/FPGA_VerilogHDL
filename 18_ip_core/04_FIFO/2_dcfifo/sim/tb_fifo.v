`timescale 1ns/1ns

module  tb_fifo();

//input
reg             wr_clk      ;
reg             wr_req      ;
reg     [7:0]   wr_data     ;
reg             rd_clk      ;
reg             rd_req      ;

//output
wire    [15:0]  rd_data     ;
wire            wr_empty    ;
wire            wr_full     ;
wire    [8:0]   wr_usedw    ;
wire            rd_empty    ;
wire            rd_full     ;
wire    [7:0]   rd_usedw    ;

//var
reg             sys_rst_n   ;
reg     [1:0]   cnt         ;
reg             wr_full_reg0;
reg             wr_full_reg1;


initial
    begin
        wr_clk = 1'b1;
        rd_clk = 1'b1;
        sys_rst_n <= 1'b0;
        #20
        sys_rst_n <= 1'b1;
    end

always #10 wr_clk = ~wr_clk;    //50MHz
always #20 rd_clk = ~rd_clk;    //25MHz

always@(posedge wr_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        cnt <= 2'd0;
    else    if(cnt == 2'd3)
        cnt <= 2'd0;
    else
        cnt <= cnt + 1'b1;

always@(posedge wr_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        wr_req <= 1'b0;
    else    if(cnt == 2'd0 && rd_req == 1'b0)
        wr_req <= 1'b1;
    else
        wr_req <= 1'b0;

always@(posedge wr_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        wr_data <= 8'd0;
    else    if(wr_data == 8'd255 && wr_req == 1'b1)
        wr_data <= 8'd0;
    else    if(wr_req == 1'b1)
        wr_data <= wr_data + 1'b1;

always@(posedge rd_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        begin
            wr_full_reg0 <= 1'b0;
            wr_full_reg1 <= 1'b0;
        end
    else
        //将wr_full信号从写时钟同步到读时钟
        begin
            wr_full_reg0 <= wr_full;
            wr_full_reg1 <= wr_full_reg0;
        end

always@(posedge rd_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        rd_req <= 1'b0;
    else    if(wr_full_reg1 == 1'b1)
        rd_req <= 1'b1;
    else    if(rd_empty == 1'b1)
        rd_req <= 1'b0;

fifo    fifo_inst
(
    .wr_clk      (wr_clk    ),
    .wr_req      (wr_req    ),
    .wr_data     (wr_data   ),
    .rd_clk      (rd_clk    ),
    .rd_req      (rd_req    ),

    .rd_data     (rd_data   ),
    .wr_empty    (wr_empty  ),
    .wr_full     (wr_full   ),
    .wr_usedw    (wr_usedw  ),
    .rd_empty    (rd_empty  ),
    .rd_full     (rd_full   ),
    .rd_usedw    (rd_usedw  ) 
);

endmodule
