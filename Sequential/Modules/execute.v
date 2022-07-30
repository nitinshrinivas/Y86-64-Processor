`include "alu.v"

module execute(clk,icode,ifun,valA,valB,valC,valE,ZF,OF,SF,cnd);

output reg cnd=0;
input [63:0]valA;
input [63:0]valB;
input [63:0]valC;
wire [63:0]Add_out;
wire [63:0]Sub_out;
wire [63:0]Xor_out;
wire [63:0]And_out;
wire OF_Add;
wire OF_Sub;
Add A(valA,valB,Add_out,OF_Add);
Sub B(valA,valB,Sub_out,OF_Sub);
Xor C(valA,valB,Xor_out);
And D(valA,valB,And_out);
input [3:0]icode;
input [3:0]ifun;
input clk;
output reg [63:0]valE;
output reg ZF;
output reg OF;
output reg SF;
wire Xor_1;
wire Xor_2;
xor E(Xor_1,valA[63],valB[63]);
xor F(Xor_2,valA[63],valE[63]);
wire out;
xor G(out,OF,SF);


always @(*)
begin
  if(clk==1)
  begin

  if(icode==4'b0110) //OPq
  begin
    OF=0;
    SF=0;
    ZF=0;
    if(ifun==4'b0000)   //Add
    begin
      valE=Add_out;
      if((Xor_1 == 0) && (Xor_2 == 1))  OF = 1;
      if(valE[63] == 1)  SF = 1;
      if(valE[63:0]==0)  ZF = 1;
    end
    else if(ifun==4'b0001) //Sub
    begin
      valE=Sub_out;
      if((Xor_1 == 1) && (Xor_2) == 1)  OF = 1;
      if(valE[63] == 1)  SF = 1;
      if(valE[63:0]==0)  ZF = 1;
    end 
    else if(ifun==4'b0010) //And
    begin
        valE=And_out;
        if(valE[63] == 1)  SF = 1;
        if(valE[63:0]==0)  ZF = 1;
    end
    else if(ifun==4'b0011) //Xor
    begin
        valE=Xor_out;
        if(valE[63] == 1)  SF = 1;
        if(valE[63:0]==0)  ZF = 1;
    end
  end


  else if(icode==4'b0010) //cmoveX
  begin
      if(ifun==4'b0000) //rrmovq
      begin
          cnd=1;
      end
      else if(ifun==4'b0001) //cmovle
      begin
          if(out==1 || ZF==1) cnd=1;
      end
      else if(ifun==4'b0010) //cmovl
      begin
        if(out==1) cnd=1;
      end
      else if(ifun==4'b0011) //cmove
      begin
        if(ZF==1) cnd=1;
      end 
      else if(ifun==4'b0100) //cmovne
      begin
        if(ZF==0) cnd=1;
      end
      else if(ifun==4'b0101) //cmovge
      begin
          if(out==0) cnd=1;
      end
      else if(ifun==4'b0110) // cmovg
      begin
          if(out==0 || ZF==0) cnd=1;
      end
    valE = valA;
  end


  else if(icode==4'b0111) //jxx
  begin
      if(ifun==4'b0000) cnd=1; //jump
      else if(ifun==4'b0001) //jle
      begin
          if(out==1 || ZF==1) cnd=1;
      end
      else if(ifun==4'b0010) //jl
      begin
        if(out==1) cnd=1;
      end
      else if(ifun==4'b0011) //je
      begin
        if(ZF==1) cnd=1;
      end 
      else if(ifun==4'b0100) //jne
      begin
        if(ZF==0) cnd=1;
      end
      else if(ifun==4'b0101) //jge
      begin
          if(out==0) cnd=1;
      end
      else if(ifun==4'b0110) //jg
      begin
          if(out==0 || ZF==0) cnd=1;
      end
  end
  else if(icode == 4'd8) 
  begin
  valE = valB +(-64'd8); // call instruction
  end

  else if (icode == 4'd9) 
  begin
    valE = valB + 64'd8; // ret instruction
  end

  else if (icode == 4'd10) 
  begin
    valE = valB +(-64'd8); // pushq instruction
  end

  else if (icode == 4'd11) 
  begin
    valE = valB + 64'd8; // popq instruction
  end

  else if (icode == 4'd3) 
  begin
    valE = 64'd0 + valC; // irmovq instruction
  end

  else if (icode == 4'd4) 
  begin
    valE = valB + valC; // rmmovq instruction
  end
            
  else if (icode == 4'd5) 
  begin
    valE = valB + valC; // mrmovq instruction
  end

end
end 
endmodule
