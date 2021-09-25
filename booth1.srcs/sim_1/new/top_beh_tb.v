`timescale 1ns / 1ps
module boot_mul_tb;
parameter n=8;
parameter len=2*n;
reg signed [n-1:0]A,B;
wire signed[len-1:0]P;
booth_mul tb1(A,B,P);
initial begin
A=10;B=5;
#10 A=10;B=-7;
#10 A=40;B=50;
#10 A=100;B=100;
#10 $finish;
end
endmodule