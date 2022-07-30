`include "execute_reg.v"

module test();

reg clk;
reg [3:0]  d_status;
reg [3:0]  d_icode;
reg [3:0]  d_ifun;
reg [3:0]  d_rA;
reg [3:0]  d_rB;
reg [63:0] d_valC;
reg [63:0] d_valP;

wire [3:0]  e_status;
wire [3:0]  e_icode;
wire [3:0]  e_ifun;
wire [63:0]  e_valA;
wire [63:0]  e_valB;
wire [63:0] e_valC;
wire [63:0] e_valP;
wire [3:0]  e_rA;
wire [3:0]  e_rB;

execute_reg uut3(.clk(clk),.d_status(d_status),.d_icode(d_icode),.d_ifun(d_ifun),.d_rA(d_rA),.d_rB(d_rB),.d_valC(d_valC),.d_valP(d_valP),
                .e_icode(e_icode),.e_ifun(e_ifun),.e_status(e_status),.e_rA(e_rA),.e_rB(e_rB),.e_valC(e_valC),.e_valP(e_valP),.e_valA(e_valA),.e_valB(e_valB));


initial begin

clk = 0;
  // f_status[0] = 1;
  // f_status[1] = 0;
  // f_status[2] = 0;
  // f_status[3] = 0;
  d_ifun = 4'b0000;
  d_icode = 4'b0110;
  d_rA = 4'b0110;
  d_rB = 4'b0110;
  d_valC = 64'd100;
  d_valP = 64'd64;



  #10 clk=~clk;
  #10 clk=~clk;
  #10 clk=~clk;
  #10 clk=~clk;
  #10 clk=~clk;
  #10 clk=~clk;
  
end


always@(*) begin
  #1
  $monitor("clk=%d e_ifun=%d e_icode=%b e_rA=%b e_rB=%b,e_valC=%d,e_valP=%d , e_valA=%d, e_valB=%d\n",clk,e_ifun,e_icode,e_rA,e_rB,e_valC,e_valP,e_valA,e_valB);
end

endmodule
