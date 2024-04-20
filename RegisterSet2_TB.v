module RegisterSet2_TB;

reg clk;
reg reset;
reg writeEnable;
reg mem_load_enable;
reg [3:0] readAddress1;
reg [3:0] readAddress2;
reg [3:0] writeAddressR;
reg [1:0] writeAddressC;
reg [127:0] writeData;
wire [127:0] readData1;
wire [127:0] readData2;

RegisterSet2 uut (
    .clk(clk),
    .reset(reset),
    .writeEnable(writeEnable),
    .mem_load_enable(mem_load_enable),
    .readAddress1(readAddress1),
    .readAddress2(readAddress2),
    .writeAddressR(writeAddressR),
    .writeAddressC(writeAddressC),
    .writeData(writeData),
    .readData1(readData1),
    .readData2(readData2)
);

always @(posedge clk) begin
    $display("RA1 = %d", readAddress1);
    $display("ReadData1 = %b", readData1);
    $display("RA2 = %d", readAddress2);
    $display("ReadData2 = %b\n", readData2);
end
// always @(readData2) begin
// end

initial begin
    clk = 0;
    reset = 0;
    readAddress1 = 0;
    readAddress2 = 0;
    writeAddressR = 0;
    writeAddressC = 0;
    writeData = 128'b0;
    writeEnable = 0;
    mem_load_enable = 0;

    // Initialize the simulation
    // ...

    // Apply a reset signal to initialize the registers
    // reset = 1;
    // #10 reset = 0;

    // // Write to register 0
    writeAddressR = 0;
    writeAddressC = 0;
    // writeData = 32'b1101;  // this update done after this time
    writeData = 128'hffffffff;  // this update done after this time
    writeEnable = 1;
    mem_load_enable = 1;
    #10 writeEnable = 0;

    // // Read from register 0
    readAddress1 = 0;
    // readAddress2 = 1;
    #10;

    // // Write to register 1
    // writeAddress = 1;
    // writeData = 32'b1010;
    // writeEnable = 1;
    // #10 writeEnable = 0;

    // // Read from register 1
    // readAddress1 = 1;
    // readAddress2 = 0;
    // #10;

    writeAddressR = 0;
    writeAddressC = 1;
    // writeData = 32'b1101;  // this update done after this time
    writeData = 128'hffffffff;  // this update done after this time
    writeEnable = 1;
    #10 writeEnable = 0;

    // // Read from register 0
    readAddress1 = 0;
    // readAddress2 = 1;
    #10;

    // Continue with more test cases and stimuli
    // ...

    $finish;
end

// Clock generation
always begin
    #5 clk = ~clk;
end

endmodule
