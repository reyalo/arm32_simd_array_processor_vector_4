// `timescale 1ns / 1ps
// `default_nettype none

// `resetall
// `define g2005

module control_unit_tb;

  reg [31:0] instruction;

  wire [3:0] op;

  wire [3:0] reg_read_address1;
  wire [3:0] reg_read_address2;

  wire reg_write_enable;
  wire [3:0] reg_write_address;

  wire immidiate_en;
  wire [31:0] immidiate_data; //! recheck

  wire jump_en;
  wire [31:0] jump_address;

  wire mem_load_enable;
  wire [1:0] mem_load_select;
  wire mem_write_enable;

  control_unit uut(
    .instruction(instruction),

    .op(op),

    .reg_read_address1(reg_read_address1),
    .reg_read_address2(reg_read_address2),

    .reg_write_enable(reg_write_enable),
    .reg_write_address(reg_write_address),

    .immidiate_en(immidiate_en),
    .immidiate_data(immidiate_data),

    .jump_en(jump_en),
    .jump_address(jump_address),

    .mem_load_enable(mem_load_enable),
    .mem_write_enable(mem_write_enable),
    .mem_load_select(mem_load_select)

  );

  initial begin

    instruction = 32'b0;




    #10;
    instruction = 32'b11100111000000000000000000000001;

    #10;
    instruction = 32'b11100111000000000001000000000000;

    #10;
    instruction = 32'b11100111100100000000000000000001;

    // #10;
    // instruction = 32'b11111100001111000011110000111100;

    // #10;
    // instruction = 32'b11001100001111000011110000111100;

    // #10;
    // instruction = 32'b11000100001111000011110000111100;

    #10;

    $finish;


  end

initial begin

  $monitor("20=%b 25=%b op=%b ra1=%b ra2=%b\n we=%b wa=%b ie=%b id=%b \n je=%b ja=%b ml=%b ms=%b mls=%b\n\n",instruction[20],instruction[25],op,reg_read_address1,reg_read_address2,reg_write_enable,reg_write_address,immidiate_en,immidiate_data,jump_en,jump_address,mem_load_enable,mem_write_enable,mem_load_select);

end


endmodule