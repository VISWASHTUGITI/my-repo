module block(
    input  [3:0] inp_north,
    input  [3:0] inp_west,
    input clk,
    input rst,
    output reg [3:0] outp_south,
    output reg [3:0] outp_east,
    output reg [9:0] result
);

wire [7:0] product;
assign product = inp_north * inp_west;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        result     <= 10'd0;
        outp_south <= 4'd0;
        outp_east  <= 4'd0;
    end else begin
        result     <= result + product;
        outp_south <= inp_north;
        outp_east  <= inp_west;
    end
end

endmodule
