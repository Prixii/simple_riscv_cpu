module reg_file (
    clk,            // 时钟
    rst_n,          // 复位
    write_en,       // 写使能
    read_addr_1, read_addr_2,   // 读地址
    read_data_1, read_data_2,   // 读数据
    write_addr, write_data      // 写地址，写数据
);

    input clk;
    input rst_n;
    input write_en;
    input [2: 0] read_addr_1, read_addr_2;
    input [2: 0] write_addr;
    input [15: 0] write_data;
    output [15: 0] read_data_1, read_data_2;

    reg [15:0] registers [7:0];    // 8个16位寄存器
    reg [7: 0] i;

    // ******** 写操作 ********
    always @(posedge clk) begin     // 选择上升沿触发
        if (!rst_n)begin            // 复位有效
            for (i = 0; i < 8'd8; i = i + 1)
                registers[i] = 16'd0;
        end 
        else if (write_en & (write_addr != 0)) begin    // 写使能触发，并且目标寄存器不是0号寄存器
            registers[write_addr] <= write_data;
                
        end
    end

    // ******** 读操作 ********
    assign read_data_1 = (read_addr_1 == 3'd0) ? 16'd0: registers[read_addr_1];
    assign read_data_2 = (read_addr_2 == 3'd0) ? 16'd0: registers[read_addr_2];

    initial $readmemb("./init_reg.txt", registers, 0, 7);

endmodule