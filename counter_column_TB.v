module counter_column_TB;

reg clk;
reg reset;
wire [1:0] counter_val;

counter_column uut(
    .clk(clk),
    .reset(reset),
    .counter_val(counter_val)
);

always @(posedge clk) begin
    $display("clk = %b", clk);
    $display("Reset = %b", reset);
    $display("Counter Value = %d", counter_val);
    
end

initial begin
  clk = 0;
  reset = 0;
  // output 0
  #10

  // output 1
  #10

  // output 2
  #10

  // output 3
  #10

  // output 0
  reset = 1;
  #10 
  
  // output 0

  reset = 0;

  #10 
  // output 1

  #10 
  // output 2
  #10






  $finish;

end

always begin
    #5 clk = ~clk;
end

endmodule
