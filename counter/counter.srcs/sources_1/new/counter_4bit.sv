`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2024 05:30:37 PM
// Design Name: 
// Module Name: counter_4bit
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


module counter_4bit(
        input logic clk,
        input logic areset,
        input logic en,
        output logic [3:0] q 
        
    );
    logic d0, d1, d2, d3;
    
    assign d0 = ~q[0];
    assign d1 = q[0] ^q[1];
    assign d2 = (q[2] & ~q[0]) | (q[2] & ~q[1]) | (~q[2] & q[1] & q[0]);
    assign d3 = q[3] | (q[2] & q[1] & q[0]);
    
    d_flipflop FF0(.clk(clk), .en(en), .d(d0), .areset(areset), .qs(q[0])); 
    d_flipflop FF1(.clk(clk), .en(en), .d(d1), .areset(areset), .qs(q[1])); 
    d_flipflop FF2(.clk(clk), .en(en), .d(d2), .areset(areset), .qs(q[2])); 
    d_flipflop FF3(.clk(clk), .en(en), .d(d3), .areset(areset), .qs(q[3]));

endmodule
