// This is the first attempt to the pipelining.
// Here we have some clock problems which an be rectified using reset and enables.  
// The execute stage is giving output as z for valB and valA is verified to be correct.
// 
// This is perfectly workiing for operations without valA and valB.
// Data forwarding is not completly attempted in this.

//............................................Worked for only few cases. This gave us to start in new logic.......................................................

`include "fetch.v"
`include "pc_update.v"
`include "fetch_reg.v"
`include "decode_reg.v"
`include "execute_reg.v"
`include "memory_reg.v"
`include "writeBack_reg.v"

module pipe_processor;

reg clk;
reg [63:0]PC;
wire [63:0]PC_updated;



wire [3:0]  f_status;
wire [63:0] f_valC;
wire [63:0] f_valP;
wire [3:0]  f_icode;
wire [3:0]  f_ifun;
wire [3:0]  f_rA;
wire [3:0]  f_rB;
wire [63:0] f_pc;

wire cnd;

wire [3:0]  d_status;
wire [63:0] d_valC;
wire [63:0] d_valP;
wire [3:0]  d_icode;
wire [3:0]  d_ifun;
wire [3:0]  d_rA;
wire [3:0]  d_rB;
wire [63:0] d_pc;

wire [3:0]  e_status;
wire [63:0] e_valC;
wire [63:0] e_valP;
wire [3:0]  e_icode;
wire [3:0]  e_ifun;
wire [3:0]  e_rA;
wire [3:0]  e_rB;
wire [63:0] e_pc;
wire [63:0] e_valA;
wire [63:0] e_valB;

wire [3:0]  m_status;
wire [63:0] m_valC;
wire [63:0] m_valP;
wire [3:0]  m_icode;
wire [3:0]  m_ifun;
wire [3:0]  m_rA;
wire [3:0]  m_rB;
wire [63:0] m_pc;
wire [63:0] m_valA;
wire [63:0] m_valB;
wire [63:0] m_valE;

wire [3:0]  w_status;
wire [63:0] w_valC;
wire [63:0] w_valP;
wire [3:0]  w_icode;
wire [3:0]  w_ifun;
wire [3:0]  w_rA;
wire [3:0]  w_rB;
wire [63:0] w_pc;
wire [63:0] w_valA;
wire [63:0] w_valB;
wire [63:0] w_valE;
wire [63:0] w_valM;

wire hlt;
wire inst_valid;
wire mem_error;


fetch_reg B1(
  .clk(clk),.predicted_pc(PC_updated),.pipe_line_pc(f_pc)
);
  
fetch B2(
  .clk(clk),.PC(PC),.icode(f_icode),.ifun(f_ifun),.rA(f_rA),.rB(f_rB),.valC(f_valC),.valP(f_valP),.hlt(hlt)
);


decode_reg B3(
  .clk(clk),.f_status(f_status),.f_icode(f_icode),.f_ifun(f_ifun),.f_rA(f_rA),.f_rB(f_rB),.f_valC(f_valC),.f_valP(f_valP),
  .d_status(d_status),.d_icode(d_icode),.d_ifun(d_ifun),.d_rA(d_rA),.d_rB(d_rA),.d_valC(d_valC),.d_valP(d_valP)
);

execute_reg B4(
  .clk(clk),.d_status(d_status),.d_icode(d_icode),.d_ifun(d_ifun),.d_rA(d_rA),.d_rB(d_rB),.d_valC(d_valC),.d_valP(d_valP),
  .e_status(e_status),.e_icode(e_icode),.e_ifun(e_ifun),.e_valA(e_valA),.e_valB(e_valB),.e_valC(e_valC),.e_valP(e_valP),.e_rA(e_rA),.e_rB(e_rB)
);

memory_reg B5(
  .clk(clk),.e_rA(e_rA),.e_rB(e_rB),.m_rA(m_rA),.m_rB(m_rB),.e_icode(e_icode),.e_ifun(e_ifun),.e_valA(e_valA),.e_valB(e_valB),.e_valP(e_valP),
  .e_valC(e_valC),.e_status(e_status),.m_icode(m_icode),.m_status(m_status),.m_ifun(m_ifun),.m_valE(m_valE),.m_cnd(m_cnd),
  .m_valC(m_valC),.m_valP(m_valP),.m_valA(m_valA),.m_valB(m_valB)
);

writeBack_reg B6(
  .clk(clk),.m_status(m_status),.m_icode(m_icode),.m_rA(m_rA),.m_rB(m_rB),.m_ifun(m_ifun),.m_valE(m_valE),.m_valC(m_valC),.m_valP(m_valP),
  .w_status(w_status),.w_icode(w_icode),.w_ifun(w_ifun),.w_valE(w_valE),.w_valM(w_valM),.w_cnd(w_cnd),.w_rA(w_rA),.w_rB(w_rB),
  .w_valP(w_valP),.w_valC(w_valC)
);

pc_update B7(
  .clk(clk),.icode(f_icode),.valC(f_valC),.valP(f_valP),.PC_updated(PC_updated)
);


initial begin
  
  clk = 0;

     #5 clk=~clk;PC=64'd0;
    #5 clk=~clk;
    #5 clk=~clk;PC=PC_updated;
    #5 clk=~clk;
    #5 clk=~clk;PC=PC_updated;
    #5 clk=~clk;
    #5 clk=~clk;PC=PC_updated;

end

always@(*) begin
    begin
    $monitor("clk=%d hlt=%d PC=%d icode=%b ifun=%b rA=%b rB=%b,valC=%d,valA=%d,valB=%d valE=%b,valM=%d,f_pc=%d\n",clk,hlt,PC,f_icode,f_ifun,f_rA,f_rB,f_valC,w_valA,w_valB,w_valE,w_valM,w_pc);
    end
  end
endmodule
