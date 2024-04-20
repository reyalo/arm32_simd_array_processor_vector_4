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

  wire mem_load;
  wire mem_store;

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

    .mem_load(mem_load),
    .mem_store(mem_store)

  );

  initial begin

    instruction = 32'b0;




    #10;
    instruction = 32'b00111100001111000011110000111100;

    #10;
    instruction = 32'b01111100001111000011110000111100;

    #10;
    instruction = 32'b10111100001111000011110000111100;

    #10;
    instruction = 32'b11111100001111000011110000111100;

    #10;
    instruction = 32'b11001100001111000011110000111100;

    #10;
    instruction = 32'b11000100001111000011110000111100;

    #10;

    $finish;


  end

initial begin

  $monitor("op=%b ra1=%b ra2=%b\n we=%b wa=%b ie=%b id=%b \n je=%b ja=%b ml=%b ms=%b\n\n",op,reg_read_address1,reg_read_address2,reg_write_enable,reg_write_address,immidiate_en,immidiate_data,jump_en,jump_address,mem_load,mem_store);

end


endmodule