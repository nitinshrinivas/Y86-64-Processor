`include "writeBack_reg.v"

module test();

reg clk;
reg [3:0]  m_status;
reg [3:0]  m_icode;
reg [3:0]  m_ifun;
reg [3:0]  m_rA;
reg [3:0]  m_rB;
reg [63:0] m_valC;
reg [63:0] m_valP;
reg [63:0] m_valA;
reg [63:0] m_valB;

wire [3:0]  w_status;
wire [3:0]  w_icode;
wire [3:0]  w_ifun;
wire [63:0] w_valA;
wire [63:0] w_valB;
wire [63:0] w_valC;
wire [63:0] w_valP;
wire [3:0]  w_rA;
wire [3:0]  w_rB;

writeBack uut3(.clk(clk),.m_status(m_status),.m_icode(m_icode),.m_ifun(m_ifun),.m_rA(m_rA),.m_rB(m_rB),.m_valC(m_valC),.m_valP(m_valP),.m_valA(m_valA),.m_valB(m_valB),
                .w_icode(w_icode),.w_ifun(w_ifun),.w_status(w_status),.w_rA(w_rA),.w_rB(w_rB),.w_valC(w_valC),.w_valP(w_valP),.w_valA(w_valA),.w_valB(w_valB));


initial begin

clk = 0;
  // f_status[0] = 1;
  // f_status[1] = 0;
  // f_status[2] = 0;
  // f_status[3] = 0;
  m_ifun = 4'b0110;
  m_icode = 4'b0000;
  m_rA = 4'b0011;
  m_rB = 4'b0000;
  m_valC = 64'd100;
  m_valP = 64'd64;
  m_valA=64'd10;
  m_valB=64'd11;



  #10 clk=~clk;
  #10 clk=~clk;
  #10 clk=~clk;
  #10 clk=~clk;
  #10 clk=~clk;
  #10 clk=~clk;
  
end


always@(*) begin
  $monitor("clk=%d w_ifun=%d w_icode=%b w_rA=%b w_rB=%b, w_valA=%d, w_valB=%d\n",clk,w_ifun,w_icode,w_rA,w_rB,w_valA,w_valB);
end

endmodule
