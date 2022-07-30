`include "And.v"

module testbench();
integer i;
reg signed [63:0]x,y;
wire signed [63:0]out;

And FC(x,y,out);
initial begin
    $dumpfile("And1.vcd");
    $dumpvars(0,testbench); 
    x=$random; //random 64bit binary number is stored in x
    y=$random; //random 64bit binary number is stored in y
end
initial begin
    $monitor("x=%b , y=%b , output=%b",x,y,out);
end
endmodule
