// Challenge: It is legal to have 'posedge clk, negedge clk' in the sensitivity list of an always statement
// Here, I implemented it using two FFs, one following the clock rising edge, and the other the trailing edge.
// We know after a rising edge, clk is high, and after a trailing edge, clk is low, hence the clk signal
// implies the most recent edge event, so it is used as the select line to a 2-1 MUX that switches the correct FF output

module top_module (
    input clk,
    input d,
    output q
);
  	wire pos_q;
  	wire neg_q;
    
    always @(posedge clk)
        pos_q <= d;
    always @(negedge clk)
        neg_q <= d;
    
    assign q = clk ? pos_q : neg_q;

endmodule
