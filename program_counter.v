module program_counter(
    input wire clk,
    input wire reset,
    // input wire pause,  // 1 -> pause, 0 -> continue;
    input wire vector,
    input wire [1:0] offset,
    input wire jump_enable,

    input wire [7:0] jump_address,
    output wire [7:0] address
);

reg [7:0] counter;

initial begin
    counter <= 8'b1111;   // starting from 15
end

always @(posedge clk ) begin
    
    if(vector || offset == 2'b11)begin
        
        if(reset)begin
            counter <= 8'b1111;  // reset is 15 
        end
        else if(jump_enable == 1'b1) begin
            counter <= jump_address;
        end
        else begin
            counter <= counter + 8'b1;
        end


    end


end
assign address = counter;


endmodule