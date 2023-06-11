`include "./pc_reg/pc_reg.v"
`include "./alu/alu.v"
`include "./ram/ram.v"
`include "./reg_file/reg_file.v"
`include "./data_path/decoder.v"
`include "./define/define.v"

// ****************************************
// | 指令 | 号码    |
// | ---- | ------- |
// | add  | 0110000 |
// ****************************************

// // ****************** 支持两种指令的数据通路 **********************
//     module data_path (
//         clk,            // 时钟信号
//         rst_n,          // 复位信号，低电平有效
//         ALU_CTL,        // ALU控制信号
//         instruction,    // 指令输入

//         opcode,
//         rom_addr,       // 下一个指令地址
//         ALU_result,
//         data_rom_addr,
//         data_rom_write_data,
//     );
//         input clk;
//         input rst_n;
//         input [2: 0] ALU_CTL;
//         input [15: 0] instruction;
        
//         output [6: 0] opcode;
//         output [7: 0] rom_addr;
//         output [15: 0] ALU_result;
//         output [5: 0] data_rom_addr;
//         output [15: 0] data_rom_write_data;

//         wire [2: 0] rs1, rs2, rs3;  // 三个目标寄存器的地址
//         wire reg_write_en;

//         assign reg_write_en = (opcode == `add) ? 1'b1 : 1'b0;
//         // 如果操作码是add，就设置为b000
//         assign ALU_CTL = (opcode == `add ) ? 3'b000 : 3'b111;
//         assign ALU_DA = read_data_1;
//         assign ALU_DB = read_data_2;
//         assign data_rom_write_data = (opcode == `sw) ? read_data_1 : 16'd0; 

//     // ************************** 定义ALU ***********************
//     // 输入控制信号ALU_CTL，两个数据ALU_DA, ALU_DB
//     // 输出结构ALU_result
//         wire [15: 0] ALU_DA, ALU_DB;
//         wire [2: 0] ALU_CTL;
//         wire ALU_OverFlow;

//         ALU U_ALU(
//             .ALU_DA(ALU_DA),.ALU_DB(ALU_DB),
//             .ALU_CTL(ALU_CTL),
//             .ALU_SHIFT(),
//             .ALU_DC(ALU_result),
//             .ALU_OverFlow(ALU_OverFlow)
//         );

//     // ************************** 定义PC ***********************
//     // 无输入
//     // 返回当前指令地址 pc_out

//         pc_reg U_pc_reg(
//             .clk(clk),
//             .rst_n(rst_n),
//             .pc_out(rom_addr)
//         );

//     // ************************** 定义reg_file ***********************
//     // 输入写地址write_reg_addr, 写数据 write_data
//     // 输入读地址rs1, 读地址rs2
//     // 返回数据 read_data_1, read_data_2
//         wire [15: 0] read_data_1, read_data_2;
//         wire [15: 0] write_reg_data; // 写回寄存器的数据
//         wire [2: 0] write_reg_addr;
//         assign write_reg_data = ALU_result;
//         assign write_reg_addr = (opcode == `add) ? rs3 : 3'b000;
//         reg_file U_reg_file(
//             .clk(clk),
//             .rst_n(rst_n),
//             .write_en(reg_write_en),
//             .read_addr_1(rs1), .read_addr_2(rs2),
//             .read_data_1(read_data_1), .read_data_2(read_data_2),
//             .write_addr(write_reg_addr), .write_data(write_reg_data) 
//         );

//     // ************************** 定义decoder ***********************
//     // 输入指令 instruction
//     // 返回 opcode, rs1, rs2, rs3
//         wire [6: 0] opcode;
        
//         // add_decoder U_add_decoder(
//         //     .instruction(instruction),
//         //     .opcode(opcode),
//         //     .rs1(rs1),.rs2(rs2),.rs3(rs3)
//         // );

        
//         decoder_pro U_decoder_pro(
//             .instruction(instruction),
//             .opcode(opcode),
//             .rs1(rs1),.rs2(rs2),.rs3(rs3),
//             .addr(data_rom_addr)
//         );


        
//     endmodule

