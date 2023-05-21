`include "./define/define.v"
module cu(
    opcode,
    write_en,
    ALU_CTL,
    data_rom_wrtie_en,
);
    input [6: 0] opcode;
    output write_en, data_rom_wrtie_en;
    output [2: 0] ALU_CTL;

    assign data_rom_wrtie_en = (opcode == `sw) ? 1'b1 : 1'b0;
    assign write_en = (opcode == `add ) ? 1'b1 : 1'b0; 
    assign ALU_CTL = (opcode == `add ) ? 3'b000 : 3'b111; 
endmodule

module cu_pro_max_ultra(
    opcode,
    write_en,
    ALU_CTL,
    data_rom_wrtie_en,
);
    input [3: 0] opcode;
    output write_en, data_rom_wrtie_en;
    output [2: 0] ALU_CTL;

    assign data_rom_wrtie_en = (opcode == `sw_pmu) ? 1'b1 : 1'b0;
    assign write_en = (opcode == `add_pmu ) ? 1'b1 : 1'b0; 
    assign ALU_CTL = (opcode == `add_pmu || opcode == `addi_pmu) ? 3'b000 : 3'b111; 
endmodule