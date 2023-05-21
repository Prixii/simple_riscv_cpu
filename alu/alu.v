// ****************************************
// | ALU_CTL | 运算类型 | 运算 |
// | ------- | -------- | ---------- |
// | 000     | 加法运算 | +          |
// | 001     | 加法运算 | -          |
// | 010     | 逻辑运算 | &          |
// | 011     | 逻辑运算 | 或         |
// | 100     | 移位运算 | 逻辑左移   |
// | 101     | 移位运算 | 逻辑右移   |
// | 110     | 移位运算 | 算数右移   |
// ****************************************


// ****************************************
// | 信号名          | 方向  | 含义                          |
// | --------------- | ----- | ----------------------------- |
// | ALU_DA[15: 0]   | input | 第一个数据                    |
// | ALU_DB[15: 0]   | input | 第二个数据                    |
// | ALU_CTL[2: 0]   | input | 功能控制                      |
// | ALU_SHIFT[4: 0] | input | 移位的次数                    |
// | ALU_OverFlow    | out   | 溢出标志                      |
// | ALU_DC[15: 0]   | out   | 运算结果                      |
// ****************************************

module ALU(
    ALU_DA,ALU_DB,  // 两个操作数
    ALU_CTL,    // 控制信号
    ALU_SHIFT,
    ALU_DC,    // 运算结果
    ALU_OverFlow        // 溢出符号   
);

    input [15: 0] ALU_DA, ALU_DB;
    input [3: 0] ALU_SHIFT;
    input [2: 0] ALU_CTL;
    output reg [15: 0] ALU_DC;
    output ALU_OverFlow;

    // ******** 结果输出 ********
    wire [1: 0] Operate_CTL;
    assign Operate_CTL = ALU_CTL[2:1];

    // 运算类型判定，选择结果返回
    always @(*) begin
        case (Operate_CTL)
            2'b00: ALU_DC = arthimetic_result;  // 00* 为加法运算
            2'b01: ALU_DC = logic_result;       // 01* 为逻辑运算
            default: ALU_DC = shift_result;     // 10* 与 11* 为移位运算
        endcase    
    end

    // ******** 运算 ********

    // 算术运算
    wire [15: 0] arthimetic_result;

    wire ADD_OverFlow, ADD_carry;

    wire sub_ctl;
    assign sub_ctl = ALU_CTL[0];

    wire [15: 0] neg_ALU_DB;
    assign neg_ALU_DB = ALU_DB ^ {32{sub_ctl}};

    Adder ADD(
        .ADD_DA(ALU_DA),.ADD_DB(neg_ALU_DB),
        .ADD_Cin(sub_ctl),
        .ADD_DC(arthimetic_result),
        .ADD_OverFlow(ADD_OverFlow),
        .ADD_carry(ADD_carry)
    );


    // 逻辑运算
    reg [15: 0] logic_result;

    wire logic_ctl;
    assign logic_ctl = ALU_CTL[0];

    always@(*) begin
        case (logic_ctl)
            1'b0: logic_result = ALU_DA & ALU_DB;
            1'b1: logic_result = ALU_DA | ALU_DB; 
        endcase
    end

    // 移位运算
    wire [15: 0] shift_result;

    wire [1:0] shift_ctl;
    assign shift_ctl = ALU_CTL[1:0];

    Shifter shifter(
        .ALU_DA(ALU_DA),
        .ALU_SHIFT(ALU_SHIFT),
        .shift_ctl(shift_ctl),
        .shift_result(shift_result)
    );

endmodule

// ******** 模块 ********

// 加法器模块
module Adder(       
    ADD_DA, ADD_DB, // 两个操作数
    ADD_Cin,        // 进位输入
    ADD_DC,         // 加法结果
    ADD_OverFlow,   // 溢出符号
    ADD_carry,      // 进位输出
);

input [15: 0] ADD_DA, ADD_DB;
input ADD_Cin;
output [15: 0] ADD_DC;
output ADD_OverFlow;
output ADD_carry;

assign {ADD_carry, ADD_DC } = ADD_DA + ADD_DB + ADD_Cin;  // 使用 { } 将两者连接起来，自然生成进位和结果
assign ADD_OverFlow = (     // 产生溢出符号
        (ADD_DA[15] == 0 && ADD_DB[15] == 0 && ADD_DC[15] == 1) || 
        (ADD_DA[15] == 1 && ADD_DB[15] == 1 && ADD_DC[15] == 0
    ));     

endmodule

// 移位器模块
module Shifter (
    ALU_DA,         // 原始数据
    ALU_SHIFT,      // 移位次数
    shift_ctl,      // 操作控制
    shift_result    // 移位结果
);

input [15: 0] ALU_DA;
input [3: 0] ALU_SHIFT;
input [1: 0] shift_ctl;
output reg [15: 0] shift_result;

wire [4: 0] shift_n;
assign shift_n = 5'd16 - ALU_SHIFT;

always @(*) begin
    case (shift_ctl)
        2'b00: shift_result = ALU_DA << ALU_SHIFT;  // 逻辑左移
        2'b01: shift_result = ALU_DA >> ALU_SHIFT;  // 逻辑右移
        2'b10: shift_result = ({16{ALU_DA[15]}} << shift_n) | 
        (ALU_DA >> ALU_SHIFT);  // 算数右移
        default: shift_result = ALU_DA; 
    endcase
end

endmodule