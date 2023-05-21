`include "./top/riscv_top.v"
module riscv_top_test ();
    
    reg clk;
    reg rst_n;
    wire [5: 0] data_rom_i;
    always #0.5 clk <= ~clk; 
    wire [7: 0] rom_addr;

    riscv_top_pro_max_ultra U_riscv_top_pmu(
        .clk(clk),
        .rst_n(rst_n),
        .rom_addr(rom_addr)
    );


    initial begin
        clk = 1'b0;
        rst_n = 1'b1;
    end

    initial begin
        #10

        $finish;
    end



    initial begin            
        $dumpfile("./top/riscv_top_test.vcd");      
        $dumpvars(0, riscv_top_test);   
    end
endmodule