`timescale 1ns/1ns

module  tb_half_adder();

reg     in_1;
reg     in_2;

wire    sum;
wire    count;

initial
    begin
        in_1 <= 1'b0;
        in_2 <= 1'b0;
    end

always #10 in_1 <= {$random} % 2;
always #10 in_2 <= {$random} % 2;

initial
    begin
        $timeformat(-9, 0, "ns", 6);
        $monitor("@ time %t:in_1=%b,in_2=%b,sum=%b,count=%b", $time, in_1, in_2, sum, count);
    end


half_adder half_adder_inst
(
    .in_1   (in_1),
    .in_2   (in_2),

    .sum    (sum),
    .count  (count)
);

endmodule
