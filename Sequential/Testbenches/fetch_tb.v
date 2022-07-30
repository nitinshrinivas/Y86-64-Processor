module fetch_tb;
  reg clk;
  reg  [63:0] PC;
  wire [3:0] icode;
  wire [3:0] ifun;
  wire [3:0] rA;
  wire [3:0] rB; 
  wire [63:0] valC;
  wire [63:0] valP;

  fetch uut(
    .clk(clk),
    .PC(PC),
    .icode(icode),
    .ifun(ifun),
    .rA(rA),
    .rB(rB),
    .valC(valC),
    .valP(valP)
  );
  
  initial begin 

      
    clk=0;
    PC=64'd0;

     #5 clk=~clk;PC=64'd0;
    #5 clk=~clk;
    #5 clk=~clk;PC=valP;
    #5 clk=~clk;
    #5 clk=~clk;PC=valP;
    #5 clk=~clk;
    #5 clk=~clk;PC=valP;

  end 
  
  always@(*) begin
    $monitor("clk=%d PC=%d icode=%b ifun=%b rA=%b rB=%b,valC=%d,valP=%d\n",clk,PC,icode,ifun,rA,rB,valC,valP);
  end
endmodule
