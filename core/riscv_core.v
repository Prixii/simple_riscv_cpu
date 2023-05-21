`include "./data_path/data_path.v"
`include "./cu/cu.v"
// ************** 只支持两种指令的原始cpu核心*************
    module riscv_core (
        clk,        // 时钟
        rst_n,      // 复位
        instruction,    // 传入的指令
        rom_addr,       // rom目标地址
        data_write_en,  // data_rom_reg写使能
        data_rom_out,
        data_rom_addr,
    );
        input clk;
        input rst_n;
        input [15: 0] instruction;
        
        output [7: 0] rom_addr;
        output data_write_en;
        output [15: 0] data_rom_out;
        output [5: 0] data_rom_addr; 

        wire [6: 0] opcode;
        wire [2: 0] rs1, rs2, rs3;
        wire write_en;
        wire [2: 0] ALU_CTL;
        wire [15: 0] ALU_result;


        data_path U_data_path(
            .clk(clk),
            .rst_n(rst_n),
            .ALU_CTL(ALU_CTL),
            .instruction(instruction),

            .opcode(opcode),
            .rom_addr(rom_addr),
            .ALU_result(ALU_result),
            .data_rom_addr(data_rom_addr),
            .data_rom_write_data(data_rom_out)
        );

        cu U_cu(
            .opcode(opcode),
            .write_en(write_en),
            .ALU_CTL(ALU_CTL),
            .data_rom_wrtie_en(data_write_en)
        );



    endmodule


// ************** 原始cpu核心,但是支持的指令数达到了惊人的4条 *************
    module riscv_core_pro_max_ultra (
    clk,        // 时钟
    rst_n,      // 复位
    instruction,    // 传入的指令
    data_rom_read,

    rom_addr,       // rom目标地址
    data_write_en,  // data_rom_reg写使能
    data_rom_out,
    data_rom_addr,
);
    input clk;
    input rst_n;
    input [15: 0] instruction;
    input [15: 0] data_rom_read;
    
    output [7: 0] rom_addr;
    output data_write_en;
    output [15: 0] data_rom_out;
    output [8: 0] data_rom_addr; 

    wire [3: 0] opcode;
    wire [2: 0] rs1, rs2;
    wire write_en;
    wire [2: 0] ALU_CTL;
    wire [15: 0] ALU_result;


    data_path_pro_max_ultra U_data_path_pmu(
        .clk(clk),
        .rst_n(rst_n),
        .ALU_CTL(ALU_CTL),
        .instruction(instruction),
        .data_rom_read(data_rom_read),

        .opcode(opcode),
        .rom_addr(rom_addr),
        .ALU_result(ALU_result),
        .data_rom_addr(data_rom_addr),
        .data_rom_write_data(data_rom_out)
    );

    cu_pro_max_ultra U_cu_pmu(
        .opcode(opcode),
        .write_en(write_en),
        .ALU_CTL(ALU_CTL),
        .data_rom_wrtie_en(data_write_en)
    );



endmodule