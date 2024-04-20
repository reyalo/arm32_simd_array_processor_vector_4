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
  case (instruction[27:26])
    
    2'b00:begin     // alu
      
      op = instruction[24:21];

      jump_en = 1'b0;
      jump_address = 32'hxxxx;


      reg_read_address1 = instruction[19:16];
      // reg_read_address2 = instruction[21:18];// todo

      // reg_write_enable = 1'b0;
      reg_write_enable = 1'b1;
      // reg_write_address = instruction[17:14];
      reg_write_address = instruction[15:12];

      if(instruction[25] == 1'b0)begin

          immidiate_en = 1'b0;
          immidiate_data = 32'hxxxx_xxxx;
          reg_read_address2 = instruction[3:0];

      end else begin
          immidiate_en = 1'b1;
          immidiate_data = {24'b0, instruction[7:0]};
          // reg_read_address2 = instruction[3:0];
          reg_read_address2 = 4'bx;
      end

      

      mem_load_enable = 1'b0;
      mem_write_enable = 1'b0;


      // vector = 1'b0;
      vector = 1'b1;

    end

    2'b01:begin     // memory_io
      
      op = instruction[24:21];

      jump_en = 1'b0;
      jump_address = 32'hxxxx;


      reg_read_address1 = instruction[19:16];
      reg_read_address2 = instruction[3:0];

      // reg_write_enable = 1'b1;
      reg_write_address = instruction[15:12];

      immidiate_data = {20'b0, instruction[11:0]};

      vector = 1'b1;

      
      if(instruction[20] == 1'b0)begin
          // load
          if(instruction[25])begin
              // direct
              case (op)

                  // load operation
                  4'b0000:begin
                    reg_write_enable = 1'b1;

                    mem_load_select = 2'b01;  // direct
                    mem_load_enable = 1'b1;   // reg_write_data_mem/cpu

                    // vector = 1'b1;

                    mem_write_enable = 1'b0;  //!todo
                  end

                  4'b1000:begin
                    reg_write_enable = 1'b1;

                    mem_load_select = 2'b01;  // direct
                    mem_load_enable = 1'b1;   // reg_write_data_mem/cpu

                    vector = 1'b0;   // 0 => counter on, 1 => counter reset
                    mem_write_enable = 1'b0;  //!todo
                  end
                  default: ;
              endcase

          end else begin
              // indirect
              case (op)
                  4'b0001:begin
                    reg_write_enable = 1'b1;

                    mem_load_select = 2'b10;  // indirect
                    mem_load_enable = 1'b1;

                    // vector = 1'b0;


                    // mem_write_enable = 1'b0;  //!TODO
                  end
                  default: ;
              endcase
          end


      end else begin
          // store
          if(instruction[25])begin
              // direct
              case (op)

                4'b0100:begin
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
                default: ;



              endcase

          end else begin
              // indirect
              case(op)
                  4'b0101:begin
                      reg_write_enable = 1'b0;

                      mem_load_select = 2'bxx;  // indirect //todo
                      mem_load_enable = 1'b0;

                      mem_write_enable = 1'b1;


                    end
                  default: ;
              endcase
          end

      end

    end

    2'b10:begin     // branching
      
      op = instruction[29:26];

      jump_en = 1'b1;
      jump_address = {{8{instruction[23]}}, instruction[23:0]}; //! todo for jump register


      reg_read_address1 = 4'hx;
      reg_read_address2 = 4'hx;

      reg_write_enable = 1'b0;
      reg_write_address = 32'hxxx;

      immidiate_en = 1'b0;
      immidiate_data = 32'hxxxx_xxxx;

      // vector = 1'b0;
      vector = 1'b1;

    end
    

  endcase

end



endmodule