// ****************************************
// | Opcode | rs1  | rs2  | rs3  |
// | ------ | ---- | ---- | ---- |
// | 15~9   | 8~6  | 5~3  | 2~0  |
// ****************************************
// 只支持一种指令，但它只是个译码器
    module add_decoder (
        instruction,    // 指令输入
        opcode,         // 操作码
        rs1, rs2, rs3,     // 寄存器地址
    );

        input [15: 0] instruction;
        
        output [6: 0] opcode;
        output [2: 0] rs1, rs2, rs3;
        
        assign opcode = instruction[15: 9]; 
        assign rs1 = instruction[8: 6];
        assign rs2 = instruction[5: 3];
        assign rs3 = instruction[2: 0];
        assign addr = instruction[8: 0];


    endmodule


// 支持两种指令，革命性的提升，他值得一个pro，不是吗
    module decoder_pro(
        instruction,    // 指令输入
        opcode,         // 操作码
        rs1, rs2, rs3,     // 寄存器地址
        addr,    // 写回data_rom的地址 
    );

        input [15: 0] instruction;
        
        output [6: 0] opcode;
        output [2: 0] rs1, rs2, rs3;
        output [5: 0] addr;
        
        assign opcode = instruction[15: 9]; 
        assign rs1 = instruction[8: 6];
        assign rs2 = instruction[5: 3];
        assign rs3 = instruction[2: 0];
        assign addr = instruction[5: 0];
    endmodule


// 它居然能支持11种指令！传说一般的存在
    module decoder_pro_max_ultra (
        instruction,    // 指令输入
        opcode,         // 操作码
        rs1, rs2,     // 寄存器地址
        addr,    // 写回data_rom的地址 
        imm,     // 立即数
        shift,
    );

        input [15: 0] instruction;
        
        output [3: 0] opcode;
        output [2: 0] rs1, rs2;
        output [3: 0] shift;
        output [8: 0] addr;
        output [8: 0] imm;

        assign opcode = instruction[15: 12]; 
        assign rs1 = instruction[11: 9];
        assign rs2 = instruction[8: 6];
        assign shift = instruction[11:8];
        assign addr = instruction[8: 0];
        assign imm = instruction[8: 0];
    endmodule
