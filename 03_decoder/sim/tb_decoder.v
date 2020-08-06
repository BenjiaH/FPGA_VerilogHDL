`timescale 1ns/1ns

module tb_decoder();

reg     in_1;
reg     in_2;
reg     in_3;
wire    [7:0]   out;

initial
    begin
        in_1 <= 1'b0;
        in_2 <= 1'b0;
        in_3 <= 1'b0;
    end

always #10 in_1 <= {$random} % 2;
always #10 in_2 <= {$random} % 2;
always #10 in_3 <= {$random} % 2;

initial
    begin
        $timeformat(-9, 0, "ns", 6);
        $monitor("@time %t:in_1=%b in_2=%b in_3=%b out=%b", $time, in_1, in_2, in_3, out);
    end

decoder decoder_inst
(
   .in_1(in_1),
   .in_2(in_2),
   .in_3(in_3),
   .out (out)
);

endmodule
