`include "./rom/rom_reg.v"

module rom_reg_test ();
    
    wire [15: 0] instruction;

    reg [7: 0] addr;

    rom_reg U_rom_reg(
        .addr(addr),
        .instruction(instruction)
    );
    reg [7: 0] i;

    initial begin
        addr = 8'd0;
        
    end

    initial begin
        #10
        for (i = 0; i < 8'd8; i = i + 1) 
            #1
            addr = i;

        #10
        $finish;
    end
    initial begin            
        $dumpfile("./rom/rom_reg_test.vcd");      
        $dumpvars(0, rom_reg_test);   
    end

endmodule