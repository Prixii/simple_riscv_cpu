`include "./define/define.v"
module cu(
    opcode,
    ALU_CTL,
    data_rom_write_en,
);
    input [6: 0] opcode;
    output data_rom_write_en;
    output [2: 0] ALU_CTL;

    assign data_rom_write_en = (opcode == `sw) ? 1'b1 : 1'b0;
    assign ALU_CTL = (opcode == `add ) ? 3'b000 : 3'b111;
endmodule

module cu_pro_max_ultra(
    opcode, // 操作码
    ALU_CTL,    // ALU控制信号
    ACC_CTL,
    data_rom_write_en,  // data_rom写使能
);
    input [3: 0] opcode;
    output data_rom_write_en;
    output [2: 0] ALU_CTL;
    output [1: 0] ACC_CTL;

    reg [2:0 ] ALU_CTL_REG;
    assign data_rom_write_en = (opcode == `sw_pmu) ? 1'b1 : 1'b0;
    always @(*) begin
        case (opcode)
            `add_pmu: ALU_CTL_REG <= 3'b000;  
            `addi_pmu: ALU_CTL_REG  <= 3'b000;
            `csl_pmu: ALU_CTL_REG  <= 3'b100;
            `shr_pmu: ALU_CTL_REG  <= 3'b110;
        endcase; 
    end

    assign ALU_CTL =  ALU_CTL_REG;
    assign ACC_CTL = (opcode == `cla_pmu) ? 2'b01 : (opcode == `com_pmu)? 2'b10 : 2'b00; 
endmodule