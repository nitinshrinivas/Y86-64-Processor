`include "Add.v"

module testbench();
integer i;
reg signed [63:0]x,y;
wire signed [63:0]Sum;
wire signed OF;

Add FC(x,y,Sum,OF);
initial begin
    $dumpfile("Add1.vcd");
    $dumpvars(0,testbench); 
    x=$random; //random 64bit binary number is stored in x
    y=$random; //random 64bit binary number is stored in y
end
initial begin
    $monitor("x=%b , y=%b , Sum=%b , Overflow=%b",x,y,Sum,OF);
end
endmodule
