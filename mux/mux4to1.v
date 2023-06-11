
// 4选1mux
module mux4to1 (
    in1, in2, in3, in4, // 数据输入
    select,     // 选择端口
    out,   // 数据输出
);
    input [3:0] in1, in2, in3, in4;
    input [1: 0] select;
    
    output reg [3: 0] out;

    always @(*) begin
        case (select)
            2'd0: out = in1;
            2'd1: out = in2;
            2'd2: out = in3;
            2'd3: out = in4; 
            default: out = 10'bx;
        endcase
    end

endmodule