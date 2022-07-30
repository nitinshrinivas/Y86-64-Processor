
module fetch(clk,icode,ifun,rA,rB,valC,valP,hlt,inst_valid,mem_error,PC);

input clk;
input [63:0] PC;

output reg [3:0] icode;
output reg [3:0] ifun;
output reg [3:0] rA;
output reg [3:0] rB;
output reg [63:0] valP;
output reg [63:0] valC;
output reg hlt;
output reg inst_valid;
output reg mem_error;

reg [7:0] inst_mem [0:1023];
reg [0:79] inst;

// initial begin
//     inst_mem[50]=8'b01100000; // add operation
//     inst_mem[51]=8'b00100011; // rA(2) and rB(3)

//     inst_mem[52]=8'b01100001; // subtrat operation 
//     inst_mem[53]=8'b00100001; // rA(2) and rC(1)

//     inst_mem[54]=8'b00010000; // no operation

//     inst_mem[55]=8'b01100000; // add operation
//     inst_mem[56]=8'b00100011; // rA(2) and rB(3)

//     inst_mem[57]=8'b00010000; // no operation

//     inst_mem[58]=8'b00000000; // halt
// end

initial begin
    inst_mem[0] = 8'b00110000;  // A = 6;
    inst_mem[1] = 8'b00000000;  // rax
    inst_mem[2] = 8'b00000000;
    inst_mem[3] = 8'b00000000;
    inst_mem[4] = 8'b00000000;
    inst_mem[5] = 8'b00000000;
    inst_mem[6] = 8'b00000000;
    inst_mem[7] = 8'b00000000;
    inst_mem[8] = 8'b00000000;
    inst_mem[9] = 8'b00000110;

    inst_mem[10] = 8'b00110000;  // B =5;
    inst_mem[11] = 8'b00000011;  // rbx
    inst_mem[12] = 8'b00000000;
    inst_mem[13] = 8'b00000000;
    inst_mem[14] = 8'b00000000;
    inst_mem[15] = 8'b00000000;
    inst_mem[16] = 8'b00000000;
    inst_mem[17] = 8'b00000000;
    inst_mem[18] = 8'b00000000;
    inst_mem[19] = 8'b00000101;

    inst_mem[20] = 8'b01100000;  //a + b
    inst_mem[21] = 8'b00000011;
    
    inst_mem[22] = 8'b00010000;  //nop
    inst_mem[23] = 8'b00010000;  //nop
    inst_mem[24] = 8'b00000000; // halt
    // inst_mem[23] = 8'b00010000;  //nop
    // inst_mem[24] = 8'b00010000;  //nop

    // inst_mem[25] = 8'b00100000;  //rr mov
    // inst_mem[26] = 8'b00000001;

    // inst_mem[26] = 8'b00010000;  //nop
    // inst_mem[27] = 8'b00010000;  //nop
    // inst_mem[28] = 8'b00010000;  //nop
    // inst_mem[29] = 8'b00010000;  //nop



    // inst_mem[30] = 8'b01100000;  //a+b
    // inst_mem[31] = 8'b00010011;  

end

always @ (posedge clk)
begin
    
    mem_error = 0;           // finding if the given instruction is within the  
    if(PC>1023)              // instruction memory or not
    begin
      mem_error = 1;
    end

    inst_valid=1;

    inst={
        inst_mem[PC],
        inst_mem[PC+1],
        inst_mem[PC+2],
        inst_mem[PC+3],
        inst_mem[PC+4],
        inst_mem[PC+5],
        inst_mem[PC+6],
        inst_mem[PC+7],
        inst_mem[PC+8],
        inst_mem[PC+9]
    };

    icode = inst[0:3];
    ifun = inst[4:7];

    if(icode == 4'b0000) begin         // halt operation
      hlt = 1;
      valP = PC + 64'd1;
    end

    else if (icode == 4'b0001) begin   // nop operation
      valP = PC + 64'd1;
    end

    else if (icode == 4'b0010) begin   // cmovxx ----> conditional move
      rA = inst[8:11];
      rB = inst[12:15];
      valP = PC+64'd2;
    end

    else if (icode == 4'b0011) begin   // irmov operation
      rB = inst[12:15];
      valC = inst[16:79];
      valP = PC + 64'd10;
    end

    else if (icode == 4'b0100) begin   // rmmov operation
      rA = inst[8:11];
      rB = inst[12:15];
      valC = inst[16:79];
      valP = PC + 64'd10;
    end

    else if (icode == 4'b0101) begin   // mrmov operation
      rA = inst[8:11];
      rB = inst[12:15];
      valC = inst[16:79];
      valP = PC + 64'd10;
    end

    else if (icode == 4'b0110) begin   // OPq operation
      rA = inst[8:11];
      rB = inst[12:15];
      valP = PC + 64'd2;
    end

    else if (icode == 4'b0111) begin   // jXX ----> jump operation
      valC = inst[8:71];
      valP = PC + 64'd9;
    end

    else if (icode == 4'b1000) begin   // call operation
      valC = inst[8:71];
      valP = PC + 64'd9;
    end

    else if (icode == 4'b1001) begin   // ret operation
      valP = PC + 64'd1;
    end

    else if (icode == 1010) begin   // push operation
      rA = inst[8:13];
      rB=inst[12:15];
      valP = PC + 64'd2;
    end

    else if (icode == 1011) begin   // pop operation
      rA = inst[8:13];
      rB=inst[12:15];
      valP = PC + 64'd2;
    end

    else inst_valid=0; 

end

endmodule
