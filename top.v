module top(
    input sw, // w
    output [9:0] led, // see IO table
    input btnC, // clk
    input btnU // reset
);

    // Hook up binary and one-hot state machines
    
    //One-Hot Module
    onehot instance1(
        .w(sw),
        .clk(btnC),
        .reset(btnU),
        .z(led[0]), //One-hot Z
        .Astate(led[2]),
        .Bstate(led[3]),
        .Cstate(led[4]),
        .Dstate(led[5]),
        .Estate(led[6])
    );
    
    //Binary Module
    binary instance2(
        .w(sw),
        .clk(btnC),
        .reset(btnU),
        .z(led[1]), //BinaryZ
        .BinaryState(led[9:7])
    );
endmodule