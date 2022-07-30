module pc_update(clk,icode,valP,cnd,valC,valM,PC_updated);

input clk;
input [3:0] icode;
input [63:0] valP;
input [63:0] valC;
input [63:0] valM;
input cnd;
  output reg [63:0]PC_updated;

always @ (posedge clk) begin

  if(icode ==4'b0111) begin    // jump condition
    if(cnd==1'b1) PC_updated=valC;    // if the condition is satisfied then go to the valC   
    else PC_updated=valP;                        // else the jump will not occue hence PC will be valP 
  end

  if(icode == 4'b1000) begin  // call condition
    PC_updated = valC;                           // PC will be ht eplace where the call function is calling to
  end

  if(icode == 4'b1001) begin  // return condition
    PC_updated = valM;                           // PC will be the place where the old stack pointer stored in valM.
  end

  else PC_updated = valP;                        // if nothing of these instriuctions are present then the vale is valP

end

endmodule
