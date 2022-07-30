`include "try.v"

module test;

reg clk;
reg [2:0]  f_stat;
reg [3:0]  f_icode;
reg [3:0]  f_ifun;
reg [3:0]  f_rA;
reg [3:0]  f_rB;
reg [63:0] f_valC;
reg [63:0] f_valP;

wire [2:0]  d_stat;
wire [3:0]  d_icode;
wire [3:0]  d_ifun;
wire [3:0]  d_rA;
wire [3:0]  d_rB;
wire [63:0] d_valC;
wire [63:0] d_valP; 

d_reg uut(.clk(clk),.f_stat(f_stat),.f_icode(f_icode),.f_ifun(f_ifun),.f_rA(f_rA),.f_rB(f_rB),.f_valP(f_valP),.f_valC(f_valC),.d_stat(d_stat),.d_icode(d_icode),.d_ifun(d_ifun),.d_rA(d_rA),.d_rB(d_rB),.d_valC(d_valC),.d_valP(d_valP));

initial begin

clk = 0;
  // f_status[0] = 1;
  // f_status[1] = 0;
  // f_status[2] = 0;
  // f_status[3] = 0;
  f_ifun = 4'b0110;
  f_icode = 4'b0000;
  f_rA = 4'b0011;
  f_rB = 4'b0000;
  f_valC = 64'd100;
  f_valP = 64'd64;

  $display("clk=%d d_ifun=%d d_icode=%b d_rA=%b d_rB=%b,d_valC=%d,d_valP=%d\n",clk,f_ifun,f_icode,f_rA,f_rB,f_valC,f_valP);

  #5 clk=~clk;PC=64'd0;
    #5 clk=~clk;
    #5 clk=~clk;PC=PC_updated;
    #5 clk=~clk;
    #5 clk=~clk;PC=PC_updated;
    #5 clk=~clk;
    #5 clk=~clk;PC=PC_updated;
  
end

always@(*) begin
  $monitor("clk=%d d_ifun=%d d_icode=%b d_rA=%b d_rB=%b,d_valC=%d,d_valP=%d\n",clk,d_ifun,d_icode,d_rA,d_rB,d_valC,d_valP);
end




endmodule

