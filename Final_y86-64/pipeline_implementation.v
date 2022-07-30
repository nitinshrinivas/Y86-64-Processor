
// In this it is clear that if reset is done then the value should take the same value as the value it contains. 
// But if the bubble occurs then nop operation gets implemented here
module bubble_reg64bit (clk,input_val,output_val,En,reset,reset_value);

input clk,reset,En;
input [63:0] input_val,reset_value;
output reg [63:0] output_val;

always@(*)
begin
  if(reset) output_val<=reset_value;
  else if(En) output_val<=input_val;
end

endmodule


// Using the above in the below, do procces the respective action
module pipeline_reg64 (clk,input_val,output_val,stall,bubble,bubble_val);

input clk,stall,bubble;
input [63:0] input_val,bubble_val;
output [63:0] output_val;

bubble_reg64bit uut4(clk,input_val,output_val,~stall,bubble,bubble_val);

endmodule


// This is used in writing the data memory
module reg64bit (clk,input_val,output_val,write_En,reset,reset_value);

input clk,reset,write_En;
input [63:0] input_val,reset_value;
output reg [63:0] output_val;

always@(*)
begin
  if(reset) output_val<=reset_value;
  else if(write_En) output_val<=input_val;
end
endmodule