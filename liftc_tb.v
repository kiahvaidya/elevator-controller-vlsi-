`timescale 1ns / 1ps
module LiftC_Tb;
    reg clk, reset;
    reg [6:0] req_floor;
    wire door, Up, Down, stop;
    wire [6:0] y;

    // Instantiate the DUT (Design Under Test)
    LiftC dut(
        .clk(clk),
        .reset(reset),
        .req_floor(req_floor),
        .door(door),
        .Up(Up),
        .Down(Down),
        .stop(stop),
        .y(y)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize
        reset = 1;
        req_floor = 0;
        
        // Release reset
        #10 reset = 0;

        // Move to floor 25
        req_floor = 7'd25;
        #600;

        // Move to floor 3
        req_floor = 7'd3;
        #400;

        // Move to floor 37
        req_floor = 7'd37;
        #600;

        // Move to floor 10
        req_floor = 7'd10;
        #400;

        // End simulation
        $finish;
    end

    // Display output in terminal
    initial begin
        $monitor("Time=%0t | reset=%b | req_floor=%0d | current_floor=%0d | Up=%b | Down=%b | stop=%b | door=%b",
                 $time, reset, req_floor, y, Up, Down, stop, door);
    end
endmodule
