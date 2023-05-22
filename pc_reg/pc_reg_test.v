`include "./pc_reg/pc_reg.v"

module pc_reg_test ();
    
    reg clk;
    reg rst_n;
    wire [7: 0] pc_out;

    reg[3: 0] i;

    pc_reg U_pc_reg(
        .clk(clk),
        .rst_n(rst_n),
        .pc_out(pc_out)
    );

    always #0.5 clk <= ~clk;

    initial begin
        clk = 1'b0;
        rst_n = 1'b1;
    
        for (i = 0 ;i < 4'd10 ; i = i + 1) #1;
        #1 rst_n <= ~rst_n;
        #1 rst_n <= ~rst_n;
        for (i = 0 ;i < 4'd10 ; i = i + 1) #1;

        $finish;

    end

    initial begin            
        $dumpfile("pc_reg_test.vcd");      
        $dumpvars(0, pc_reg_test);   
    end

endmodule