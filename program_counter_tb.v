module program_counter_TB();

reg clk;
reg reset;
// reg pause;
reg vector;
reg [1:0] offset;
reg jump_enable;

reg [7:0] jump_address;
wire [7:0] address;


program_counter uut(
    .clk(clk),
    .reset(reset),
    // .pause(pause),
    .vector(vector),
    .offset(offset),
    .jump_enable(jump_enable),
    .jump_address(jump_address),
    .address(address)

);

always @(posedge clk) begin

    $display("clk = %b", clk);
    $display("Reset = %b", reset);
    $display("Vector = %b", vector);
    $display("Offset = %b", offset);
    // $display("Pause = %b", pause);

    $display("Counter Value = %d\n", address);
    
end

initial begin
    clk = 0;
    reset = 0;
    // pause = 0;
    vector = 1;
    offset = 2'b0;
    jump_enable = 0;
    jump_address = 8'b0;


    // output = 0, but not show;

    #10;

    // output = 1;

    #10;

    // output = 2;

    #10;

    // output = 3;

    jump_enable = 1;
    jump_address = 8'b10100;

    #10;

    // output = 15;

    jump_enable = 0;



    #10;

    // pause = 1;
    vector = 0;

    // output = 16;

    #10;

    offset = 2'b01;


    #10;

    offset = 2'b10;

    #10;

    offset = 2'b11;

    #10;


    offset = 2'b00;
    vector = 1;

    #10;


    #10;


    #10;





    $finish;
end

always begin
    #5 clk = ~clk;
end

endmodule