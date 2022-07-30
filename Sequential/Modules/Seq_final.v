`include "fetch.v"
`include "decode.v"
`include "execute.v"
`include "memory.v"
`include "pc_update.v"

module seq_processor;

reg clk;
reg [63:0]PC;
wire [63:0]PC_updated;
reg [3:0]status; //aop-----hlt-------memory_error----instruction_error

wire [63:0]valA;
wire [63:0]valB;
wire [63:0]valC;
wire [63:0]valP;
wire [63:0]valE;
wire [63:0]valM;
wire [3:0] icode;
wire [3:0] ifun;
wire [3:0] rA;
wire [3:0]rB;
wire cnd;
wire [63:0]test;
wire OF;
wire SF;
wire ZF;
wire hlt;
wire inst_valid;
wire mem_error;
wire [63:0]Mem_output;

wire [63:0]reg_mem0;
wire [63:0] reg_mem1;
wire [63:0] reg_mem2;
wire [63:0] reg_mem3;
wire [63:0] reg_mem4;
wire [63:0] reg_mem5;
wire [63:0] reg_mem6;
wire [63:0] reg_mem7;
wire[63:0] reg_mem8;
wire [63:0] reg_mem9;
wire [63:0] reg_mem10;
wire [63:0] reg_mem11;
wire [63:0] reg_mem12;
wire [63:0] reg_mem13;
wire [63:0] reg_mem14;

//fetch stage
  fetch A1(
    .clk(clk),
    .PC(PC),
    .icode(icode),
    .ifun(ifun),
    .rA(rA),
    .rB(rB),
    .valC(valC),
    .valP(valP),
    .hlt(hlt)
  );
 
//execute stage
execute uut1(.clk(clk),.icode(icode),.valA(valA),.valC(valC),.valE(valE),.valB(valB),.ifun(ifun),.OF(OF),.SF(SF),.ZF(ZF),.cnd(cnd));

//decode stage
  decode C1(
    .clk(clk),
     .valC(valC),
    .icode(icode),
    .rA(rA),
    .rB(rB),
    .valA(valA),
    .valB(valB),
    .valE(valE),
    .valM(valM),
    .reg_mem0(reg_mem0),
    .reg_mem1(reg_mem1),
    .reg_mem2(reg_mem2),
    .reg_mem3(reg_mem3),
    .reg_mem4(reg_mem4),
    .reg_mem5(reg_mem5),
    .reg_mem6(reg_mem6),
    .reg_mem7(reg_mem7),
    .reg_mem8(reg_mem8),
    .reg_mem9(reg_mem9),
    .reg_mem10(reg_mem10),
    .reg_mem11(reg_mem11),
    .reg_mem12(reg_mem12),
    .reg_mem13(reg_mem13),
    .reg_mem14(reg_mem14)
  );

//memory stage
memory D1(.icode(icode),.valM(valM),.valP(valP),.valE(valE),.valA(valA),.valB(valB),.Mem_output(Mem_output));

//pc_update
pc_update E1(.clk(clk),.icode(icode),.valP(valP),.cnd(cnd),.valC(valC),.valM(valM),.PC_updated(PC_updated));

initial begin
  status[0]=1;
  status[1]=0;
  status[2]=0;
  status[3]=1;

  
  clk = 0;

    #10 clk=~clk;PC=64'd0;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;

end

always@(*) begin
  status[1]=hlt;
  status[2]=mem_error;
  status[3]=inst_valid;
    if(status[1] == 1 || status[2]==1 || status[3]==0 || status[0]==0) begin
      $finish;
    end
    else
    begin
    $monitor("clk=%d hlt=%d PC=%d icode=%b ifun=%b rA=%b rB=%b,valC=%d,valA=%d,valB=%d valE=%b,valM=%d\n",clk,hlt,PC,icode,ifun,rA,rB,valC,valA,valB,valE,valM);
    end
  end
endmodule
