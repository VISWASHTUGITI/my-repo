`timescale 1ns/1ps

module sys_array_tb;

    // Inputs (Adjusted to 4-bit as per your RTL)
    reg [3:0] inp_west0, inp_west4, inp_west8, inp_west12;
    reg [3:0] inp_north0, inp_north1, inp_north2, inp_north3;
    reg clk, rst;

    // Outputs
    wire done;
    wire [9:0] C0,  C1,  C2,  C3,  C4,  C5,  C6,  C7;
    wire [9:0] C8,  C9,  C10, C11, C12, C13, C14, C15;

    // Unit Under Test (UUT) - Using Named Port Mapping for safety
    systolic_array uut (
        .inp_west0(inp_west0),   .inp_west4(inp_west4),   .inp_west8(inp_west8),   .inp_west12(inp_west12),
        .inp_north0(inp_north0), .inp_north1(inp_north1), .inp_north2(inp_north2), .inp_north3(inp_north3),
        .clk(clk), .rst(rst), .done(done),
        .C0(C0),   .C1(C1),   .C2(C2),   .C3(C3),
        .C4(C4),   .C5(C5),   .C6(C6),   .C7(C7),
        .C8(C8),   .C9(C9),   .C10(C10), .C11(C11),
        .C12(C12), .C13(C13), .C14(C14), .C15(C15)
    );

    // --- Data Stream: West0 & North0 (Top-Left Start) ---
    initial begin
        inp_west0 = 0; inp_north0 = 0;
        #13 inp_west0 = 4'd3;  inp_north0 = 4'd12;
        #10 inp_west0 = 4'd2;  inp_north0 = 4'd8;
        #10 inp_west0 = 4'd1;  inp_north0 = 4'd4;
        #10 inp_west0 = 4'd0;  inp_north0 = 4'd0;
    end

    // --- Data Stream: West4 & North1 (1 Cycle Delay) ---
    initial begin
        inp_west4 = 0; inp_north1 = 0;
        #23 inp_west4 = 4'd7;  inp_north1 = 4'd13;
        #10 inp_west4 = 4'd6;  inp_north1 = 4'd9;
        #10 inp_west4 = 4'd5;  inp_north1 = 4'd5;
        #10 inp_west4 = 4'd4;  inp_north1 = 4'd1;
        #10 inp_west4 = 4'd0;  inp_north1 = 4'd0;
    end

    // --- Data Stream: West8 & North2 (2 Cycle Delay) ---
    initial begin
        inp_west8 = 0; inp_north2 = 0;
        #33 inp_west8 = 4'd11; inp_north2 = 4'd14;
        #10 inp_west8 = 4'd10; inp_north2 = 4'd10;
        #10 inp_west8 = 4'd9;  inp_north2 = 4'd6;
        #10 inp_west8 = 4'd8;  inp_north2 = 4'd2;
        #10 inp_west8 = 4'd0;  inp_north2 = 4'd0;
    end

    // --- Data Stream: West12 & North3 (3 Cycle Delay) ---
    initial begin
        inp_west12 = 0; inp_north3 = 0;
        #43 inp_west12 = 4'd15; inp_north3 = 4'd15;
        #10 inp_west12 = 4'd14; inp_north3 = 4'd11;
        #10 inp_west12 = 4'd13; inp_north3 = 4'd7;
        #10 inp_west12 = 4'd12; inp_north3 = 4'd3;
        #10 inp_west12 = 4'd0;  inp_north3 = 4'd0;
    end

    // --- Clock and Reset ---
    initial begin
        rst = 1;
        clk = 0;
        #13 rst = 0; 
    end

    always #5 clk = ~clk; // 10ns period

    // --- Monitoring & Cleanup ---
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, sys_array_tb);
        
        // Wait for the 'done' signal logic to complete
        wait(done);
        #20;
        $display("--- Simulation Complete ---");
        $display("C0 Final: %d", C0);
        $display("C15 Final: %d", C15);
        $finish;
    end

endmodule
