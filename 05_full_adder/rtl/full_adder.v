module  full_adder
(
    input   wire    in_1,
    input   wire    in_2,
    input   wire    cin ,
    
    output  wire    sum ,
    output  wire    count
);

wire    h0_sum  ;
wire    h0_count;
wire    h1_count;

//实例化半加器
half_adder  half_adder_inst0
(
   .in_1(in_1),     //引入in_1
   .in_2(in_2),     //引入in_2

   .sum (h0_sum),   //引出到h0_sum
   .count(h0_count) //引出到h0_count
);

half_adder  half_adder_inst1
(
   .in_1(cin),      //引入cin
   .in_2(h0_sum),   //引入h0_sum
                    
   .sum (sum),      //引出到um
   .count(h1_count) //引出到h1_count
);

assign  count = h0_count | h1_count; //或运算

endmodule
