module par_to_ser
(
    input   wire        clk_5x  ,
    input   wire  [9:0] data_in ,

    output  wire        ser_p   ,
    output  wire        ser_n
);

wire    [4:0]   data_rise = {data_in[8], data_in[6], data_in[4], data_in[2], data_in[0]};
wire    [4:0]   data_fall = {data_in[9], data_in[7], data_in[5], data_in[3], data_in[1]};

reg     [4:0]   data_rise_s = 0;
reg     [4:0]   data_fall_s = 0;
reg     [2:0]   cnt         = 0;

always@(posedge clk_5x)
    begin
        cnt <= (cnt[2] == 1'b1) ? 3'd0 : cnt + 1'b1;
        data_rise_s <= (cnt[2] == 1'b1) ? data_rise : data_rise_s[4:1];
        data_fall_s <= (cnt[2] == 1'b1) ? data_fall : data_fall_s[4:1];
    end

ddio_out    ddio_out_inst_p
(
    .datain_h   (data_rise_s[0] ),
    .datain_l   (data_fall_s[0] ),
    .outclock   (~clk_5x        ),
    .dataout    (ser_p          )
);

ddio_out    ddio_out_inst_n
(
    .datain_h   (~data_rise_s[0]),
    .datain_l   (~data_fall_s[0]),
    .outclock   (~clk_5x        ),
    .dataout    (ser_n          )
);

endmodule