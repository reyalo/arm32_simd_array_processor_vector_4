module alu_tb;
  reg [127:0] operand1;
  reg [127:0] operand2;
  reg [3:0] op;

  wire [127:0] result;
  wire zero_flag;

alu uut(

  .operand1(operand1),
  .operand2(operand2),
  .op(op),
  .result(result),
  .zero_flag(zero_flag)

);


initial begin
  
  operand1 = 128'b0;
  operand2 = 128'b0;
  op       = 4'b0;

  // $display("operand1 = %b", operand1);
  // $display("operand2 = %b", operand2);
  // $display("Result = %b", result);
  // $display("Zero Flag = %b\n", zero_flag);

  #10 ;

  operand1 = 128'b00000000000000000000000000001111000000000000000000000000000001110000000000000000000000000000001100000000000000000000000000000001;
  operand2 = 128'b00000000000000000000000000001111000000000000000000000000000001110000000000000000000000000000001100000000000000000000000000000001;
  op       = 4'b0111;

  #10;

  operand1 = 128'b1000;
  operand2 = 128'b1000;
  op       = 4'b0101;

  #10;


  #10;



  $finish;

end


initial begin
  $monitor("result\n %b\n %b\n %b\n %b", result[127:96], result[95:64], result[63:32] ,result[31:0] );
  // $monitor("result %d %d %d %d", result[127:96], result[95:64], result[63:32] ,result[31:0] );
end


// always begin
//     #5 clk = ~clk;
// end

endmodule