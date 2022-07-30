
//-----> Incrementing PC based on need registers and valC
module next_PC(valP,PC,need_reg,need_valC);

// valC is 8 bytes
// reg is of 1 byte 
// address is of 1 byte

input need_reg;
input need_valC;
input [63:0] PC;
output [63:0] valP;

// if(need_reg == 1 & need_valC == 1) assign valP = PC + 10;
// else if(need_reg == 0 & need_valC == 1) assign valP = PC + 9;
// else if(need_reg == 1 & need_valC == 0) assign valP = PC + 2;
// else assign valP = PC + 1;

assign valP = (need_reg == 1 & need_valC == 1) ? PC + 10 : ((need_reg == 0 & need_valC == 1) ?  PC + 9 : ((need_reg == 1 & need_valC == 0) ? PC +2 : PC+1));

endmodule


//-----> predicting PC
module predict_PC(valP,valC,icode,predicted_pc);

// we need to jump directly for jump instrutions to valC
// we need to jump to valC for the call function. 

input [3:0] icode;
input [63:0] valP;
input [63:0] valC;
output [63:0] predicted_pc;

assign predicted_pc = (icode == 4'd7 & icode == 4'd8) ? valC : valP; 

endmodule



//-------> Selecting_PC
module select_PC(predicted_pc,correct_pc,M_cnd,M_icode,W_icode,M_valA,W_valM);

// for jump not satisfied we correct the nxt PC to M_valA
// for return we corerct the pc to W_valM else the predicted PC is the correct PC 

input [63:0] predicted_pc;
input M_cnd;
input [3:0] M_icode;
input [3:0] W_icode;
input [63:0] M_valA;
input [63:0] W_valM;

output [63:0] correct_pc;

assign correct_pc = ((M_cnd == 0) & (M_icode == 4'd7)) ? M_valA : ((W_icode == 4'd9) ? W_valM : predicted_pc);

endmodule 
