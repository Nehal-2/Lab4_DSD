`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2024 06:39:40 PM
// Design Name: 
// Module Name: d_flipflop
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


module d_flipflop(
        input logic d,
        input logic en,
        input logic areset,
        output logic qm,
        output logic qs

    );
    
    d_latch_asynch master(.d(d), .en(en), .areset(areset), .q(qm));
    d_latch_asynch slave(.d(qm), .en(~en), .areset(areset), .q(qs));
    
endmodule
