
//-----------> finding the address
module addresses(icode,location,valE,valA);

// This module is to send to set the values of the address of the location where in if we have the 
// rmmovq, mrmovq, pushq, call ---> valE
// return , pop ----> valA
input [3:0] icode;
input [63:0] valE;
input [63:0] valA;
output [63:0] location;

assign location = ((icode == 4'd4 ) | (icode == 4'd5) | (icode == 4'd8) | (icode == 4'd10)) ? valE : valA;

endmodule


//----------> Set read and write enabled
module set_read_write_enables(icode , write_En, read_En);
// this module is to gice controln over the read-write operation into the memory.
input [3:0] icode;
output write_En;
output read_En;

assign write_En = ((icode == 4'd4) | (icode == 4'd8) | (icode == 4'd10)) ? 1 : 0;
assign read_En  = ((icode == 4'd5) | (icode == 4'd9) | (icode == 4'd11)) ? 1 : 0;

endmodule


//------->  For finding stat
module set_status_with_memerror(icode,status,new_status,data_memerror);

// if there is memory included in the file and there is data_memory error then status will be updated.
input [3:0] icode;
input [2:0] status;
input data_memerror;
output [2:0] new_status;

assign new_status = ((icode == 4'd4) | (icode == 4'd5) | (icode == 4'd8) | (icode == 4'd9) | (icode == 4'd10) | (icode == 4'd11) & data_memerror) ? 3'd3 : status; 
endmodule

