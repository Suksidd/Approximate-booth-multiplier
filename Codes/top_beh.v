`timescale 1ns / 1ps
module booth_mul(A,B,P);
parameter n=8;
parameter len=2*n;
input signed [n-1:0]A,B;
output signed[len-1:0]P;
reg signed [len-1:0]b1;
reg signed [2:0]a;
reg signed [len-1:0]p1;
reg signed [len-1:0]p2;
integer i=0;
always@(*)
begin
p2=0;
b1=B<<1;
    for(i=0;i<n-1;i=i+2)
    begin
    a={b1[i+2],b1[i+1],b1[i]};
        case(a)
        3'b000:p1=0;
        3'b001:p1=A;
        3'b010:p1=A;
        3'b011:p1=2*A;
        3'b100:p1=-2*A;
        3'b101:p1=-A;
        3'b110:p1=-A;
        3'b111:p1=0;
        endcase
    p1=p1<<i;
    p2=p2+p1;
    end
end
assign P=p2;
endmodule


