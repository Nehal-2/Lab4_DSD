`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2024 06:49:21 PM
// Design Name: 
// Module Name: tb_d_flipflop
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

module tb_d_flipflop;
    logic clk;
    logic data;
    logic arst;
    logic qm;
    logic qs;
    
    d_flipflop dut(
        .d(data),
        .en(clk),
        .areset(arst),
        .qm(qm),
        .qs(qs) 
    );
    
    // Generate clock signal
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle clock every 5 time units
    end
    
    // Reset Test - Assert that both qm and qs should be 0 when reset is active
    initial begin
        arst = 0;
        #10;
        assert(qm == 0 && qs == 0) else $fatal("Reset failed at time %0t: qm=%b, qs=%b", $time, qm, qs);
    end
    
    // Apply stimulus
    initial begin
        $display("Time   | Reset | Clock | Data | Master (qm) | Slave (qs)");
        $display("---------------------------------------------------------");
        
        // Test case 1: Reset active (areset = 0), output should be 0
        arst = 0;  // Active low reset
        data = 0;  // Initial data value
        #10;       // Wait 10 time units
        $display("%0t   |   %b    |   %b   |  %b   |      %b      |      %b", $time, arst, clk, data, qm, qs);

        // Deactivate reset and change data
        arst = 1;
        data = 1;  // Set data to 1
        #10;       // Wait 10 time units for data propagation
        $display("%0t   |   %b    |   %b   |  %b   |      %b      |      %b", $time, arst, clk, data, qm, qs);

        // Test case 2: Data changes, latch follows data
        @(posedge clk) begin
            data = 0;
            $display("%0t   |   %b    |   %b   |  %b   |      %b      |      %b", $time, arst, clk, data, qm, qs);
        end
        @(posedge clk) begin
            data = 1;
            $display("%0t   |   %b    |   %b   |  %b   |      %b      |      %b", $time, arst, clk, data, qm, qs);
        end

        // Test case 3: Enable = 0, latch holds its value
        @(posedge clk) begin
            data = 0;
            $display("%0t   |   %b    |   %b   |  %b   |      %b      |      %b", $time, arst, clk, data, qm, qs);
        end
        @(posedge clk) begin
            data = 1;
            $display("%0t   |   %b    |   %b   |  %b   |      %b      |      %b", $time, arst, clk, data, qm, qs);
        end

        // Test case 4: Simulate noisy input (rapid changes)
        @(posedge clk) data = ~data; #2; // Toggle data rapidly
        @(posedge clk) data = ~data; #2; // Toggle back quickly
        $display("%0t   |   %b    |   %b   |  %b   |      %b      |      %b", $time, arst, clk, data, qm, qs);

        // Test case 5: Reactivate reset (areset = 0) during normal operation
        arst = 0; #10;  // Reactivate reset
        $display("%0t   |   %b    |   %b   |  %b   |      %b      |      %b", $time, arst, clk, data, qm, qs);

        arst = 1;  // Deactivate reset
        #10;
        $display("%0t   |   %b    |   %b   |  %b   |      %b      |      %b", $time, arst, clk, data, qm, qs);

        // Test case 6: Reactivate reset (areset = 0) again to see reset behavior
        arst = 0; #10;
        $display("%0t   |   %b    |   %b   |  %b   |      %b      |      %b", $time, arst, clk, data, qm, qs);

        arst = 1;  // Deactivate reset
        #10;
        $display("%0t   |   %b    |   %b   |  %b   |      %b      |      %b", $time, arst, clk, data, qm, qs);
        
        $finish;  // End simulation
    end
endmodule
