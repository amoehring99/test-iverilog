`begin_keywords "1800-2012"

module adder_subtractor_32_tb (
  output logic [31:0] A, B,
  output logic MODE,
  input logic [31:0] SUM,
  input logic CLK
);
  
  timeunit 1ns;
  timeprecision 1ns;

  // generate stimulus
  initial begin
    repeat (10) begin
      @(negedge CLK) ;

      A = $urandom_range(10, 20);
      B = $urandom_range(0, 10);
      MODE = $urandom() % 2;

      /*
      void' (std::randomize(A) with {A >= 10; A <= 20;});
      void' (std::randomize(B) with {B <= 10;});
      void' (std::randomize(MODE));
      */

      @ (negedge CLK) check_results;
    end
    @ (negedge CLK) $finish;
  end

  // verify results
  task check_results;
    $display("At %0d: \t A=%0d B=%0d MODE=%b SUM=%0d",
             $time, A, B, MODE, SUM);
    case (MODE)
      1'b0: if (SUM !== A + B) $error("expected SUM = %0d", A + B);
      1'b1: if (SUM !== A - B) $error("expected SUM = %0d", A - B);
    endcase
  endtask
endmodule: adder_subtractor_32_tb

`end_keywords