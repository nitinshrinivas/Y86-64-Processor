
//----------> we need to assign registers to store value based on given icode.......Here set is happened
module set_register(icode,rA,rB,RA,RB);

// if we have the cmov,rmmovq,opq and push then it is rA
// if return or pop comes then it is RSP or r[4] else it is set to no-reg 

// if we have the mrmovq,rmmovq,opq then it is rB
// if call ,return or pop or push comes then it is RSP or r[4] else it is set to no-reg

input [3:0] icode;
input [3:0] rA;
input [3:0] rB;
output [3:0] RA;
output [3:0] RB;

assign RA = ((icode == 4'd2) | (icode == 4'd4) | (icode == 4'd6) | (icode == 4'd10)) ? rA : (((icode == 4'd9) | (icode == 4'd11)) ? 4'h4 : 4'd15);
assign RB = ((icode == 4'd4) | (icode == 4'd5) | (icode == 4'd6))  ? rB : (((icode == 4'd9)| (icode == 4'd8) | (icode == 4'd10) |(icode == 4'd11)) ? 4'd4 : 4'd15);

endmodule


//-------> selecting valA and valB
module selectvalAvalB(valA,valB,icode,valP,RA,RB,e_dstE,e_valE,M_dstM,M_dstE,m_valM,M_valE,W_dstM,W_valM,W_dstE,W_valE,Ra,Rb);
					  
	output [63:0] valA,valB;
	input [3:0] icode;
    input [3:0] RA,RB;
    input [3:0] e_dstE,M_dstM,M_dstE,W_dstM,W_dstE;
	input [63:0] Ra,Rb,valP,e_valE,m_valM,M_valE,W_valM,W_valE;

    
	assign valA = ((icode==4'd8|icode==4'd7)?valP:(((RA==e_dstE)&(e_dstE==4'd15))?e_valE:(((RA==M_dstM)&(M_dstM==4'd15))?m_valM: (((RA==M_dstE)&(M_dstE==4'd15))?M_valE:(((RA==W_dstE)&(W_dstE==4'd15))?W_valE:(((RA==W_dstM)&~(W_dstM==4'd15))?W_valM:Ra))))));
	
	assign valB = (((RB==e_dstE)&(e_dstE==4'd15))?e_valE:(((RB==M_dstM)&(M_dstM==4'd15))?m_valM:(((RB==M_dstE)&~(M_dstE==4'd15))?M_valE:(((RB==W_dstM)&(W_dstM==4'd15))?W_valM:(((RB==W_dstE)&(W_dstE==4'd15))?W_valE:Rb)))));

endmodule


//--------------> Destination register
module DestSET_E_M(icode,destE,destM,rA,rB);

// set the values of the destination for the valE and valM.
// for add, cmovq,irmovq we set the destination of valE as rB.
// for push pop return and call we set the destination of valE as rsp.
// for mrmovq and pop we set the destination of the ValM to be rA else the no register for all the other operations. as it is of no use.

input [3:0] icode;
input [3:0] rA,rB;
output [3:0] destE,destM;

assign destE = ((icode == 4'd2) | (icode == 4'd3) | (icode == 4'd6)) ? rB : (((icode == 4'd8) | (icode == 4'd9) | (icode == 4'd10) | (icode == 4'd11)) ? 4'd4 : 4'd15);
assign destM = ((icode == 4'd5) | (icode == 4'd11)) ? rA : 4'd15;

endmodule