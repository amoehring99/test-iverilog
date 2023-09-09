`begin_keywords "1800-2012"

module top;
  timeunit 1ns; timeprecision 1ns;

  logic [31:0] A, B;
  logic MODE;
  logic [31:0] SUM;
  logic CLK;
  
  adder_subtractor_32_tb  test (.*);
  adder_subtractor_32     dut  (.*);

  initial begin
    CLK <= 0;
    forever #5 CLK = ~CLK;
  end
endmodule: top

`end_keywords