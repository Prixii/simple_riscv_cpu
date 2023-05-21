module rom_reg (
    addr,   // 目标地址
    instruction,    // 取出的指令
);

    input [7: 0] addr;
    output [15: 0] instruction;

    reg[15: 0] rom[255: 0]; // 用于存储读到的指令

    // 初始化，读取init.txt中的指令
    initial $readmemb("./init.txt", rom, 0, 15);

    assign instruction = rom[addr];
endmodule

