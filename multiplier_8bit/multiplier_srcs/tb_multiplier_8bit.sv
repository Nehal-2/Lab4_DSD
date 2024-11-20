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
    
    // The default simulation time was adjusted to 5000ns to allow time for computations
    // set_property -name {xsim.simulate.runtime} -value {5000ns} -objects [get_filesets sim_1]
    
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
                 
        // Test using random numbers with custom time allocations

//        // Reset
//        #10 areset = 0;

//        // Random test case 1
//        #10 x = $random % 256; 
//            y = $random % 256;
//            start = 1; // Start multiplication
//        #10 start = 0;

//        // Wait for operation to complete
//        #((y + 1) * 10); // Wait y + 1 cycles for completion
//        $display("%t |   %b   |   %b   | %d | %d | %d", 
//                 $time, areset, start, x, y, result);
        
//        // Reset
//        #10 areset = 0;

//        // Random test case 2
//        #10 x = $random % 256; 
//            y = $random % 256;
//            start = 1; // Start multiplication
//        #10 start = 0;

//        // Wait for operation to complete
//        #((y + 1) * 10); // Wait y + 1 cycles for completion
//        $display("%t |   %b   |   %b   | %d | %d | %d", 
//                 $time, areset, start, x, y, result);

//        // Finish
//        #20 $finish;

        // Test 1: Multiply 10 * 4
        areset = 0; start = 0; x = 8'd10; y = 8'd4; #10;
        areset = 1; start = 1; #10;  // Assert start
        start = 0; #100;  // Allow time for operation to complete
        $display("%t |   %b   |   %b   | %d | %d | %d", 
                 $time, areset, start, x, y, result);

        // Test 2: Multiply 7 * 8
        areset = 0; start = 0; x = 8'd7; y = 8'd8; #10;
        areset = 1; start = 1; #10;
        start = 0; #100;
        $display("%t |   %b   |   %b   | %d | %d | %d", 
                 $time, areset, start, x, y, result);
                 
        // Reset
        #10 areset = 0;

        // Test 3: Multiply 15 * 15
        areset = 0; start = 0; x = 8'd15; y = 8'd15; #10;
        areset = 1; start = 1; #10;
        start = 0; #1000;
        $display("%t |   %b   |   %b   | %d | %d | %d", 
                 $time, areset, start, x, y, result);
                 
        // Test 4: Multiply 30 * 30
        areset = 0; start = 0; x = 8'd30; y = 8'd30; #10;
        areset = 1; start = 1; #10;
        start = 0; #2000;
        $display("%t |   %b   |   %b   | %d | %d | %d", 
                 $time, areset, start, x, y, result);

        $finish;
    end

endmodule




