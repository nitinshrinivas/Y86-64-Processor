module decode(clk,icode,rA,rB,valA,valB,valC,valE,valM,cnd,reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,reg_mem6,reg_mem7,reg_mem8,reg_mem9,reg_mem10,reg_mem11,reg_mem12,reg_mem13,reg_mem14);

input clk;
input [3:0] icode;
reg [63:0] reg_mem [14:0];
input [3:0] rA;
input [3:0] rB;
output reg [63:0] valA;
output reg [63:0] valB;
input [63:0] valC;
input [63:0] valE;
input [63:0] valM;
//output reg [63:0] test;
input cnd;

output reg [63:0] reg_mem0;
output reg [63:0] reg_mem1;
output reg [63:0] reg_mem2;
output reg [63:0] reg_mem3;
output reg [63:0] reg_mem4;
output reg [63:0] reg_mem5;
output reg [63:0] reg_mem6;
output reg [63:0] reg_mem7;
output reg [63:0] reg_mem8;
output reg [63:0] reg_mem9;
output reg [63:0] reg_mem10;
output reg [63:0] reg_mem11;
output reg [63:0] reg_mem12;
output reg [63:0] reg_mem13;
output reg [63:0] reg_mem14;

 initial begin
     reg_mem[0]=reg_mem0;
     reg_mem[1]=reg_mem1;
     reg_mem[2]=reg_mem2;
     reg_mem[3]=reg_mem3;
     reg_mem[4]=reg_mem4;
     reg_mem[5]=reg_mem5;
     reg_mem[6]=reg_mem6;
     reg_mem[7]=reg_mem7;
     reg_mem[8]=reg_mem8;
     reg_mem[9]=reg_mem9;
     reg_mem[10]=reg_mem10;
     reg_mem[11]=reg_mem11;
     reg_mem[12]=reg_mem12;
     reg_mem[13]=reg_mem13;
     reg_mem[14]=reg_mem14;

 end

always @(*)
begin
    // if(icode == 4'b0000) begin        // halt
    //   valA = 0;
    //   valB = 0;
    // end

    // else if(icode == 4'b0001) begin   // no operation
    //   valA = 0;
    //   valB = 0;
    // end

    if(icode == 4'b0010) begin  // cmove operation
      valA = reg_mem[rA];
    end

    else if(icode == 4'b0100) begin  // rmmove operation
      valA = reg_mem[rA];
      valB = reg_mem[rB];
    end

    else if(icode == 4'b0101) begin  // mrmove operation
      //valA = reg_mem[rA];
      valB = reg_mem[rB];
    end

    else if(icode == 4'b0110) begin  // OPq
      valA = reg_mem[rA];
      valB = reg_mem[rB];
    end

    else if(icode == 4'b1000) begin  // call operation
      valB = reg_mem[4];
    end
    
    else if(icode == 4'b1001) begin  // return operation
      valA = reg_mem[4];
      valB = reg_mem[4];
    end

    else if(icode == 4'b1010) begin  // push operation
      valA = reg_mem[rA];
      valB = reg_mem[4];
    end

    else if(icode == 4'b1011) begin //pop operation
      valA = reg_mem[4];
      valB = reg_mem[4];
    end

    reg_mem0=reg_mem[0];
    reg_mem1=reg_mem[1];
    reg_mem2=reg_mem[2];
    reg_mem3=reg_mem[3];
    reg_mem4=reg_mem[4];
    reg_mem5=reg_mem[5];
    reg_mem6=reg_mem[6];
    reg_mem7=reg_mem[7];
    reg_mem8=reg_mem[8];
    reg_mem9=reg_mem[9];
    reg_mem10=reg_mem[10];
    reg_mem11=reg_mem[11];
    reg_mem12=reg_mem[12];
    reg_mem13=reg_mem[13];
    reg_mem14=reg_mem[14];
end

 always @(negedge clk) 
begin
    if(icode==4'b0010) begin //cmovxx
      if(cnd==1'b1) reg_mem[rB]=valE;
    end
    else if(icode == 4'b0011) begin        // irmovq $0xx rB
      reg_mem[rB] = valE;       // Here the rB register will store the final result
    end

    else if(icode == 4'b0101) begin   // mrmovq D(rB) rA
     reg_mem[rA] = valM;     // Here the rA register will store the final result 
    end

    else if(icode == 4'b0110) begin  // OPq rA rB
      reg_mem[rB] = valE;     // Here the rB register will store the final result
    end

    else if(icode == 4'b1000) begin  // call Dest
      reg_mem[4] = valE;       // Here reg_mem[4] is the %esp(stack pointer) .Update stack pointer
    end

    else if(icode == 4'b1001) begin  // ret
      reg_mem[4] = valE;      // reg_mem[4] is the %esp and we upadate the stack pointer
    end

    else if(icode == 4'b1010) begin  // pushq 
       reg_mem[4] = valE;     // In push we first decrement the address and then push the data. 
    end

    else if(icode == 4'b1011) begin  // popq
        reg_mem[4] = valE;   // In this first we pop out the data from the stack and then increment the address.
        reg_mem[rA] = valM;   // So, the popped out data is again restored in register  rA
    end
    reg_mem0=reg_mem[0];
    reg_mem1=reg_mem[1];
    reg_mem2=reg_mem[2];
    reg_mem3=reg_mem[3];
    reg_mem4=reg_mem[4];
    reg_mem5=reg_mem[5];
    reg_mem6=reg_mem[6];
    reg_mem7=reg_mem[7];
    reg_mem8=reg_mem[8];
    reg_mem9=reg_mem[9];
    reg_mem10=reg_mem[10];
    reg_mem11=reg_mem[11];
    reg_mem12=reg_mem[12];
    reg_mem13=reg_mem[13];
    reg_mem14=reg_mem[14];

end

endmodule
