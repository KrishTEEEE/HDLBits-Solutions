module fsm_1010(
    input logic         clk,
    input logic         x,
    input logic         
    output logic        detect
);
    logic [3:0] state, next_state;

    always_ff@(posedge clk)begin
        state <= next_state;
    end

    always_comb begin
        case(state)
            4'b0: if(x) next_state = 4'b1; else next_state = state;
            4'b1: if(!x) next_state = 4'b10; else next_state = state;
            4'b10: if(x) next_state = 4'b101; else next_state = 4'b0;
            4'b101: if(!x) next_state = 4'b1010; else next_state = 4'b1;
            4'b1010: next_state = 4'b0;
            // default case for the undefined states! To ensure determinism during special times like power-on.
            default: next_state = 4'b0;
        endcase
    end

    // if output logic is simple enough, this is cleaner than an always_comb block
    assign detect = (state == 4'b1010) ? 1'b1 : 1'b0;

endmodule
