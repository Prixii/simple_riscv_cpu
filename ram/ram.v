module ram (
    clk,        // 时钟信号
    write_n,    // 写使能，低电平触发
    addr,       // 目标地址
    data_in,    // 写入的数据
    data_out,   // 读出的数据
);

    input clk;
    input write_n;
    input [9: 0] addr;
    input [15: 0] data_in;  

    output reg [15: 0] data_out;

    reg [15: 0] ram_reg [1023: 0];

    // ********** 写操作 *************
    always @(posedge clk ) begin    // 为了保证一致性，时钟上升沿触发
        if (!write_n)               // 写使能低电平说明实行写操作
            ram_reg[addr] <= data_in;
    end

    // ********** 读操作 *************
    always @(*) begin               // 读操作不受时钟控制
        if (write_n)                // 写使能高电平即为读
            data_out = ram_reg[addr];
    end

endmodule