`timescale 1ns/1ns

module  tb_full_adder();

reg     in_1;
reg     in_2;
reg     cin ;

wire    sum ;
wire    count;

initial
    begin
        in_1 <= 1'b0;
        in_2 <= 1'b0;
        cin  <= 1'b0;
    end

initial
    begin
        $timeformat(-9, 0, "ns", 6);
        $monitor("@ time %t:in_1=%b,in_2=%b,cin=%b,sum=%b,count=%b", $time, in_1, in_2, cin, sum, count);
    end

always #10 in_1 <= {$random} % 2;
always #10 in_2 <= {$random} % 2;
always #10 cin  <= {$random} % 2;

full_adder full_adder_inst
(
    .in_1(in_1),
    .in_2(in_2),
    .cin (cin),

    .sum (sum),
    .count(count)
);

endmodule
