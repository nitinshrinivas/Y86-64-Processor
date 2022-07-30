
//----------->split
module split(address,werror_icode,werror_ifun);

// In this module we are taking the instructuction address and splitting the icode and ifun
// Get values of icode and ifun 

input [7:0] address;
output [3:0] werror_icode;
output [3:0] werror_ifun;

assign werror_icode = address[3:0];
assign werror_ifun  = address[7:4];

endmodule


//--------> align 
module align(rA,rB,valC,need_reg,iremain_addr);

// Get the values of the rA, rB, valC

input [71:0] iremain_addr;
input need_reg;
output [3:0] rA;
output [3:0] rB;
output [63:0] valC;

assign rA = iremain_addr[3:0];
assign rB = iremain_addr[7:4];
// if(need_reg) begin
//     assign valC = iremain_addr[63:0];
// end
// else assign valC = iremain_addr[71:8];

assign valC = need_reg ? iremain_addr[71:8]: iremain_addr [63:0];

endmodule

//-----> updated icode and ifun
module final_icode_ifun(werror_icode,werror_ifun,imemory_error,icode,ifun);

// This module is to compute the real value of the icode and ifun 
// If there is error in the address of the instruction then we have to nop operation.
// Assign icode to 0001 and ifun to 0000

input imemory_error;
input [3:0] werror_icode;
input [3:0] werror_ifun;
output [3:0] icode;
output [3:0] ifun;

assign icode = imemory_error ? 4'd1 : werror_icode;
assign ifun = imemory_error ? 4'd0 : werror_ifun;

endmodule


module need_reg_valC_insterror(icode,need_reg,need_valC,instruction_error);

// we do not want the registers for nop,halt,jump,call,return
// we do not want the valC for halt, nop, cmovxx ,opq, return, pushq, popq

input [3:0] icode;
output need_reg;
output need_valC;
output instruction_error;

assign instruction_error = (icode == 4'd0 | icode == 4'd1 | icode == 4'd2 | icode == 4'd3 |icode == 4'd4 | icode == 4'd5 | icode == 4'd6 | icode == 4'd7 | icode == 4'd8 | icode == 4'd9 | icode == 4'd10 | icode == 4'd11 ) ? 0 : 1; 

assign need_reg = (icode == 4'd0 | icode == 4'd1 | icode == 4'd7 | icode == 4'd8 | icode == 4'd9 ) ? 0 : 1;  
assign need_valC = (icode == 4'd0 | icode == 4'd1 | icode == 4'd2 | icode == 4'd6 | icode == 4'd9 | icode == 4'd10 | icode == 4'd11) ? 0 : 1;

endmodule

//-----> status
module Status(icode,status,instruction_error,imemory_error);

// 1 is aok
// 2 is halt
// 3 is i_mem error
// 4 is instrution error 

input [3:0] icode;
input instruction_error;
input imemory_error;
output [2:0] status;

assign status = (icode == 4'd0) ? 3'd2 : ((imemory_error == 1) ? 3'd3 : ((instruction_error == 1) ? 3'd4 : 3'd1));   

endmodule

