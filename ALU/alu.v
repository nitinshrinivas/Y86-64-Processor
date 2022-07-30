`include "And.v"
`include "Xor.v"
`include "Sub.v"

module MACHINE(x,y,control,out,OF);

input wire signed [63:0]x,y;
output reg signed [63:0]out;
input [1:0]control;
output reg OF;

wire signed [63:0]And_out;
wire signed [63:0]Sub_out;
wire signed [63:0]Xor_out;
wire signed [63:0]Add_out;
wire signed OF_Add;//overflow in add operation
wire signed OF_Sub;//overflow in sub operation

And A(x,y,And_out); //storing the output of AND operation in And_out
Xor B(x,y,Xor_out); //storing the output of XOR operation in Xor_out
Add C(x,y,Add_out,OF_Add); //storing the output of Add operation in Add_out
Sub D(x,y,Sub_out,OF_Sub); //storing the output of Subtraction operation in Sub_out

always @(*) begin
    case(control)
    2'b00: // if control=00 then Add operation is done
    begin
      out=Add_out;
      OF=OF_Add; 
    end
    2'b01: // if control=01 then Sub operation is done
    begin
      out=Sub_out;
      OF=OF_Sub;
    end
    2'b10: // if control=10 then AND operation is done
    begin
      out = And_out;
      OF=1'b0;
    end
    2'b11: // if control=11 then XOR operation is done
    begin
        out = Xor_out;
        OF=1'b0;
    end
    endcase
end

endmodule