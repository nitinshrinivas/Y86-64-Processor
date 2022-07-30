module Add(x,y,Sum,OF);

input signed [63:0]x;
input signed [63:0]y;
output signed [63:0]Sum;
wire signed [63:0]out1,out2,out3;
wire signed [64:0]Carry;
assign Carry[0]=1'b0; //initiating the first bit to be 0 in a carry array
output signed OF;//overflow


genvar i;
generate
    for(i=0;i<64;i=i+1)
    begin
       xor A(Sum[i],x[i],y[i],Carry[i]); //sum=x xor y xor c
       and B(out1[i],x[i],y[i]); 
       and C(out2[i],y[i],Carry[i]);
       and D(out3[i],Carry[i],x[i]);
       or E(Carry[i+1],out1[i],out2[i],out3[i]); //carry = xy + yc + cx
    end
xor F(OF,Carry[64],Carry[63]); // overflow
endgenerate

endmodule
