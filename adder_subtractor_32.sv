`begin_keywords "1800-2012"

module adder_subtractor_32 (
  input logic CLK,
  input logic MODE,
  input logic [31:0] A, B,
  output logic [31:0] SUM
);

  always_ff @(posedge CLK) begin
    if (MODE == 0) SUM <= A + B;
    else SUM <= A - B;
  end
endmodule: adder_subtractor_32

`end_keywords