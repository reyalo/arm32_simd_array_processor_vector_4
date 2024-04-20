module processor_tb;

reg clk;
reg reset;
wire [31:0] instruction;
// reg [31:0] instruction;
wire [127:0] result;
wire [1:0] offset_wire;
wire [127:0] reg_read_data1_wire;
wire [127:0] reg_read_data2_wire;
wire [127:0] reg_write_data_wire;

wire [31:0] mem_write_data_wire;
// wire [31:0] reg_read_data1_wire;
// wire [31:0] reg_read_data2_wire;
// wire [31:0] reg_write_data_wire;
// wire zero_flag;

processor uut(
  .clk(clk),
  .reset(reset),
  .instruction(instruction),
  .result(result),

  .offset_wire(offset_wire),

  .reg_read_data1_wire(reg_read_data1_wire),
  .reg_read_data2_wire(reg_read_data2_wire),
  .reg_write_data_wire(reg_write_data_wire),


  .mem_write_data_wire(mem_write_data_wire)
  // .reg_read_data1_wire(reg_read_data1_wire),
  // .reg_read_data2_wire(reg_read_data2_wire),
  // .reg_write_data_wire(reg_write_data_wire)
  // .zero_flag(zero_flag)
);

always @(posedge clk) begin
// always @( !clk ) begin

    $display("CVL = %b",offset_wire);
    $display("INS = %b",instruction);
    $display("RD1 = %d %d %d %d",reg_read_data1_wire[127:96], reg_read_data1_wire[95:64], reg_read_data1_wire[63:32], reg_read_data1_wire[31:0] );
    $display("RD2 = %d %d %d %d",reg_read_data2_wire[127:96], reg_read_data2_wire[95:64], reg_read_data2_wire[63:32], reg_read_data2_wire[31:0] );
    $display("RWD = %d %d %d %d",reg_write_data_wire[127:96], reg_write_data_wire[95:64], reg_write_data_wire[63:32], reg_write_data_wire[31:0] );
    $display("MWD = %d",mem_write_data_wire);
    $display("result = %d %d %d %d\n",result[127:96], result[95:64], result[63:32], result[31:0]);
end


initial begin

  $dumpfile("processor.vcd");
  $dumpvars(0, processor_tb);
  
  clk = 0;
  reset = 0;
  // instruction = 32'b0;

  // instruction = 32'b00010100000001000011110000111100;  // add 0,1
  //                           reg1 reg2 imd_data
  // instruction = 32'b01 0101 0000 0001 00001111 0000111100;  // add r1,15
  // instruction = 32'b01010100000001000011110000111100;  // add r0,16
  // instruction = 32'b11 0000 0000 0001 00000011 0000111100;  // LD r0,[3]
  // instruction = 32'b11000000000001000000110000111100;  // LD r0,[3]

  // instruction = 32'b11000000000001000001110000111100;  // LD r0,[3]
  // #10;
  

  // instruction = 32'b11100000000001000000010000111100;  // VLD r0,[1]

  // result toiri hoye gese because cu,reg,alu works combinationaly 
  // but reg update after this cycle
  #10;
  // instruction = 32'b01010100000001000100010000111100;  // add ,15
  // instruction = 32'b11 0000 0001 0001 00000100 0000111100;  // LD r1,[4]
  // instruction = 32'b11000000010001000000110000111100;  // LD r1,[3]
  // instruction = 32'b11000000010001000000100000111100;  // LD r1,[2]

  // // instruction = 32'b01010100000001000011110000111100;  // add 0,1,15
  
  // // // instruction = 32'b00010100000010000011110000111100;  // add 0,1,0
  #10;

  // instruction = 32'b00 0101 0000 0001 00001111 0000111100;  // add r0, r1
  // instruction = 32'b00 0101 0000 0001 00001111 0000111100;  // add r0, r1
  // instruction = 32'b00010100000001000011110000111100;  // add r0, r1

  // #10;
  // instruction = 32'b00010100000001000011110000111100;  // add r0, r1

  #10;

  // instruction = 32'b11 0100 0000 0001 00000011 0000111100;  // ST r0,[3]
  // instruction = 32'b11010000000001000000110000111100;  // ST r0,[3]

  // #10;
  // instruction = 32'b0;  // ST r0,[3]

  // #10;

  // instruction = 32'b11000000000001000000110000111100;  // LD r0,[3]

  // #10;

  // instruction = 32'b11000000010001000000110000111100;  // LD r1,[3]

  // #10;

  // instruction = 32'b00010100000001000011110000111100;  // add r0, r1

  #10;

  // instruction = 32'b11100000010001000000010000111100; // VLD r1, [1];
  // instruction = 32'b11100000010001000000000000111100; // VLD r1, [0];

  #10;#10;#10;#10;

  // instruction = 32'b00010100000001000011110000111100;  // add r0, r1

  #10;



  // instruction = 32'b11000000000001000000110000111100;  // LD r0,[3]
  // #10;

  // instruction = 32'b11000000000001000000110000111100;  // LD r0,[3]


  // instruction = 32'b11 1100 0000 0001 00000001 0000111100;  // VST [1], r0
  // instruction = 32'b11110000000001000000010000111100;  // VST [1], r0

  #10;#10;#10;#10;

  // #10;

  // instruction = 32'b11000000000001000000010000111100;  // LD r0,[1]
  // #10;

  // instruction = 32'b11100000010001000000010000111100;  // VLD r0,[1]
  #10;#10;#10;#10;

  // instruction = 32'b11000000000001000000010000111100;  // LD r0,[1]
  #10;


  // VLD r0, [1]
  // VLD r1, [0]
  // ADD r0, r1
  // VST [1], r0
  // VLD r0, [1]
  // LD  r0, [1]

  //equivalant machine code for arm32

// 1110_01_1_1000_1_0000_0000_00000000_0001

// 1110_01_1_1000_1_0001_0001_00000000_0000

// 1110_00_0_0101_0_0000_0000_00000000_0001

// 1110_01_1_1100_1_0000_0000_00000000_0001

// 1110_01_1_1000_1_0000_0000_00000000_0001

// 1110_01_1_0000_1_0000_0000_00000000_0001








  $finish;


end

// initial begin
//   $monitor("result = %b ",result);
// end


always begin
    #5 clk = ~clk;
end

endmodule
