module RegisterSet2 (
    input wire clk,               // Clock input
    input wire reset,            // Reset input
    input wire writeEnable,         // Write enable signal
    input wire mem_load_enable,         // Write enable signal
    input wire [3:0] writeAddressR,  // 1-bit write address
    input wire [1:0] writeAddressC,  // 1-bit write address
    input wire [127:0] writeData,     // 4-bit data to write
    input wire [3:0] readAddress1,   // 1-bit read address
    input wire [3:0] readAddress2,   // 1-bit read address
    output wire [127:0] readData1,      // 4-bit data read from the selected register
    output wire [127:0] readData2      // 4-bit data read from the selected register
);
integer i;
reg [127:0] registers [0:15];    // 4 4-bit registers

initial begin

    for (i = 0 ;i < 16; i = i + 1) begin
        registers[i] <= 127'b0;
    end

    // registers[0] <= 0;
    // registers[1] <= 1;
    // registers[2] <= 2;

end


always @(posedge reset) begin
    for (i = 0 ;i < 16; i = i + 1) begin
        registers[i] <= 127'b0;
    end
end

// write data
always @(posedge clk) begin
    if (writeEnable) begin
        // registers[writeAddress] <= writeData;
        

        if(mem_load_enable)begin

            // if data should be store from memory
            case (writeAddressC)
                2'b00:begin
                    registers[writeAddressR][31:0] = writeData[31:0];
                end 

                2'b01:begin
                    registers[writeAddressR][63:32] = writeData[31:0];
                end 

                2'b10:begin
                    registers[writeAddressR][95:64] = writeData[31:0];
                end 

                2'b11:begin
                    registers[writeAddressR][127:96] = writeData[31:0];
                end 
            endcase

        end else begin

            registers[writeAddressR] = writeData; // if result should be store 

        end


    end
end

// read data
assign readData1 = registers[readAddress1];
assign readData2 = registers[readAddress2];

endmodule
