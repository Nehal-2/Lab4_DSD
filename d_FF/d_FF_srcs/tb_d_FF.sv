`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2024 05:05:51 PM
// Design Name: 
// Module Name: tb_d_FF
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


module tb_d_FF;
    logic clk;
    logic areset;
    logic en;
    logic d;
    logic qm;
    logic qs;
    
    d_flipflop dut(
        .clk(clk),
        .areset(areset),
        .en(en),
        .d(d),
        .qm(qm),
        .qs(qs)
        
        );
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 time units clock period
    end
    
    // Test sequence
    initial begin
        $display("                Time   | Reset | Enable |   Data    | Master (Qm) | Slave (Qs)");
        $display("             ------------------------------------------------------------");
        $monitor("%t   |   %b   |    %b   |    %b   |      %b    |      %b   ", $time, areset, en, d, qm, qs);
        
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