// ****************** 支持十一种指令的神奇数据通路 **********************

    module data_path_pro_max_ultra (
        clk,            // 时钟信号
        rst_n,          // 复位信号，低电平有效
        ALU_CTL,        // ALU控制信号
        ACC_CTL,
        instruction,    // 指令输入
        data_rom_read,  // 从data_rom中读取的数据

        opcode,         // 操作指令
        rom_addr,       // 下一个指令地址
        ALU_result,     // ALU计算结果
        data_rom_addr,  // 写回data_rom的地址
        data_rom_write_data,    // 写入 data_rom 的数据
    );
        input clk;
        input rst_n;
        input [2: 0] ALU_CTL;
        input [1: 0] ACC_CTL; 
        input [15: 0] instruction;
        input [15: 0] data_rom_read;
        
        output [3: 0] opcode;
        output [7: 0] rom_addr;
        output [15: 0] ALU_result;
        output [8: 0] data_rom_addr;
        output [15: 0] data_rom_write_data;

        wire [2: 0] rs1, rs2;  // 三个目标寄存器的地址
        wire reg_write_en;
        wire [8: 0] imm;

        assign reg_write_en = (opcode != `sw_pmu) ? 1'b1 : 1'b0;
        // 如果操作码是add,addi，就设置为b000
        // assign ALU_CTL = (opcode == `add_pmu || opcode == `addi_pmu ) ? 3'b000 : 3'b111;
        assign ALU_DA = read_data_1;
        assign ALU_DB = (opcode == `addi_pmu ) ? imm : read_data_2;
        assign data_rom_write_data = (opcode == `sw_pmu) ? read_data_1 : 16'd0; 

    // ************************** 定义ALU ***********************
    // 输入控制信号ALU_CTL，两个数据ALU_DA, ALU_DB
    // 输出结构ALU_result
        wire [15: 0] ALU_DA, ALU_DB;
        wire ALU_OverFlow;
        wire [1: 0] ACC_CTL;

        ALU U_ALU(
            .ALU_DA(ALU_DA),.ALU_DB(ALU_DB),
            .ALU_CTL(ALU_CTL),
            .ALU_SHIFT(shift),
            .ALU_DC(ALU_result),
            .ALU_OverFlow(ALU_OverFlow),
            .ACC_CTL(ACC_CTL)
        );

    // ************************** 定义PC ***********************
    // 无输入
    // 返回当前指令地址 pc_out
        reg [7:0] pc_in;
        pc_reg U_pc_reg(
            .clk(clk),
            .rst_n(rst_n),
            .pc_in(pc_in),
            .pc_out(rom_addr)
        );
        always @(posedge clk ) begin
            case (opcode)
                `jmp_pmu: pc_in = imm;
                `ban_pmu:pc_in = pc_in + ALU_result[15];
                default: pc_in = pc_in +1;
            endcase

        end
    // ************************** 定义reg_file ***********************
    // 输入写地址write_reg_addr, 写数据 write_data
    // 输入读地址rs1, 读地址rs2
    // 返回数据 read_data_1, read_data_2
        wire [15: 0] read_data_1, read_data_2;
        wire [15: 0] write_reg_data; // 写回寄存器的数据
        wire [2: 0] write_reg_addr;
        assign write_reg_data = (opcode == `lw_pmu) ? data_rom_read :ALU_result ;
        assign write_reg_addr = rs1;
        reg_file U_reg_file(
            .clk(clk),
            .rst_n(rst_n),
            .write_en(reg_write_en),
            .read_addr_1(rs1), .read_addr_2(rs2),
            .read_data_1(read_data_1), .read_data_2(read_data_2),
            .write_addr(write_reg_addr), .write_data(write_reg_data) 
        );

    // ************************** 定义decoder ***********************
    // 输入指令 instruction
    // 返回 opcode, rs1, rs2, rs3
        wire [3:0] shift;
        decoder_pro_max_ultra U_decoder_pmu(
            .instruction(instruction),
            .opcode(opcode),
            .rs1(rs1),.rs2(rs2),
            .addr(data_rom_addr),
            .imm(imm),
            .shift(shift)
        );
        
    endmodule