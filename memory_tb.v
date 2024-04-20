module memory_tb;

reg clk;
reg mem_write_enable;
reg [5:0] write_address;
reg [31:0] write_data;
reg [5:0] read_address1;
reg [5:0] read_address2;
wire [31:0] read_data1;
wire [31:0] read_data2;

// input gulu reg e rakhchi karon amra bivinno value er input provide korbo

memory uut(
  .clk(clk),
  .mem_write_enable(mem_write_enable),
  .write_address(write_address),
  .write_data(write_data),
  .read_address1(read_address1),
  .read_address2(read_address2),
  .read_data1(read_data1),
  .read_data2(read_data2)
);

always @(posedge clk) begin
    $display("RA1 = %d", read_address1);
    $display("ReadData1 = %b", read_data1);
    $display("RA2 = %d", read_address2);
    $display("ReadData2 = %b\n", read_data2);
end

initial begin
    clk = 0;
    read_address1 = 0;
    read_address2 = 1;
    write_address = 0;
    write_data = 32'b0;
    mem_write_enable = 0;

    // initialization

    #10 

    write_address = 0;
    write_data = 32'b0101;
    mem_write_enable = 1;

    #10 mem_write_enable = 0;

    // read_address1=0;


    #10;

    write_address = 1;
    write_data = 32'b1001;
    mem_write_enable = 1;

    #10 mem_write_enable = 0;


    #10;


    $finish;

end



// Clock generation
always begin
    #5 clk = ~clk;
end

endmodule

