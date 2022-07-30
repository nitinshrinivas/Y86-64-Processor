`include "Sub.v"

module testbench();
integer i;
reg signed [63:0]x,y;
wire signed [63:0]Sub;
wire signed OF;

Sub FC(x,y,Sub,OF);
initial begin
    $dumpfile("Sub1.vcd");
    $dumpvars(0,testbench); 
    x=$random; //random 64bit binary number is stored in x
    y=$random; //random 64bit binary number is stored in y
end
initial begin
    $monitor("x=%b , y=%b , Sub=%b ,overflow=%b",x,y,Sub,OF);
end
endmodule
