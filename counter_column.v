module counter_column(
    input wire clk,
    input wire reset,
    output wire [1:0] counter_val
);

reg [1:0] counter;

initial begin
  counter <= 2'b0;
end


  always @(posedge clk) begin

        if(!reset)begin
            counter <= counter + 2'b1;
        end else begin
            counter <= 2'b0;
        end
          



  end

  assign counter_val = counter;


endmodule

