// **** opcode 操作码 ******
`define add     7'b0110000
`define sw      7'b0100011


`define add_pmu     4'b0000
`define addi_pmu    4'b0001
`define sw_pmu      4'b0010
`define lw_pmu      4'b0011
`define cla_pmu     4'b0100    // 累加器清除
`define com_pmu     4'b0101    // 累加器取反
`define shr_pmu     4'b0110    // 算术右移一位
`define csl_pmu     4'b0111    // 算数左移一位
`define stp_pmu     4'b1000    // 停机
`define jmp_pmu     4'b1001    // 无条件跳转
`define ban_pmu     4'b1011    // 有条件跳转


`define acc_cla     2'b01
`define acc_com     2'b10
