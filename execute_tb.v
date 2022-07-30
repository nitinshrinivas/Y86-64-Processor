`include "execute.v"

module execute_tb;
reg clk;
reg [3:0] icode;
reg [63:0] valA;
reg [63:0] valB;
reg [3:0] ifun;
wire OF,SF,ZF;
wire cnd;

execute uut(.clk(clk),.icode(icode),.valA(valA),.valB(valB),.ifun(ifun),.OF(OF),.SF(SF),.ZF(ZF),.cnd(cnd));

initial begin

clk=0;
#10 clk=~clk; valA=64'b1111111111111111111111111111111111111111111111111111111111111111; valB=64'b1111111111111111111111111111111111111111111111111111111111111111 ; icode= 4'b0110;ifun=4'b0000 ;
#10 clk=~clk;
#10 clk=~clk; icode = 4'b0010; ifun=4'b0010;
#10 clk=~clk;

end
always@(*) begin
    $monitor("clk=%d icode=%b valA=%b valB=%b,ifun=%d, OF=%b ZF=%b SF=%b cnd=%b\n",clk,icode,valA,valB,ifun,OF,ZF,SF,cnd);
  end

endmodule