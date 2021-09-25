`timescale 1ns / 1ps
module top_tb;
parameter len=8,t_len=len+len,m=len/2,ap=6;
reg signed [len-1:0]A,B;
wire signed [t_len-1:0]Y;
top tb1 (A,B,Y);
initial begin
//16bit
A=127;B=-127;
#10 A=-8;B=-7;
#10 A=7;B=27;
#10 A=-4567;B=0;
#10 A=-49;B=39;
#10 $finish;
end
endmodule
