module Data_Memory(clk,location,read_En,write_En,m_valM,M_valA,data_memerror);

input clk;
input [63:0] location;
input read_En,write_En;
input [63:0] M_valA;

output reg [63:0] m_valM;
output data_memerror;

reg [7:0] memory [0:1023];

assign data_memerror = ((location + 10 > 1024) & ((read_En != 0) & (write_En != 0) )) ? 1 : 0;

always @ (negedge clk)
begin

  if((write_En ==1) & (data_memerror ==0)) begin
	memory[location]       <= M_valA[7:0];
	memory[location+1]     <= M_valA[15:8];
	memory[location+2]     <= M_valA[23:16];
	memory[location+3]     <= M_valA[31:24];
	memory[location+4]     <= M_valA[39:32];
	memory[location+5]     <= M_valA[47:40];
	memory[location+6]     <= M_valA[55:48];
	memory[location+7]     <= M_valA[63:56];
  end

  if((read_En ==1) & (data_memerror ==0)) begin
	m_valM[7:0]      <= memory[location];       
	m_valM[15:8]     <= memory[location+1];     
	m_valM[23:16]    <= memory[location+2];    
	m_valM[31:24]    <= memory[location+3];     
	m_valM[39:32]    <= memory[location+4];    
	m_valM[47:40]    <= memory[location+5];     
	m_valM[55:48]    <= memory[location+6];     
	m_valM[63:56]    <= memory[location+7];     
  end

  if((write_En ==1) & (data_memerror ==1)) begin
	m_valM[7:0]      <= 8'd0;       
	m_valM[15:8]     <= 8'd0;     
	m_valM[23:16]    <= 8'd0;    
	m_valM[31:24]    <= 8'd0;     
	m_valM[39:32]    <= 8'd0;    
	m_valM[47:40]    <= 8'd0;     
	m_valM[55:48]    <= 8'd0;     
	m_valM[63:56]    <= 8'd0;   
  end
end


endmodule

module instruction_memory(clk,INST,imemory_error,f_pc);

input clk;
input [63:0] f_pc;
output imemory_error;
output reg [79:0] INST;

reg [7:0] memory[1023:0];

always @ (negedge clk)
begin
  INST[79:72] <= memory[f_pc+9];
  INST[71:64] <= memory[f_pc+8];
  INST[63:56] <= memory[f_pc+7];
  INST[55:48] <= memory[f_pc+6];
  INST[47:40] <= memory[f_pc+5];
  INST[39:32] <= memory[f_pc+4];
  INST[31:24] <= memory[f_pc+3];
  INST[23:16] <= memory[f_pc+2];
  INST[15:8]  <= memory[f_pc+1];
  INST[7:0]   <= memory[f_pc];
end

assign data_memerror = (f_pc + 10 > 1024) ? 1 : 0;

 initial begin
    memory[0] = 8'b00110000;  // A = 5;
    memory[1] = 8'b00000000;  // rax
    memory[2] = 8'b00000000;
    memory[3] = 8'b00000000;
    memory[4] = 8'b00000000;
    memory[5] = 8'b00000000;
    memory[6] = 8'b00000000;
    memory[7] = 8'b00000000;
    memory[8] = 8'b00000000;
    memory[9] = 8'b00000110;

    memory[10] = 8'b00110000;  // B =6;
    memory[11] = 8'b00000011;  // rbx
    memory[12] = 8'b00000000;
    memory[13] = 8'b00000000;
    memory[14] = 8'b00000000;
    memory[15] = 8'b00000000;
    memory[16] = 8'b00000000;
    memory[17] = 8'b00000000;
    memory[18] = 8'b00000000;
    memory[19] = 8'b00000101;

    memory[20] = 8'b00010000;  //nop
    memory[21] = 8'b00010000;  //nop
    memory[22] = 8'b00010000; // nop


    memory[23] = 8'b01100000;  //a and b
    memory[24] = 8'b00000011;
    
    // memory[22] = 8'b00010000;  //nop
    // memory[23] = 8'b00010000;  //nop
    // memory[24] = 8'b00000000; // halt
 end

endmodule