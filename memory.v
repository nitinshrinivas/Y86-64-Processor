module memory(icode,valM,valP,valE,valA,valB,Mem_output);

input [3:0]icode;
input [63:0]valA,valB,valE,valP;
output reg [63:0]valM;
output reg [63:0] Mem_output;


reg [63:0] Mem_data[1023:0];


always @(*)
begin
  if(icode==4'b0100) //rmmovq 
  begin             // we need to find the value of the destination i.e., valB+valC=valE.
    Mem_data[valE]=valA;  // Now we need to put the value stored in valA to valE
  end 
  else if(icode==4'b0101) //mrmovq
  begin             // we need to push the data from the valE to the register.
    valM=Mem_data[valE]; // Here the destination is valM
  end
  else if(icode==4'b1000) //call
  begin             // We decerement the stack pointer by 8 and add the program counter into the stack memory
    Mem_data[valE]=valP;
  end
  else if(icode==4'b1001) //ret
  begin              // we have to return the value at the memory of the stack pointer(valA) to valM
    valM=Mem_data[valA];
  end
  else if(icode==4'b1010) //pushq
  begin              // firstly we have to increase the stack pointer to valE and then put the value of valA into the memory of valE
    Mem_data[valE]=valA;
  end
  else if(icode==4'b1011) //popq
  begin               //we have to increase the stack pointer and then the value of valM is the memory of valA
    valM=Mem_data[valA];
  end
  Mem_output=Mem_data[valE];
end
endmodule