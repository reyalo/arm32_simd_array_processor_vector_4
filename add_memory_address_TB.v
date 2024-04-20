module add_memory_address_TB();

reg [7:0] address;
reg [1:0] offset;

wire [7:0] outputAddress;


add_memory_address uut(

    .address(address),
    .offset(offset),
    .outputAddress(outputAddress)

);

initial begin

    address = 8'b0;
    offset = 2'b00;


    #10;

    // address = 8'b0;
    offset = 2'b01;

    #10;

    // address = 8'b0;
    offset = 2'b10;


    #10;

    $finish;



end


initial begin
  $monitor("output_address %b zf %b", offset, outputAddress);
end


endmodule