`include "./top/riscv_top.v"
module riscv_top_test ();
    reg clk;
    reg rst_n;

    always #0.5 clk <= ~clk; 

    riscv_top_pro_max_ultra U_riscv_top_pmu(
        .clk(clk),
        .rst_n(rst_n)
    );

    initial begin
        clk = 1'b0;
        rst_n = 1'b1;

        #10 $finish;
    end

    initial begin            
        $dumpfile("./top/riscv_top_test.vcd");      
        $dumpvars(0, riscv_top_test);   
    end
endmodule