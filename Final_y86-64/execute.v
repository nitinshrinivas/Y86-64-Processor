`include "alu.v"


//----------->ALU
module ALU(valA,valB,ifun,valE,conditional_codes);
// Here we defined all the operations in OPq and we also set the valE and conditional codes

input [63:0] valA,valB;
input [3:0] ifun;
output [63:0] valE;
output [2:0] conditional_codes;
wire [63:0] Add_out;
wire [63:0] Sub_out;
wire [63:0] Xor_out;
wire [63:0] And_out;
Add A1(.x(valA),.y(valB),.Sum(Add_out));
Sub A2(.x(valA),.y(valB),.out(Sub_out));
Xor A3(.x(valA),.y(valB),.out(Xor_out));
And A4(.x(valA),.y(valB),.out(And_out));
assign valE= (ifun==4'h0) ? Add_out : ((ifun==4'h1) ? Sub_out : ((ifun == 4'h2) ? And_out : ((ifun == 4'h3) ? Xor_out : Add_out)));  

assign conditional_codes[2] = (valE == 64'h0) ? 1 : 0;
assign conditional_codes[1] = (valE[63] == 1'b1) ? 1 : 0;
assign conditional_codes[0] = ((valA[63] == 0 | valB[63] ==0) & (valE[63] == 1)) | ((valA[63] == 1 | valB[63] ==1) & (valE[63] == 0)) ? 1 : 0;


endmodule


//--------------------> ValA and ValB
module modified_valA_valB(icode,valC,valA,valB,ValA,ValB);

input [3:0] icode;
input [63:0] valC, valA , valB;
output [63:0] ValA, ValB;


assign ValA = ((icode==4'd2|icode==4'd6) ? valA : ((icode==4'd3|icode==4'd4|icode==4'd5) ? valC :
	((icode==4'd7) ? 64'd0 : ((icode==4'd8|icode==4'd10) ? 64'd8 : 
	((icode==4'd9|icode==4'd11) ? 64'b111111111111111111111111111111111111111111111111111111111111111 : 64'd0)))));
	
assign ValB = ((icode==4'd2|icode==4'd3|icode==4'd7) ? 64'd0 :
	((icode==4'd4|icode==4'd5|icode==4'd6|icode==4'd8|icode==4'd9|icode==4'd10|icode==4'd11) ? valB : 64'd0));

endmodule

//-------------> Destination is found here

module set_dstE(E_dstE,E_icode,e_cnd,e_dstE);

input [3:0] E_icode,E_dstE;
input e_cnd;
output [3:0] e_dstE;

	assign e_dstE = (E_icode==4'h2 & e_cnd ==0 ) ? 4'd15 : E_dstE;

endmodule

