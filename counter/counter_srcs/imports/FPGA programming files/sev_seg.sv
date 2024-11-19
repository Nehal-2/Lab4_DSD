module nbit_counter_top(
    input wire CLK100MHZ,    // using the same name as pin names
    input wire CPU_RESETN,    
    input wire BTNC,
    output wire CA, CB, CC, CD, CE, CF, CG, DP,
    output wire [7:0] AN,    
    input wire [15:0] SW     
);


logic reset_n;
logic clk;

assign reset_n = CPU_RESETN;
assign clk = CLK100MHZ;


// Seven segments Controller
wire [6:0] Seg;
wire [3:0] digits[0:7];

logic [7:0] q;

nbit_counter #(.n(8)) counter_inst (
        .clk(BTNC),
        .areset(CPU_RESETN),
        .en(SW[8]),
        .load(SW[9]),
        .up_down(SW[10]),
        .d(SW[7:0]),
        .q(q)
    );

assign digits[0] = q[3:0];
assign digits[1] = q[7:4];
assign digits[2] = 4'b1111;
assign digits[3] = 4'b1111;
assign digits[4] = 4'b1111;
assign digits[5] = 4'b1111;
assign digits[6] = 4'b1111;
assign digits[7] = 4'b1111;


sev_seg_controller ssc(
    .clk(clk),
    .resetn(reset_n),
    .digits(digits),
    .Seg(Seg),
    .AN(AN)
);


assign CA = Seg[0];
assign CB = Seg[1];
assign CC = Seg[2];
assign CD = Seg[3];
assign CE = Seg[4];
assign CF = Seg[5];
assign CG = Seg[6];
assign DP = 1'b1; // turn off the dot point on seven segs


endmodule : nbit_counter_top