
// ****************************************
// | 信号名 | 位宽 | 输入输出 | 说明                 |
// | ------ | ---- | -------- | -------------------- |
// | clk    | 1b   | input    | 时钟信号             |
// | rst_n  | 1b   | input    | 读出的指令           |

// | pc_out | 8b   | output   | 更新后的pc值         |
// ****************************************

module pc_reg (
    clk,        // 时钟
    rst_n,      // 复位
    pc_out      // 更新后的PC值
);

    input clk;
    input rst_n;

    output reg [7: 0] pc_out;

    always @(posedge clk or negedge rst_n) begin    // 时钟上升沿 或者 复位端被触发
        if (!rst_n)         // 如果复位端被触发
            pc_out <= 8'd0; // 置零
        else
            pc_out <= (pc_out + 1);   // 输出下一个pc值
    end

    initial begin
        pc_out <= 8'd0;
    end

endmodule