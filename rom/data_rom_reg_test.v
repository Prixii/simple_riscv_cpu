
`include "./rom/data_rom_reg.v"

module data_rom_reg_test ();
    
    wire [15: 0] data;

    reg [7: 0] addr;

    // data_rom_reg U_data_rom_reg(
    //     .addr(addr),
    //     .data(data)
    // );
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
        $dumpfile("./rom/data_rom_reg_test.vcd");      
        $dumpvars(0, data_rom_reg_test);   
    end

endmodule