`include "./ram/ram.v"

module ram_test ();
    
    reg clk;
    reg write_n;
    reg [9: 0] addr;
    reg [15: 0] data_in;

    wire [15: 0] data_out;

    ram U_ram(
        .clk(clk),
        .write_n(write_n),
        .addr(addr),
        .data_in(data_in),

        .data_out(data_out)
    );

    always #0.5 clk <= ~clk;

    initial begin
        clk = 1'b0;
        write_n = 1'b1;
        addr = 10'd0;
        data_in = 16'd0;

        #20
        write_n = 1'b0;
        for (integer i = 0; i < 16; i = i + 1) begin
            @(posedge clk) #5 data_in = i;
            addr = i;
        end

        #20
        write_n = 1'b1;
        for (integer i = 0; i < 16; i = i + 1) begin
            @(posedge clk) #5 addr = i;

        end
        
        #20
        $finish;
    end

    initial begin            
        $dumpfile("./ram/ram_test.vcd");      
        $dumpvars(0, ram_test);   
    end


endmodule