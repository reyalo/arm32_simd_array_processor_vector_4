module memory(
  input wire clk,
  input wire mem_write_enable,
  input wire [7:0] write_address,
  input wire [31:0] write_data,
  input wire [7:0] read_address1,
  input wire [7:0] read_address2,
  output wire [31:0] read_data1,
  output wire [31:0] read_data2
);

reg [31:0] mem [0:255]; //255*32
initial begin
  $readmemb("memory.bin", mem);
end

always @(posedge clk) begin
  if(mem_write_enable)begin
    mem[write_address] <= write_data;
  end
end

assign read_data1 = mem[read_address1];
assign read_data2 = mem[read_address2];

endmodule