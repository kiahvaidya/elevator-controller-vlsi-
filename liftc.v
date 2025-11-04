`timescale 1ns / 1ps
module LiftC(
    input clk, reset,
    input [6:0] req_floor,
    output reg door, Up, Down, stop,
    output [6:0] y
);
    reg [6:0] cf; // current floor

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            cf   <= 7'd0;
            stop <= 1'b1;
            door <= 1'b1;
            Up   <= 1'b0;
            Down <= 1'b0;
        end else begin
            if (req_floor < cf) begin
                cf   <= cf - 1;
                door <= 1'b0;
                stop <= 1'b0;
                Up   <= 1'b0;
                Down <= 1'b1;
            end else if (req_floor > cf) begin
                cf   <= cf + 1;
                door <= 1'b0;
                stop <= 1'b0;
                Up   <= 1'b1;
                Down <= 1'b0;
            end else begin
                cf   <= req_floor;
                door <= 1'b1;
                stop <= 1'b1;
                Up   <= 1'b0;
                Down <= 1'b0;
            end
        end
    end

    assign y = cf;
endmodule
