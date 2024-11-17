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
        input logic d,
        input logic en,
        input logic areset,
        output logic q );
        
        logic r, q1, q2, q_;
        
        assign r = ~d;
        assign q1 = ~(d & en & areset);
        assign q2 = ~(en & r);
        assign q = ~(q1 & q_);
        assign q_ = ~(q2 & q & areset);
        
        /*
        assign r = ~d;
        assign q1 = ~(d & en);
        assign q2 = ~(en & r);
        assign qp = ~(q1 & q_);
        assign q_ = ~(q2 & q);
        assign q = areset & qp;
        */
endmodule
