`timescale 1ns/1ns

module top;

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

`timescale 1ns/1ps