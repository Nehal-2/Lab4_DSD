`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2024 02:39:46 PM
// Design Name: 
// Module Name: d_latch_asynch
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


module d_latch_asynch(
        input logic clk,
        input logic areset,
        input logic en,
        input logic d,
        output logic q
        
        );
        
        logic r, q1, q2, q_;
        logic enable;
        
        assign enable = en & clk;
        
        assign r = ~d;
        assign q1 = ~(d & enable & areset);
        assign q2 = ~(enable & r);
        assign q = ~(q1 & q_);
        assign q_ = ~(q2 & q & areset);
        
endmodule
