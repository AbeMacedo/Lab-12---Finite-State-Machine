// Implement binary state machine
module binary(
    input w,
    input clk,
    input reset,
    //3bit binary
    output [2:0] BinaryState,
    output z
);

    wire [2:0] State; 
    wire [2:0] Next;
    
    //2bit [1:0]
    //3bit [2:0]

    //Default 0 = 1'b0
    dff zero(
        .Default(1'b0),
        .D(Next[0]),
        .clk(clk),
        .reset(reset),
        .Q(State[0])
    );

    dff one(
        .Default(1'b0),
        .D(Next[1]),
        .clk(clk),
        .reset(reset),
        .Q(State[1])
    );
    
    dff two(
        .Default(1'b0),
        .D(Next[2]),
        .clk(clk),
        .reset(reset),
        .Q(State[2])
    );
    
    //assign z = State[1] & ~State[0];
    //assign Next[0] = w & ~State[1] & ~State[0];
    //assign Next[1] = w & (State[1] | State[0]);

    assign z = (~State[2] & State[1] & ~State[0]) | (State[2] & ~State[1] & ~State[0]);
    assign BinaryState = State; //Next;
    
    //LSB
    assign Next[0] = (~w & ~State[1] & ~State[0]) | (w & ~State[2] & ~State[1])|
                     (w & ~State[2] & ~State[0]) | (~w & State[1] & State[0]);
    //Middle bit thingy
    assign Next[1] = (w & ~State[2] & ~State[1]) | (w & ~State[2] & ~State[0]) |
                     (~w & ~State[2] & ~State[1] & State[0]) | (~w & State[1] & ~State[0]);
    //MSB
    assign Next[2] = (w & State[2]) | (w & State[1] & State[0]);

endmodule