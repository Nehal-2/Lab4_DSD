`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
 
// Create Date: 11/18/2024 05:30:37 PM
// Design Name: 
// Module Name: counter_4bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
 
// Dependencies: 
 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
 
//////////////////////////////////////////////////////////////////////////////////

// Data flow modeling:

module counter_4bit(
        input logic clk,
        input logic areset,
        input logic en,
        input logic load,
        input logic up_down,
        input logic [3:0] d,
        output logic [3:0] q 
        
    );
    logic enable;
    assign enable = en | load;
    
    logic d0, d1, d2, d3;
    
    assign d0 = (load) ? d[0] : ~q[0];
    assign d1 = (load) ? d[1] : (up_down) ? ~(q[0] ^ q[1]) : q[0] ^q[1];
    assign d2 = (load) ? d[2] : (up_down) ? (~q[2] & ~q[1] & ~q[0]) | (q[2] & q[0]) | (q[2] & q[1]) : (q[2] & ~q[0]) | (q[2] & ~q[1]) | (~q[2] & q[1] & q[0]);
    assign d3 = (load) ? d[3] : (up_down) ? (~q[3] & ~q[2] & ~q[1] & ~q[0]) | (q[3] & q[2] & ~q[0]) | (q[3] & q[0]) | (q[3] & q[1]) : (q[3] & ~q[1]) | (q[3] & ~q[0]) | (q[3] & ~q[2] & q[0]) | (~q[3] & q[2] & q[1] & q[0]);
    
    d_flipflop FF0(.clk(clk), .en(enable), .d(d0), .areset(areset), .qs(q[0])); 
    d_flipflop FF1(.clk(clk), .en(enable), .d(d1), .areset(areset), .qs(q[1])); 
    d_flipflop FF2(.clk(clk), .en(enable), .d(d2), .areset(areset), .qs(q[2])); 
    d_flipflop FF3(.clk(clk), .en(enable), .d(d3), .areset(areset), .qs(q[3]));

endmodule

// Behavioral modeling:

//module counter_4bit(
//        input logic clk,
//        input logic areset,
//        input logic en,
//        input logic load,
//        input logic up_down, // down count if high
//        input logic [3:0] d,
//        output logic [3:0] q 
        
//    );
    
//    logic [3:0] next_q;
    
//    always @(*)
//    begin
//        if (load)
//            next_q = d;
//        else if (en) begin
//            if (up_down)
//                next_q = q - 1;
//            else 
//                next_q = q + 1;
//        end else
//            next_q = q; // Hold if enable is low
//    end
    
//    d_flipflop FF0(.clk(clk), .en(en | load), .d(next_q[0]), .areset(areset), .qs(q[0])); 
//    d_flipflop FF1(.clk(clk), .en(en | load), .d(next_q[1]), .areset(areset), .qs(q[1])); 
//    d_flipflop FF2(.clk(clk), .en(en | load), .d(next_q[2]), .areset(areset), .qs(q[2])); 
//    d_flipflop FF3(.clk(clk), .en(en | load), .d(next_q[3]), .areset(areset), .qs(q[3]));
    
//endmodule