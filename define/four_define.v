// 本应该是这样的
// `define S_type  7'b0100011;
// `define I_type  7'b0000011;
// `define R_type  7'b0110011;

// // 普通的操作码
// `define add     7'b0100011;
// `define addi    7'b0000011;
// `define sw      7'b0100011;
// `define lw      7'b0000111; 


// 修改后进阶的操作码
`define add     4'b0000;
`define addi    4'b0001;
`define sw      4'b0010;
`define lw      4'b0011; 
