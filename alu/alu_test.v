`include "./alu/alu.v"

module alu_test ();

    reg [15: 0] ALU_DA, ALU_DB;
    reg [2: 0] ALU_CTL;
    reg [3: 0] ALU_SHIFT;
    wire [15: 0] ALU_DC;
    wire ALU_OverFlow;

    ALU U_alu(
        .ALU_DA(ALU_DA), .ALU_DB(ALU_DB), 
        .ALU_CTL(ALU_CTL),
        .ALU_SHIFT(ALU_SHIFT), 
        .ALU_DC(ALU_DC),
        .ALU_OverFlow(ALU_OverFlow)
    ); 

    initial begin
        ALU_DA <= 16'd51;
        ALU_DB <= 16'd59;
        ALU_CTL <= 3'b000;
        ALU_SHIFT <= 4'b0000;

        #20
        ALU_DA <= 16'hfff0;
        ALU_DB <= 16'h00f0;
        ALU_CTL <= 3'b010;

        #20
        ALU_CTL <= 3'b011;

        #20
        ALU_CTL <= 3'b000;
    end
    
    initial begin            
        $dumpfile("./alu/alu_test.vcd");      
        $dumpvars(0, alu_test);   
    end
endmodule
