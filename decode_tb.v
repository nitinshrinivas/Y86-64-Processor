
module decode_tb;
  reg clk;
  reg [3:0] icode;
  reg [3:0] rA;
  reg [3:0] rB; 
  wire [63:0] valA;
  wire [63:0] valB;
  reg [63:0] valM;
  reg [63:0] valE;
  wire [63:0] test;


  decode uut(
    .clk(clk),
    .icode(icode),
    .rA(rA),
    .rB(rB),
    .valA(valA),
    .valB(valB),
    .valE(valE),
    .valM(valM),
    .test(test)
  );
  
  initial begin 

      
    clk=0;

    #10 clk=~clk; rA =0 ; rB=0 ;icode=4'b0101; valE=64'd100; valM=64'd101;
    #10 clk=~clk;
    #10 clk=~clk;rA=1;rB=0; icode =4'b1000;
    #10 clk=~clk;
    #10 clk=~clk; rA=4;rB=3; icode=4'b0110;
    #10 clk=~clk;

  end 
  
  always@(*) begin
    $monitor("clk=%d icode=%b rA=%b rB=%b,valA=%d,valB=%d test=%d valM=%d\n",clk,icode,rA,rB,valA,valB,test,valM);
  end
endmodule
