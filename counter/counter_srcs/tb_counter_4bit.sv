`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2024 06:14:12 PM
// Design Name: 
// Module Name: tb_counter_4bit
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


module tb_counter_4bit;
    logic clk;
    logic areset;
    logic en;
    logic up_down;
    logic load;
    logic [3:0] d;
    logic [3:0] q;

    counter_4bit dut (
        .clk(clk),
        .areset(areset),
        .en(en),
        .load(load),
        .up_down(up_down),
        .d(d),
        .q(q)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 time units clock period
    end

    // Test sequence
    initial begin
        $display("                Time   | Reset | Enable | Load     |   Data    | Counter Output");
        $display("             ------------------------------------------------------------");
        $monitor("%t   |   %b   |    %b   |    %b   |   %b   |      %b", $time, areset, en, load, d, q);
        
        // Testing up count:
        // Initialize
        areset = 0; en = 0; load = 0; up_down = 0; #10;

        // Test: Release reset, enable counter
        areset = 1; en = 1; #50;
        
        // Test: Load data to counter
        load = 1; d = 4'b0111; #10;
        load = 0; #30;

        // Test: Disable enable, counter holds value
        en = 0; #20;

        // Test: Enable counter again
        en = 1; #60;
        
        // Test: Load data while En = 0
        en = 0; load = 1; d = 4'b0011; #10;
        load = 0; en = 1; #30;
        
        // Test: Reactivate reset during operation
        areset = 0; #10;

        areset = 1; #10;
        
        
        // Testing down count:
        
        // Test: Reset active
        areset = 0; en = 0; load = 0; up_down = 1; #10;

        // Test: Release reset, enable counter
        areset = 1; en = 1; #60;
        
        // Test: Load data to counter
        load = 1; d = 4'b0111; #10;
        load = 0; #30;

        // Test: Disable enable, counter holds value
        en = 0; #20;

        // Test: Enable counter again
        en = 1; #50;
        
        // Test: Load data while En = 0
        en = 0; load = 1; d = 4'b0011; #10;
        load = 0; en = 1; #30;
        
        // Test: Reactivate reset during operation
        areset = 0; #10;

        areset = 1; #10;

        $finish;
    end
endmodule

