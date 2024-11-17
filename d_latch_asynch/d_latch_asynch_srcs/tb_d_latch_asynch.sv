`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2024 03:10:05 PM
// Design Name: 
// Module Name: tb_d_latch_asynch
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


module tb_d_latch_asynch;
    logic clk;
    logic data;
    logic arst;
    logic q;
    
    d_latch_asynch dut(
        .d(data),
        .en(clk),
        .areset(arst),
        .q(q) 
    );
    initial begin
        clk = 0;
        repeat (50) #5 clk = ~clk;
    end
    
    initial begin
        $display("Time   | Reset | Enable | Data | Output (q)");
        $display("-------------------------------------------------");
        // Test case 1: Reset active (areset = 0), output should be 0
        arst = 0; data = 0; #10;
        $display("%0t       |   %b    |    %b    |  %b   |     %b", $time, arst, clk, data, q);

        arst = 0; data = 1; #10;
        $display("%0t       |   %b    |    %b    |  %b   |     %b", $time, arst, clk, data, q);

        // Deactivate reset (areset = 1) 
        arst = 1;

        // Test case 2: Enable = 1, Data changes, latch follows data
        data = 0; #10;
        $display("%0t       |   %b    |    %b    |  %b   |     %b", $time, arst, clk, data, q);

        data = 1; #10;
        $display("%0t       |   %b    |    %b    |  %b   |     %b", $time, arst, clk, data, q);

        // Test case 3: Enable = 0, latch holds its value
        #10 clk = 0; data = 0; #10;
        $display("%0t       |   %b    |    %b    |  %b   |     %b", $time, arst, clk, data, q);

        #10 clk = 0; data = 1; #10;
        $display("%0t       |   %b    |    %b    |  %b   |     %b", $time, arst, clk, data, q);

        // Test case 4: Toggle enable, test edge behavior
        #10 clk = 1; data = 1; #10;
        $display("%0t       |   %b    |    %b    |  %b   |     %b", $time, arst, clk, data, q);

        #10 clk = 0; data = 0; #10;
        $display("%0t       |   %b    |    %b    |  %b   |     %b", $time, arst, clk, data, q);

        // Test case 5: Simulate noisy input (rapid changes)
        #2 data = 1; #2 data = 0; #2 data = 1; #2 data = 0; #10;
        $display("%0t       |   %b    |    %b    |  %b   |     %b", $time, arst, clk, data, q);

        // Test case 6: Reactivate reset (areset = 0) during normal operation
        arst = 0; #10;
        $display("%0t       |   %b    |    %b    |  %b   |     %b", $time, arst, clk, data, q);

        arst = 1; #10; // Deactivate reset
        $display("%0t       |   %b    |    %b    |  %b   |     %b", $time, arst, clk, data, q);
        
            
        $finish;
    
    end
    
endmodule
