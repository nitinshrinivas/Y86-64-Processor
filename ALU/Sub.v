`include "Add.v"

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


