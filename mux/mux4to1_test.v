`include "./mux/mux4to1.v"

module mux4to1_test ();
    reg [3: 0] in1, in2, in3, in4;
    reg [1: 0] select;
    wire [3: 0] out;
    reg [2: 0] i;

    mux4to1 U_mux4to1(
        .in1(in1),.in2(in2),.in3(in3),.in4(in4),
        .select(select),
        .out(out)
    );
    
    initial begin
        in1 = 4'b0101;
        in2 = 4'b0001;
        in3 = 4'b0100;
        in4 = 4'b0011;
        select = 2'b00;

        #5
        select = 2'b01;
        #5
        select = 2'b10;
        #5
        select = 2'b11;
        #5
        select = 2'b11;
    end

    initial begin            
        $dumpfile("./mux4to1_test.vcd");      
        $dumpvars(0, mux4to1_test);   
    end
endmodule