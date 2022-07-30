//Add operation

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


//Sub operation
module Sub(x,y,out,OF);

output signed OF;
input signed [63:0]x,y ;
output signed [63:0]out;
wire signed [63:0]z;
assign z=64'b1;
wire signed [63:0]out1,out2,out3,out4;
wire signed OF1;
assign out4=64'b1;
wire signed [63:0]sa;
wire signed [64:0]ca;
wire signed [63:0]sa1;

// For x-y ; first we need to do 2's complement for y and then add it to x
assign out1=~y; // First we do 1's complement
Add A1(out1,z,sa,OF1); // And then we add it to 1 ; for making 2's complement we follow these steps
Add A2(sa,x,out,OF); // We add the 2's complement of y to x


endmodule


//Xor operation
module Xor(x,y,out);

input signed [63:0]x;
input signed [63:0]y;
output signed [63:0]out;

genvar i;
generate
    for(i=0;i<64;i=i+1)
    begin
       xor A(out[i],x[i],y[i]); //xor operation is taken place bit by bit
    end
endgenerate

endmodule


//And operation
module And(x,y,out);

input signed [63:0]x;
input signed [63:0]y;
output signed [63:0]out;

genvar i;
generate
    for(i=0;i<64;i=i+1)
    begin
       and (out[i],x[i],y[i]); //And operation is taken place bit by bit
    end
endgenerate

endmodule