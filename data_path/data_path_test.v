`include "./data_path/data_path.v"
module data_path_test (
);
    data_path U_data_path();

    initial begin            
        $dumpfile("./data_path/data_path_test.vcd");      
        $dumpvars(0, data_path_test);   
    end
endmodule
