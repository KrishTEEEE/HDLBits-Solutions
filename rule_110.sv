module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 
    logic [511:0] l;
    assign l = {1'b0, q[511:1]}; // equivalent to shifting right, adding a 0 to the left, aligns left neighbor to centre bit
    
    logic [511:0] r;
    assign r = {q[510:0], 1'b0}; // equivalent to shifting left, adding 0 to the right, aligns right neighbor to centre bit
    
    always_ff @(posedge clk)begin
        if(load) q <= data;
        else begin
            q <= ~q&r | ~l&r | q&~r;
        end
    end

endmodule
