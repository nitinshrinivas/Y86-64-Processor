`include "Xor.v"

module testbench();
integer i;
reg signed [63:0]x,y;
wire signed [63:0]out;

Xor FC(x,y,out);
initial begin
    $dumpfile("xor1.vcd");
    $dumpvars(0,testbench); 
    x=$random;
    y=$random;
end
initial begin
    $monitor("x=%b , y=%b , output=%b",x,y,out);
end
endmodule
