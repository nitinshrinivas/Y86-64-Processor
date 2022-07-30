`include "alu.v"

module testbench();
integer i;
reg signed [63:0]x,y;
wire signed [63:0]out;
reg [1:0]control;
wire OF;
//below line is the function call
MACHINE FC(x,y,control,out,OF);
initial begin
    $dumpfile("ALU.vcd");
    $dumpvars(0,testbench);

    for(i=0;i<4;i++)
    begin
        control=i; 
        x=$random;
        y=$random;#5;
        $display("time=%0t \nx=%b \ny=%b \ncontrol=%b \noutput=%b \nOverflow=%b",$time,x,y,control,out,OF);
    end
    #5 $finish;
end

endmodule
