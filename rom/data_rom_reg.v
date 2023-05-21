// 普通的数据rom，容量64 * 16b
    module data_rom_reg (
        clk,    // 时钟
        rst_n,  // 复位
        write_en,
        addr,   // 目标地址
        data_in,
        data_out,    // 取出的数据
    );

        input clk;
        input rst_n;
        input write_en;
        input [5: 0] addr;
        input [15: 0] data_in;
        output [15: 0] data_out;


        reg[15: 0] rom[63: 0]; // 用于存储读到的数据
        initial $readmemb("./init_data_reg.txt", rom, 0, 15);

        always @(posedge clk) begin
            if (write_en)
                rom[addr] <= data_in;
        end 

        assign data_out = rom[addr];

    endmodule

// 加强的的数据rom，容量512 * 16b
    module data_rom_reg_pro_max_ultra (
        clk,    // 时钟
        rst_n,  // 复位
        write_en,
        addr,   // 目标地址
        data_in,
        data_out,    // 取出的数据
    );

        input clk;
        input rst_n;
        input write_en;
        input [8: 0] addr;
        input [15: 0] data_in;
        output [15: 0] data_out;


        reg[15: 0] rom[511: 0]; // 用于存储读到的数据
        initial $readmemb("./init_data_reg.txt", rom, 0, 15);

        always @(posedge clk) begin
            if (write_en)
                rom[addr] <= data_in;
        end 

        assign data_out = rom[addr];

    endmodule

