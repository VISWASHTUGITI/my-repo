module systolic_array(
    input  [3:0] inp_west0, inp_west4, inp_west8, inp_west12,
    input  [3:0] inp_north0, inp_north1, inp_north2, inp_north3,
    input clk,
    input rst,
    output done,

    output [9:0] C0,  C1,  C2,  C3,
    output [9:0] C4,  C5,  C6,  C7,
    output [9:0] C8,  C9,  C10, C11,
    output [9:0] C12, C13, C14, C15
);


// ================= INTERNAL WIRES =================

// South wires
wire [3:0] south0, south1, south2, south3;
wire [3:0] south4, south5, south6, south7;
wire [3:0] south8, south9, south10, south11;
wire [3:0] south12, south13, south14, south15;

// East wires
wire [3:0] east0, east1, east2, east3;
wire [3:0] east4, east5, east6, east7;
wire [3:0] east8, east9, east10, east11;
wire [3:0] east12, east13, east14, east15;

// Result wires
wire [9:0] result0, result1, result2, result3;
wire [9:0] result4, result5, result6, result7;
wire [9:0] result8, result9, result10, result11;
wire [9:0] result12, result13, result14, result15;
  

// ================= DONE LOGIC =================
  
reg [3:0] count;
reg done_reg;
assign done = done_reg;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        count    <= 4'd0;
        done_reg <= 1'b0;
    end else begin
        if (count == 4'd9) begin
            done_reg <= 1'b1;
            count    <= 4'd0;
        end else begin
            count    <= count + 1'b1;
            done_reg <= 1'b0;
        end
    end
end


// ================= ROW 0 =================
block P0  (inp_north0, inp_west0, clk, rst, south0,  east0,  result0);
block P1  (inp_north1, east0,     clk, rst, south1,  east1,  result1);
block P2  (inp_north2, east1,     clk, rst, south2,  east2,  result2);
block P3  (inp_north3, east2,     clk, rst, south3,  east3,  result3);

// ================= ROW 1 =================
block P4  (south0, inp_west4, clk, rst, south4,  east4,  result4);
block P5  (south1, east4,     clk, rst, south5,  east5,  result5);
block P6  (south2, east5,     clk, rst, south6,  east6,  result6);
block P7  (south3, east6,     clk, rst, south7,  east7,  result7);

// ================= ROW 2 =================
block P8  (south4, inp_west8, clk, rst, south8,  east8,  result8);
block P9  (south5, east8,     clk, rst, south9,  east9,  result9);
block P10 (south6, east9,     clk, rst, south10, east10, result10);
block P11 (south7, east10,    clk, rst, south11, east11, result11);

// ================= ROW 3 =================
block P12 (south8,  inp_west12, clk, rst, south12, east12, result12);
block P13 (south9,  east12,     clk, rst, south13, east13, result13);
block P14 (south10, east13,     clk, rst, south14, east14, result14);
block P15 (south11, east14,     clk, rst, south15, east15, result15);


// ================= OUTPUT CONNECTIONS =================
assign C0  = result0;
assign C1  = result1;  
assign C2  = result2;   
assign C3  = result3;  
assign C4  = result4;   
assign C5  = result5;
assign C6  = result6;
assign C7  = result7;  
assign C8  = result8;
assign C9  = result9;
assign C10 = result10;
assign C11 = result11;  
assign C12 = result12;
assign C13 = result13;
assign C14 = result14;  
assign C15 = result15;

endmodule
