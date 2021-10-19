`timescale 1ns / 1ps
module testing_1(

    );
endmodule

module partialproduct(a1,a0,twoi,negi,zeroi,pp);
input a1,a0,twoi,negi,zeroi;
output pp;
wire mi,ai;
//mux
mux m1 (a1,a0,twoi,mi); //twoi

xor x1(ai,mi,negi);
not n2 (zeroib,zeroi);
and an3 (pp,zeroib,ai); //partial product generator
endmodule

module signal_3(b2,b1,b0,twoi,negi,zeroi);
input b2,b1,b0;
output twoi,negi,zeroi;
wire t1,t2,z1,z2,n1,n2,b2b,b1b,b0b;
not nt2 (b2b,b2);
not nt1 (b1b,b1);
not nt0 (b0b,b0);
//twoi
nand ti1 (t1,b2,b1b,b0b);
nand ti2 (t2,b2b,b1,b0);
nand ti3 (twoi,t1,t2);
//xnor x1 (twoi,b1,b0);
//negi
nand ni1 (n1,b2,b1b);
nand ni2 (n2,b2,b0b);
nand ni3 (negi,n1,n2);
//buffer bu1 (b2,negi);
//zeroi
nand zi1 (z1,b2b,b1b,b0b);
nand zi2 (z2,b2,b1,b0);
nand zi3 (zeroi,z1,z2);
//or zi1 (z1,b2,b1,b0);
//nand zi2 (z2,b2,b1,b0);
//nand zi3 (zeroi,z1,z2);
endmodule

module fa(A,B,Cin,SUM,CARRY);
 input A;
 input B;
 input Cin;
 output SUM;
 output CARRY;
wire S1, C1, C2;
//instantiating the previous module as ha1 and ha2
ha ha1 (A, B, S1, C1);
ha ha2 (S1, Cin, SUM, C2); //output SUM
or O21 (CARRY, C1, C2); //output CARRY
endmodule


module ha(A,B,SUM,CARRY);
 input A;
 input B;
 output SUM;
 output CARRY;
wire AorB, Cbar;
//structural description
and A1 (CARRY, A, B); //output CARRY
not N1 (Cbar, CARRY);
or O1 (AorB, A, B);
and A2 (SUM, Cbar, AorB); //output SUM
endmodule

module mux(a1,a0,twoi,mi);
input a1,a0,twoi;
output mi;
wire twoib,r1,r0;

not n1 (twoib,twoi);
and an1 (r1,twoib,a1);
and an2 (r0,twoi,a0);
or or1 (mi,r1,r0);
endmodule