`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2024 01:37:49 PM
// Design Name: 
// Module Name: tb_register_4bit
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


module tb_register_4bit;
    logic clk;
    logic arst;
    logic en;
    logic [3:0] d;
    logic [3:0] q;
    
    register_4bit reg_inst(
        .clk(clk),
        .areset(arst),
        .en(en),
        .d(d),
        .q(q) 
    ); 
    
// Generate clock signal
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle clock every 5 time units
    end

    // Apply stimulus
    initial begin
        $display("Time   | Reset | Enable | Data   | Output (q)");
        $display("---------------------------------------------");

        // Test case 1: Reset active (areset = 0), output should be 0
        arst = 0; en = 0; d = 4'b0000; #5;
        $display("%0t    |   %b   |    %b   |  %b  |    %b", $time, arst, en, d, q);

        arst = 0; en = 1; d = 4'b1111; #10;
        $display("%0t    |   %b   |    %b   |  %b  |    %b", $time, arst, en, d, q);

        // Test case 2: Deactivate reset (areset = 1)
        arst = 1; en = 1; d = 4'b1010; #10;
        $display("%0t    |   %b   |    %b   |  %b  |    %b", $time, arst, en, d, q);

        // Test case 3: Enable active, data changes
        @(posedge clk) begin
            d = 4'b0101;
            $display("%0t    |   %b   |    %b   |  %b  |    %b", $time, arst, en, d, q);
        end
        @(posedge clk) begin
            d = 4'b1100;
            $display("%0t    |   %b   |    %b   |  %b  |    %b", $time, arst, en, d, q);
        end

        // Test case 4: Enable = 0, latch holds its value
        @(posedge clk) begin
            en = 0;
            d = 4'b0011;
            $display("%0t    |   %b   |    %b   |  %b  |    %b", $time, arst, en, d, q);
        end

        // Test case 5: Simulate noisy input (rapid changes)
        @(posedge clk) d = 4'b1010; #2;
        @(posedge clk) d = 4'b0101; #2;
        $display("%0t    |   %b   |    %b   |  %b  |    %b", $time, arst, en, d, q);

        // Test case 6: Reactivate reset during normal operation
        arst = 0; #10;  // Reset active
        $display("%0t    |   %b   |    %b   |  %b  |    %b", $time, arst, en, d, q);

        arst = 1; #10;  // Reset deactivated
        $display("%0t    |   %b   |    %b   |  %b  |    %b", $time, arst, en, d, q);

        $finish;  // End simulation
        
    end 
endmodule
