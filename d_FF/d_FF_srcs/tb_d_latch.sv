`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2024 04:45:23 PM
// Design Name: 
// Module Name: tb_d_latch
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


module tb_d_latch;
    logic clk;
    logic areset;
    logic en;
    logic d;
    logic q;
    
    d_latch_asynch dut (
        .clk(clk),
        .areset(areset),
        .en(en),
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
        $display("                Time   | Reset | Enable |   Data    | Output");
        $display("             ------------------------------------------------------------");
        $monitor("%t   |   %b   |    %b   |    %b   |      %b", $time, areset, en, d, q);
        
        // Initialize
        areset = 0; en = 0; d = 0; #10
        
        // Test cases
        areset = 1; en = 1;
        d = 1; #10
        d = 0; #10
        areset = 0; #10
        areset = 1; #5
        d = 1; #2 d = 0; #2 d = 1; #2 d = 0; #10
        d = 1; #10
        d = 0; #10
        
        $finish;
    end

endmodule
