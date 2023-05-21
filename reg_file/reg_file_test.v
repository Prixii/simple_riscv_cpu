`include "./reg_file/reg_file.v"

module reg_file_test ();
//  输入
    reg clk;
    reg rst_n;
    reg write_en;
    reg [2: 0] read_addr_1, read_addr_2;
    reg [2: 0] write_addr;
    reg [15: 0] write_data;
//  输出
    wire [15:0] read_data_1, read_data_2;


    reg [3: 0] i;
    reg_file U_reg_file(
        .clk(clk),
        .rst_n(rst_n),
        .write_en(write_en),
        .read_addr_1(read_addr_1),.read_addr_2(read_addr_2),
        .write_addr(write_addr),.write_data(write_data),
        .read_data_1(read_data_1),.read_data_2(read_data_2)
    );

    always #0.5 clk <= ~clk;

    initial begin
        clk = 1'b0;
        rst_n = 1'b1;
        read_addr_1 = 3'd0;
        read_addr_2 = 3'd0;
        write_en = 1'b0;
        write_addr = 3'd0;
        write_data = 16'd0;
    end
    initial begin
        #10
        rst_n = 1'b0;   //复位

        #10
        rst_n = 1'b1;
        write_en = 1'b1;

        for (i = 0; i<4'd8; i = i + 1) begin
            @(posedge clk) #10 write_addr = i;
            write_data = 7 - i;
        end
        #10
        write_en = 1'b0;

        #10
        for (i = 0; i<4'd8; i = i + 1) begin
            @(posedge clk) #10 read_addr_1 = i;
            read_addr_2 = 7 - i;
        end  

        #10 //
        $finish;

    end



    initial begin            
        $dumpfile("reg_file_test.vcd");      
        $dumpvars(0, reg_file_test);   
    end

endmodule


