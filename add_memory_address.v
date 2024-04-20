module add_memory_address(

  input wire [7:0] address,
  input wire [1:0] offset,

  output reg [7:0] outputAddress

);

always @* begin

    outputAddress = address + offset;

end

endmodule