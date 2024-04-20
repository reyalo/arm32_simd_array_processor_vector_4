module alu(
  input wire [127:0] operand1,
  input wire [127:0] operand2,
  input wire [3:0] op,

  output reg [127:0] result,
  output reg zero_flag
);

  always @* begin
    
    case(op)
      4'b0000:begin
          result[31:0] = operand1[31:0] & operand2[31:0];
          result[63:32] = operand1[63:32] & operand2[63:32];
          result[95:64] = operand1[95:64] & operand2[95:64];
          result[127:96] = operand1[127:96] & operand2[127:96] ;  // AND
      end
        
      4'b0001: result = operand1 | operand2;  // OR
      4'b0010: result = operand1 ^ operand2;  // xor
      4'b0101:begin
          result[31:0] = operand1[31:0] + operand2[31:0];
          result[63:32] = operand1[63:32] + operand2[63:32];
          result[95:64] = operand1[95:64] + operand2[95:64];
          result[127:96] = operand1[127:96] + operand2[127:96] ;
      end
      4'b0110:begin
          result[31:0] = operand1[31:0] - operand2[31:0];
          result[63:32] = operand1[63:32] - operand2[63:32];
          result[95:64] = operand1[95:64] - operand2[95:64];
          result[127:96] = operand1[127:96] - operand2[127:96] ;
      end
      4'b0111:begin
          result[31:0] = operand1[31:0] * operand2[31:0];
          result[63:32] = operand1[63:32] * operand2[63:32];
          result[95:64] = operand1[95:64] * operand2[95:64];
          result[127:96] = operand1[127:96] * operand2[127:96] ;
      end
      // 4'b0101: result = operand1 + operand2;  // ADD
      // 4'b0110: result = operand1 - operand2;  // sub
      // 4'b0111: result = operand1 * operand2;  // mul
      4'b1100: result = operand1 / operand2;  // div
      default: result = 128'b0;
    endcase
    zero_flag = (result[31:0] == 32'b0);
  end
  


endmodule