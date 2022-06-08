module  encode
(
    input   wire            sys_clk     ,
    input   wire            sys_rst_n   ,
    input   wire            c0          ,//h sync
    input   wire            c1          ,//v sync
    input   wire            de          ,
    input   wire    [7:0]   data_in     ,
    
    output  reg     [9:0]   data_out
);

wire    [8:0]   q_m         ;
wire            ctrl_1      ;
wire            ctrl_2      ;
wire            ctrl_3      ;

reg     [3:0]   data_in_n1  ;//max:4'd8, 4'b1000
reg     [7:0]   data_in_reg ;
reg     [4:0]   cnt         ;
reg     [3:0]   q_m_n0      ;
reg     [3:0]   q_m_n1      ;
reg     [8:0]   q_m_reg     ;
reg             de_reg1     ;
reg             de_reg2     ;
reg             c0_reg1     ;
reg             c0_reg2     ;
reg             c1_reg1     ;
reg             c1_reg2     ;


always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        data_in_n1 <= 4'd0;
    else
        data_in_n1 <= data_in[0] + data_in[1] + data_in[2] + data_in[3] +
                      data_in[4] + data_in[5] + data_in[6] + data_in[7];

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
            data_in_reg <= 8'b0;
    else
        data_in_reg <= data_in;

assign  ctrl_1 = (data_in_n1 > 4'd4) || ((data_in_n1 == 4'd4) && (data_in_reg[0] == 1'b0)) ? 1'b1 : 1'b0;

assign  q_m[0] = data_in_reg[0];
assign  q_m[1] = (ctrl_1 == 1'b1) ? (q_m[0] ^~ data_in_reg[1]) : (q_m[0] ^ data_in_reg[1]);
assign  q_m[2] = (ctrl_1 == 1'b1) ? (q_m[1] ^~ data_in_reg[2]) : (q_m[1] ^ data_in_reg[2]);
assign  q_m[3] = (ctrl_1 == 1'b1) ? (q_m[2] ^~ data_in_reg[3]) : (q_m[2] ^ data_in_reg[3]);
assign  q_m[4] = (ctrl_1 == 1'b1) ? (q_m[3] ^~ data_in_reg[4]) : (q_m[3] ^ data_in_reg[4]);
assign  q_m[5] = (ctrl_1 == 1'b1) ? (q_m[4] ^~ data_in_reg[5]) : (q_m[4] ^ data_in_reg[5]);
assign  q_m[6] = (ctrl_1 == 1'b1) ? (q_m[5] ^~ data_in_reg[6]) : (q_m[5] ^ data_in_reg[6]);
assign  q_m[7] = (ctrl_1 == 1'b1) ? (q_m[6] ^~ data_in_reg[7]) : (q_m[6] ^ data_in_reg[7]);
assign  q_m[8] = (ctrl_1 == 1'b1) ? 1'b0 : 1'b1;//add encoding bit

//DC equalization
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        begin
            q_m_n0 <= 4'd0;
            q_m_n1 <= 4'd0;
        end
    else
        begin
            q_m_n1 <= q_m[0] + q_m[1] + q_m[2] + q_m[3] +
                      q_m[4] + q_m[5] + q_m[6] + q_m[7];
            q_m_n0 <= 4'd8 -
                      (q_m[0] + q_m[1] + q_m[2] + q_m[3] +
                      q_m[4] + q_m[5] + q_m[6] + q_m[7]);
        end

assign  ctrl_2 = (cnt == 5'd0) || (q_m_n0 == q_m_n1) ? 1'b1 : 1'b0;
assign  ctrl_3 = ((cnt > 5'd0) && (q_m_n1 > q_m_n0)) || ((cnt < 5'd0) && (q_m_n0 > q_m_n1))? 1'b1 : 1'b0;

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        begin
            q_m_reg <= 9'b0;
            de_reg1 <= 1'b0;
            de_reg2 <= 1'b0;
            c0_reg1 <= 1'b0;
            c0_reg2 <= 1'b0;
            c1_reg1 <= 1'b0;
            c1_reg2 <= 1'b0;
        end
    else
        begin
            q_m_reg <= q_m;
            de_reg1 <= de;
            de_reg2 <= de_reg1;
            c0_reg1 <= c0;
            c0_reg2 <= c0_reg1;
            c1_reg1 <= c1;
            c1_reg2 <= c1_reg1;
        end

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        begin
            data_out <= 10'b0;
            cnt <= 5'b0;
        end
    else
        begin
            if(de_reg2 == 1'b1)
                begin
                    if(ctrl_2 == 1'b1)
                        begin
                            data_out[9] <= ~q_m_reg[8];
                            data_out[8] <= q_m_reg[8];
                            data_out[7:0] <= (q_m_reg[8] == 1'b1) ? (q_m_reg[7:0]) : (~q_m_reg[7:0]);
                            cnt <= (q_m_reg[8] == 1'b0) ? (cnt + q_m_n0 - q_m_n1) : (cnt + q_m_n1 - q_m_n0);
                        end
                    else
                        begin
                            if(ctrl_3 == 1'b1)
                                begin
                                    data_out[9] <= 1'b1;
                                    data_out[8] <= q_m_reg[8];
                                    data_out[7:0] <= ~q_m_reg[7:0];
                                    cnt <= cnt + {q_m_reg[8], 1'b0} + (q_m_n0 - q_m_n1);
                                end
                            else
                                begin
                                    data_out[9] <= 1'b0;
                                    data_out[8] <= q_m_reg[8];
                                    data_out[7:0] <= q_m_reg[7:0];
                                    cnt <= cnt - {~q_m_reg[8], 1'b0} + (q_m_n1 - q_m_n0);
                                end
                        end
                end
            else
                begin
                    // cnt <= 5'b0;
                    case({c1_reg2, c0_reg2})
                        2'b00:      data_out <= 10'b0010_1010_11;
                        2'b01:      data_out <= 10'b1101_0101_00;
                        2'b00:      data_out <= 10'b0010_1010_10;
                        default:    data_out <= 10'b1101_0101_01;
                    endcase
                    cnt <= 5'b0;
                end
        end

endmodule
