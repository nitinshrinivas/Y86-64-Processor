
//--------------> Fetch
module fetch(stall,bubble,f_icode,E_icode,E_dstM,d_icode,M_icode,d_RA,d_RB,reset);

input reset;
input [3:0] f_icode,E_icode,E_dstM,d_icode,M_icode,d_RA,d_RB;
output stall,bubble;

assign bubble = (reset ==1) ? 1 : 0;
assign stall  = (((E_icode==4'd5|E_icode==4'd11)&(E_dstM==d_RA|E_dstM==d_RB)) | (d_icode==4'd9|E_icode==4'd9|M_icode==4'd9|f_icode==4'd9)) ? 1 : 0;

endmodule


//----------------> decode
module decode(stall,bubble,M_icode,E_icode,d_icode,d_RA,d_RB,E_dstM,e_cnd,reset);

input reset;
input e_cnd;
output stall,bubble;
input [3:0] M_icode , E_icode , d_icode , E_dstM , d_RA , d_RB;

assign bubble = ((((E_icode==4'd7)&(e_cnd))|((E_icode==4'd5|E_icode==4'd11)&((E_dstM==d_RA)|(E_dstM==d_RB))
					&(d_icode==4'd9|E_icode==4'd9|M_icode==4'd9)))|reset) ? 1 : 0;

assign stall = (((E_icode==4'd5|E_icode==4'd11)&((E_dstM==d_RA)|(E_dstM==d_RB)))|(d_icode==4'd0)) ? 1 : 0;

endmodule

//------------------> execute
module execute(stall,bubble,icode,cnd,d_RA,d_RB,dstM,reset);

input cnd, reset;
input [3:0] dstM,icode, d_RA,d_RB;
output stall,bubble;

assign stall = 0;
assign bubble = ((((icode==4'd7)&(cnd==0))|((icode==4'd5|icode==4'd11) & (dstM==d_RA|dstM==d_RB)))|(reset)) ? 1 : 0;

endmodule


//-------------> memory
module memory_final(stall,bubble,status,W_status,reset);

input reset;
input [2:0] status;
input [2:0] W_status;
output bubble , stall;

assign stall = 0;
assign bubble = ((((status==3'd2|status==3'd3|status==3'd4))|(W_status==3'd2|W_status==3'd3|W_status==3'd4)|reset)) ? 1 : 0;


endmodule

//----------> write back
module write_Back(bubble,stall,status,reset);

input reset;
input [2:0] status;
output bubble, stall;

assign bubble = reset ? 1 : 0;
assign stall = ((status==3'd2|status==3'd3|status==3'd4)) ? 1 :0;

endmodule
