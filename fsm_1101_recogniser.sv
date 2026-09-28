module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    typedef enum {IDLE, DET1, DET11, DET110, DET1101} my_state;
    my_state current, next;
    
    always_ff @(posedge clk)begin
        if(reset) begin current <= IDLE; end else begin current <= next; end
    end
    //next state logic
    always_comb
        case(current)
            IDLE: if(data) begin next = DET1; end else begin next = current; end
            DET1: if(data) begin next = DET11; end else begin next = IDLE; end
            DET11: if(data) begin next = DET11; end else begin next = DET110; end
            DET110: if(data) begin next = DET1101; end else begin next = IDLE; end
            DET1101: next = current;
            default: next = IDLE;
        endcase
    
    always_comb
        case(current)
            IDLE: start_shifting = 1'b0;
            DET1: start_shifting = 1'b0;
            DET11: start_shifting = 1'b0;
            DET110: start_shifting = 1'b0;
            DET1101: start_shifting = 1'b1;
            default: start_shifting = 1'b0;
        endcase

endmodule
