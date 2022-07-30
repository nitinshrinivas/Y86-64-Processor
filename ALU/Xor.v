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
