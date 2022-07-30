`include "memory_reg.v"

module test();

reg clk;
reg [3:0]  e_status;
reg [3:0]  e_icode;
reg [3:0]  e_ifun;
reg [3:0]  e_rA;
reg [3:0]  e_rB;
reg [63:0] e_valC;
reg [63:0] e_valP;
reg [63:0] e_valA;
reg [63:0] e_valB;

wire [3:0]  m_status;
wire [3:0]  m_icode;
wire [3:0]  m_ifun;
wire [63:0]  m_valA;
wire [63:0]  m_valB;
wire [63:0] m_valC;
wire [63:0] m_valP;
wire [3:0]  m_rA;
wire [3:0]  m_rB;

memory_reg uut3(.clk(clk),.e_status(e_status),.e_icode(e_icode),.e_ifun(e_ifun),.e_rA(e_rA),.e_rB(e_rB),.e_valC(e_valC),.e_valP(e_valP),.e_valA(e_valA),.e_valB(e_valB),
                .m_icode(m_icode),.m_ifun(m_ifun),.m_status(m_status),.m_rA(m_rA),.m_rB(m_rB),.m_valC(m_valC),.m_valP(m_valP),.m_valA(m_valA),.m_valB(m_valB));


initial begin

clk = 0;
  // f_status[0] = 1;
  // f_status[1] = 0;
  // f_status[2] = 0;
  // f_status[3] = 0;
  e_ifun = 4'b0110;
  e_icode = 4'b0000;
  e_rA = 4'b0011;
  e_rB = 4'b0000;
  e_valC = 64'd100;
  e_valP = 64'd64;
  e_valA=64'd10;
  e_valB=64'd11;



  #10 clk=~clk;
  #10 clk=~clk;
  #10 clk=~clk;
  #10 clk=~clk;
  #10 clk=~clk;
  #10 clk=~clk;
  
end


always@(*) begin
  $monitor("clk=%d m_ifun=%d m_icode=%b m_rA=%b m_rB=%b,m_valC=%d,m_valP=%d , m_valA=%d, m_valB=%d\n",clk,m_ifun,m_icode,m_rA,m_rB,m_valC,m_valP,m_valA,m_valB);
end

endmodule
