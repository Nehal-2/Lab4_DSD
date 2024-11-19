`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2024 04:56:46 PM
// Design Name: 
// Module Name: multiplier_8bit
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


module multiplier_8bit(
        input logic clk,
        input logic start,
        input logic areset,
        input logic [7:0] x,
        input logic [7:0] y,
        output logic [15:0] result

    );
    
    logic [7:0] q_x, q_y;
    logic [15:0] current_result;
    logic en_result;
    logic [7:0] count;
    logic en_counter;
    
    register_nbit #(.n(8)) x_reg(
        .clk(clk),
        .areset(areset),
        .en(start),
        .d(x),
        .q(q_x) 
    );
    
    register_nbit #(.n(8)) y_reg(
        .clk(clk),
        .areset(areset),
        .en(start),
        .d(y),
        .q(q_y) 
    );
    
    nbit_counter #(.n(8)) counter_inst (
        .clk(clk),
        .areset(areset),
        .en(en_counter),
        .load(0),
        .up_down(0),
        .d(8'b0),
        .q(count)
    );
    
    register_nbit #(.n(16)) result_reg(
        .clk(clk),
        .areset(areset),
        .en(en_result),
        .d(current_result),
        .q(result) 
    );
    
    always @(negedge clk, negedge areset)
    begin
        if (!areset) begin
            current_result <= 16'b0;
            en_counter <= 1'b0;
            en_result <= 1'b0;
        end
        else if (start) begin
            current_result <= 16'b0;
            en_counter <= 1'b1;
            en_result <= 1'b1;
        end
        else if (en_counter) begin
            if (count < q_y) 
                current_result <=  current_result + {8'b0, q_x}; 
            if (count == q_y) begin
                en_counter <= 1'b0;
                en_result <= 1'b0;
            end
        end      
    end 
    
endmodule
