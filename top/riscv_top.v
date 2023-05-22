`include "./rom/rom_reg.v"
`include "./core/riscv_core.v"
`include "./rom/data_rom_reg.v"
// 普通的CPU顶层，只能实现两种指令
    module riscv_top (
        clk,    // 时钟控制
        rst_n,  // 复位端
        rom_addr,  // 向ROM读取数据的目标地址
    );

        input clk;
        input rst_n;

        output [7: 0] rom_addr;

        wire [15: 0] instruction;
        wire write_en;  // 写入 data_rom 的使能
        wire [15: 0] data_in;
        wire [15: 0] data_out;
        wire [5: 0] data_addr;


    // ************************** 定义ROM_REG ***********************
    // 输入目标地址 read_rom_addr
    // 输出存储的指令 instruction
        rom_reg U_rom_reg(
            .addr(rom_addr),
            .instruction(instruction)
        );

    // ************************** 定义data_rom_reg ***********************
    // 输入 写使能，目标地址，输入数据
    // 输出 读出的数据
        data_rom_reg U_data_rom_reg(
            .clk(clk),
            .rst_n(rst_n),
            .write_en(write_en),
            .addr(data_addr),
            .data_in(data_in),
            .data_out(data_out)
        );

    // ************************** 定义riscv_core ***********************
    // 输入 读取的指令instruction，
    // 输出 下一个指令read_rom_addr
        riscv_core U_riscv_core(
            .clk(clk),
            .rst_n(rst_n),
            .instruction(instruction),
            .rom_addr(rom_addr),
            .data_write_en(write_en),
            .data_rom_write(data_in),
            .data_rom_addr(data_addr)
        );


    endmodule

// 升级版的CPU顶层，能实现四种指令
    module riscv_top_pro_max_ultra (
        clk,    // 时钟控制
        rst_n,  // 复位端
    );

        input clk;
        input rst_n;

        wire [7: 0] rom_addr;
        wire [15: 0] instruction;
        wire write_en;  // 写入 data_rom 的使能
        wire [15: 0] data_in;
        wire [15: 0] data_out;
        wire [8: 0] data_addr;

    // ************************** 定义ROM_REG ***********************
    // 输入目标地址 read_rom_addr
    // 输出存储的指令 instruction
        rom_reg U_rom_reg(
            .addr(rom_addr),
            .instruction(instruction)
        );

    // ************************** 定义data_rom_reg ***********************
    // 输入 写使能，目标地址，输入数据
    // 输出 读出的数据
        data_rom_reg_pro_max_ultra U_data_rom_reg_pmu(
            .clk(clk),
            .rst_n(rst_n),
            .write_en(write_en),
            .addr(data_addr),
            .data_in(data_in),
            .data_out(data_out)
        );

    // ************************** 定义riscv_core ***********************
    // 输入 读取的指令instruction，
    // 输出 下一个指令read_rom_addr
        riscv_core_pro_max_ultra U_riscv_core_pmu(
            .clk(clk),
            .rst_n(rst_n),
            .instruction(instruction),
            .data_rom_read(data_out),
            .rom_addr(rom_addr),
            .data_write_en(write_en),
            .data_rom_write(data_in),
            .data_rom_addr(data_addr)
        );

    endmodule