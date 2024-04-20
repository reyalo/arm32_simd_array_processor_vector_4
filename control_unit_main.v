module control_unit(

  // input wire clk,


  input wire [31:0] instruction,

  output reg [3:0] op,

  output reg [3:0] reg_read_address1, 
  output reg [3:0] reg_read_address2, 

  output reg reg_write_enable,
  output reg [3:0] reg_write_address,

  output reg immidiate_en,
  output reg [31:0] immidiate_data, //! recheck

  output reg jump_en,
  output reg [31:0] jump_address,

  // output reg mem_load,
  // output reg mem_store

  output reg vector,
  
  //* load from memory
  output reg mem_load_enable,
  output reg [1:0] mem_load_select,
  // 01 for (LD R0,[2]), 10 for (LD R0,[R1]),11 for (LD R0,[R1+1])

  //* store to memory
  output reg mem_write_enable
  

);

// always @(!clk) begin
always @* begin
  case (instruction[31:30])
    
    2'b00:begin     // alu_register_mode
      
      op = instruction[29:26];

      jump_en = 1'b0;
      // jump_address = 32'b0;
      jump_address = 32'hxxxx;


      reg_read_address1 = instruction[25:22];
      reg_read_address2 = instruction[21:18];

      // reg_write_enable = 1'b0;
      reg_write_enable = 1'b1;
      // reg_write_address = instruction[17:14];
      reg_write_address = instruction[25:22];

      immidiate_en = 1'b0;
      immidiate_data = 32'hxxxx_xxxx;

      mem_load_enable = 1'b0;
      mem_write_enable = 1'b0;


      // vector = 1'b0;
      vector = 1'b1;

    end

    2'b01:begin     // alu_immediate_mode
      
      op = instruction[29:26];

      jump_en = 1'b0;
      jump_address = 32'hxxxx;


      reg_read_address1 = instruction[25:22];
      reg_read_address2 = 4'hx;

      reg_write_enable = 1'b1;
      reg_write_address = instruction[25:22];  // write in reg1 address

      immidiate_en = 1'b1;
      immidiate_data = { 24'b0, instruction[17:10] };
      // immidiate_data = { 14'b0, instruction[17:10], 10'b0 };

      

      // memory I/O now turn off
      mem_load_enable = 1'b0;
      mem_write_enable = 1'b0;

      // vector = 1'b0;
      vector = 1'b1;

    end

    2'b10:begin     // branching
      
      op = instruction[29:26];

      jump_en = 1'b1;
      jump_address = instruction[25:0]; //! todo for jump register


      reg_read_address1 = 4'hx;
      reg_read_address2 = 4'hx;

      reg_write_enable = 1'b0;
      reg_write_address = 32'hxxx;

      immidiate_en = 1'b0;
      immidiate_data = 32'hxxxx_xxxx;

      // vector = 1'b0;
      vector = 1'b1;

    end
    2'b11:begin     // memory_io
      
      op = instruction[29:26];

      jump_en = 1'b0;
      jump_address = 32'hxxxx;


      reg_read_address1 = instruction[25:22];
      reg_read_address2 = instruction[21:18];

      // reg_write_enable = 1'b1;
      reg_write_address = instruction[25:22];   // same as RA

      immidiate_data = { 24'b0, instruction[17:10] };

      // if(op==4'b0011 || op==4'b0001)begin
      //   immidiate_en = 1'b1;
      // end else begin
      //   immidiate_en = 1'b0;
      // end

      vector = 1'b1;

      case (op)

        // load operation
        4'b0000:begin
          reg_write_enable = 1'b1;

          mem_load_select = 2'b01;  // direct
          mem_load_enable = 1'b1;   // reg_write_data_mem/cpu

          // vector = 1'b1;

          mem_write_enable = 1'b0;  //!todo
        end

        4'b0001:begin
          reg_write_enable = 1'b1;

          mem_load_select = 2'b10;  // indirect
          mem_load_enable = 1'b1;

          // vector = 1'b0;


          // mem_write_enable = 1'b0;  //!TODO
        end

        4'b1000:begin
          reg_write_enable = 1'b1;

          mem_load_select = 2'b01;  // direct
          mem_load_enable = 1'b1;   // reg_write_data_mem/cpu

          vector = 1'b0;   // 0 => counter on, 1 => counter reset
          mem_write_enable = 1'b0;  //!todo
        end


        // store operation
        4'b0100:begin
          reg_write_enable = 1'b0;

          mem_load_select = 2'bxx;  // direct
          mem_load_enable = 1'b0;


          mem_write_enable = 1'b1;

        end
        4'b0101:begin
          reg_write_enable = 1'b0;

          mem_load_select = 2'bxx;  // direct
          mem_load_enable = 1'b0;

          mem_write_enable = 1'b1;


        end

        4'b1100:begin
          reg_write_enable = 1'b0;

          mem_load_select = 2'bxx;  // direct
          mem_load_enable = 1'b0;


          mem_write_enable = 1'b1;

          vector = 1'b0;   // 0 => counter on, 1 => counter reset

        end



      endcase
        


    end

  endcase

end



endmodule