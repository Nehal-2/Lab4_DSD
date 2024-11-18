`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2024 01:06:06 PM
// Design Name: 
// Module Name: register_4bit
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


module register_4bit(
        input logic clk,
        input logic areset,
        input logic en,
        input logic [3:0] d,
        output logic [3:0] q 
        
    );
    
    d_flipflop FF0(.clk(clk), .en(en), .d(d[0]), .areset(areset), .qs(q[0])); 
    d_flipflop FF1(.clk(clk), .en(en), .d(d[1]), .areset(areset), .qs(q[1])); 
    d_flipflop FF2(.clk(clk), .en(en), .d(d[2]), .areset(areset), .qs(q[2])); 
    d_flipflop FF3(.clk(clk), .en(en), .d(d[3]), .areset(areset), .qs(q[3]));

endmodule

//Behavioural modeling:

//module register_4bit(
//        input logic clk,
//        input logic areset,
//        input logic en,
//        input logic [3:0] d,
//        output logic [3:0] q 
        
//    );
    
//    always_ff @(negedge clk, negedge areset) begin
//    if (~areset) 
//        q <= 4'b0000;
//    else if (en)
//        q <= d; 
    
//    end

//endmodule
