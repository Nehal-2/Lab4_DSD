`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2024 06:12:41 PM
// Design Name: 
// Module Name: tb_multiplier_8bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_multiplier_8bit;

    logic clk;
    logic start;
    logic areset;
    logic [7:0] x;
    logic [7:0] y;
    logic [15:0] result;

    multiplier_8bit dut (
        .clk(clk),
        .start(start),
        .areset(areset),
        .x(x),
        .y(y),
        .result(result)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Clock period = 10 time units
    end
    
    // The default simulation time may not be enough to complete the operation
    // Press Run All (F3) to continue running the simulation
    
    // Test sequence
    initial begin
        // Initialize
        clk = 0;
        start = 0;
        areset = 0;
        x = 0;
        y = 0;
        
        $display("                Time   | Reset | Start | x      | y      | Result");
        $display("                --------------------------------------------------");
        $display("%t |   %b   |   %b   | %d | %d | %d", 
                 $time, areset, start, x, y, result);
                 

        // Random test case 1
        areset = 0; start = 0; 
        #10 x = $random % 256; 
            y = $random % 256;
        areset = 1; start = 1; #10;
        start = 0;

        // Wait for operation to complete
        #((y + 1) * 10); // Wait y + 1 cycles for completion
        $display("%t |   %b   |   %b   | %d | %d | %d", 
                 $time, areset, start, x, y, result);
        
        // Reset
        #10 areset = 0;

        // Random test case 2
        areset = 0; start = 0;
        #10 x = $random % 256; 
            y = $random % 256;
        areset = 1; start = 1; #10;
        start = 0;

        // Wait for operation to complete
        #((y + 1) * 10); // Wait y + 1 cycles for completion
        $display("%t |   %b   |   %b   | %d | %d | %d", 
                 $time, areset, start, x, y, result);
                 
        // Random test case 3
        areset = 0; start = 0; 
        #10 x = $random % 256; 
            y = $random % 256;
        areset = 1; start = 1; #10;
        start = 0;

        // Wait for operation to complete
        #((y + 1) * 10); // Wait y + 1 cycles for completion
        $display("%t |   %b   |   %b   | %d | %d | %d", 
                 $time, areset, start, x, y, result);
                 
        // Test case 4: maximum inputs
        areset = 0; start = 0; 
        #10 x = 8'b1111_1111; 
            y = 8'b1111_1111;
        areset = 1; start = 1; #10;
        start = 0;

        // Wait for operation to complete
        #((y + 1) * 10); // Wait y + 1 cycles for completion
        $display("%t |   %b   |   %b   | %d | %d | %d", 
                 $time, areset, start, x, y, result);
        
        // Finish
        #20 $finish;

    end

endmodule




