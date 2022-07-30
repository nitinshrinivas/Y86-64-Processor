`include "fetch.v"
`include "pc_update.v"
`include "fetch_reg.v"

module fetch_tb;
  reg clk;
  reg  [63:0] PC;
  wire [3:0] icode;
  wire [3:0] ifun;
  wire [3:0] rA;
  wire [3:0] rB; 
  wire [63:0] valC;
  wire [63:0] valP;
  wire [63:0] valM;
  wire [63:0] PC_updated;
  wire [63:0] f_pc;

  fetch uut1(
    .clk(clk),
    .PC(PC),
    .icode(icode),
    .ifun(ifun),
    .rA(rA),
    .rB(rB),
    .valC(valC),
    .valP(valP)
  );
  
  pc_update uut(
    .clk(clk),
    .icode(icode),
    .valC(valC),
    .valP(valP),
    .PC_updated(PC_updated)
  );
  
  fetch_reg uut2(
    .clk(clk),
    .predicted_pc(PC_updated),
    .pipe_line_pc(f_pc)
  );

  initial begin 

      
    clk=0;
    PC=64'd0;

    #5 clk=~clk;PC=64'd0;
    #5 clk=~clk;
    #5 clk=~clk;PC=PC_updated;
    #5 clk=~clk;
    #5 clk=~clk;PC=PC_updated;
    #5 clk=~clk;
    #5 clk=~clk;PC=PC_updated;

  end 
  
  always@(*) begin
    $monitor("clk=%d PC=%d icode=%b ifun=%b rA=%b rB=%b,valC=%d,valP=%d,f_pc=%d\n",clk,PC,icode,ifun,rA,rB,valC,valP,f_pc);
  end
endmodule
