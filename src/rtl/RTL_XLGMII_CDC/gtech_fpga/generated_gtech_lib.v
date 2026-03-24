///////////////////////////////////////////////////////////////////////////////
//
//        This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Synopsys Inc.
//     In the event of publication, the following notice is applicable:
//
//                    (C) COPYRIGHT 1994-2002 SYNOPSYS, INC.
//                              ALL RIGHTS RESERVED
//
//        The entire notice above must be reproduced on all authorized
//       copies.
//
// ABSTRACT: The GTECH library Verilog Simulation Model
//
// DesignWare_version : fa784f6f
// DesignWare_release : K-2015.06-DWBB_201506.5.2
//
///////////////////////////////////////////////////////////////////////////////

`ifdef GTECH_default_delay
`else
`define GTECH_default_delay 1
`endif


//
// Verilog Simulation model for GTECH_ADD_AB
//

module GTECH_ADD_AB(A,B,S,COUT);
input	A,B;
output	S,COUT;
assign S=A^B;
assign COUT=A&B;
endmodule

//
// Verilog Simulation model for GTECH_ADD_ABC
//

module GTECH_ADD_ABC(A,B,C,S,COUT);
input	A,B,C;
output	S,COUT;
wire	AB,AC,BC;
assign S=A^B^C;
assign AB=A&B;
assign AC=A&C;
assign BC=B&C;
assign COUT=AB|AC|BC;
endmodule

//
// Verilog Simulation model for GTECH_AND2
//

module GTECH_AND2(A,B,Z);
input	A,B;
output	Z;
assign Z=A&B;
endmodule

//
// Verilog Simulation model for GTECH_AND3
//

module GTECH_AND3(A,B,C,Z);
input	A,B,C;
output	Z;
assign Z=A&B&C;
endmodule

//
// Verilog Simulation model for GTECH_AND4
//

module GTECH_AND4(A,B,C,D,Z);
input	A,B,C,D;
output	Z;
assign Z=A&B&C&D;
endmodule

//
// Verilog Simulation model for GTECH_AND5
//

module GTECH_AND5(A,B,C,D,E,Z);
input	A,B,C,D,E;
output	Z;
assign Z=A&B&C&D&E;
endmodule

//
// Verilog Simulation model for GTECH_AND8
//

module GTECH_AND8(A,B,C,D,E,F,G,H,Z);
input	A,B,C,D,E,F,G,H;
output	Z;
assign Z=A&B&C&D&E&F&G&H;
endmodule

//
// Verilog Simulation model for GTECH_AND_NOT
//

module GTECH_AND_NOT(A,B,Z);
input	A,B;
output	Z;
wire	BN;
assign BN=~B;
assign Z=A&BN;
endmodule

//
// Verilog Simulation model for GTECH_AO21
//

module GTECH_AO21(A,B,C,Z);
input	A,B,C;
output	Z;
wire	AB;
assign AB=A&B;
assign Z=AB|C;
endmodule

//
// Verilog Simulation model for GTECH_AO22
//

module GTECH_AO22(A,B,C,D,Z);
input	A,B,C,D;
output	Z;
wire	AB,CD;
assign AB=A&B;
assign CD=C&D;
assign Z=AB|CD;
endmodule

//
// Verilog Simulation model for GTECH_AOI21
//

module GTECH_AOI21(A,B,C,Z);
input	A,B,C;
output	Z;
wire	AB;
assign AB=A&B;
assign Z=~(AB|C);
endmodule

//
// Verilog Simulation model for GTECH_AOI22
//

module GTECH_AOI22(A,B,C,D,Z);
input	A,B,C,D;
output	Z;
wire	AB,CD;
assign AB=A&B;
assign CD=C&D;
assign Z=~(AB|CD);
endmodule

//
// Verilog Simulation model for GTECH_AOI222
//

module GTECH_AOI222(A,B,C,D,E,F,Z);
input	A,B,C,D,E,F;
output	Z;
wire	AB,CD,EF;
assign AB=A&B;
assign CD=C&D;
assign EF=E&F;
assign Z=~(AB|CD|EF);
endmodule

//
// Verilog Simulation model for GTECH_AOI2N2
//

module GTECH_AOI2N2(A,B,C,D,Z);
input	A,B,C,D;
output	Z;
wire	AB,CD;
assign AB=A&B;
assign CD=~(C|D);
assign Z=~(AB|CD);
endmodule

//
// Verilog Simulation model for GTECH_BUF
//

module GTECH_BUF(A,Z);
input	A;
output	Z;
assign Z=A;
endmodule

//
// Verilog Simulation model for GTECH_FD1
//

module GTECH_FD1(D,CP,Q,QN);
input	D,CP;
output	Q,QN;

        GTECH_UDP_FD1  (Q_int, D, CP);
assign Q= Q_int;
assign QN=~ Q_int;

endmodule

//
// Verilog Simulation model for GTECH_FD14
//

module GTECH_FD14(D0, D1, D2, D3, CP,
		Q0, Q1, Q2, Q3,
		QN0, QN1, QN2, QN3);
input		D0;
input		D1;
input		D2;
input		D3;
input		CP;
output		Q0,QN0;
output		Q1,QN1;
output		Q2,QN2;
output		Q3,QN3;

        GTECH_UDP_FD1  (Q0_int, D0, CP);
        GTECH_UDP_FD1  (Q1_int, D1, CP);
        GTECH_UDP_FD1  (Q2_int, D2, CP);
        GTECH_UDP_FD1  (Q3_int, D3, CP);
assign Q0= Q0_int;
assign Q1= Q1_int;
assign Q2= Q2_int;
assign Q3= Q3_int;
assign QN0=~ Q0_int;
assign QN1=~ Q1_int;
assign QN2=~ Q2_int;
assign QN3=~ Q3_int;
endmodule

//
// Verilog Simulation model for GTECH_FD18
//

module GTECH_FD18(D0, D1, D2, D3, D4, D5, D6, D7, CP,
		Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7,
		QN0, QN1, QN2, QN3, QN4, QN5, QN6, QN7);
input		D0;
input		D1;
input		D2;
input		D3;
input		D4;
input		D5;
input		D6;
input		D7;
input		CP;
output		Q0,QN0;
output		Q1,QN1;
output		Q2,QN2;
output		Q3,QN3;
output		Q4,QN4;
output		Q5,QN5;
output		Q6,QN6;
output		Q7,QN7;

        GTECH_UDP_FD1  (Q0_int, D0, CP);
        GTECH_UDP_FD1  (Q1_int, D1, CP);
        GTECH_UDP_FD1  (Q2_int, D2, CP);
        GTECH_UDP_FD1  (Q3_int, D3, CP);
        GTECH_UDP_FD1  (Q4_int, D4, CP);
        GTECH_UDP_FD1  (Q5_int, D5, CP);
        GTECH_UDP_FD1  (Q6_int, D6, CP);
        GTECH_UDP_FD1  (Q7_int, D7, CP);
assign Q0= Q0_int;
assign Q1= Q1_int;
assign Q2= Q2_int;
assign Q3= Q3_int;
assign Q4= Q4_int;
assign Q5= Q5_int;
assign Q6= Q6_int;
assign Q7= Q7_int;
assign QN0=~ Q0_int;
assign QN1=~ Q1_int;
assign QN2=~ Q2_int;
assign QN3=~ Q3_int;
assign QN4=~ Q4_int;
assign QN5=~ Q5_int;
assign QN6=~ Q6_int;
assign QN7=~ Q7_int;
endmodule

//
// Verilog Simulation model for GTECH_FD1S
//

module GTECH_FD1S(D,TI,TE,CP,Q,QN);
input	D,TI,TE,CP;
output	Q,QN;

        GTECH_UDP_MUX2 (DT, D, TI, TE);
        GTECH_UDP_FD1 (Q_int, DT, CP);
assign Q= Q_int;
assign QN=~ Q_int;
endmodule

//
// Verilog Simulation model for GTECH_FD2
//

module GTECH_FD2(D,CP,CD,Q,QN);
input	D,CP,CD;
output	Q,QN;

        GTECH_UDP_FD2 (Q_int, D, CP, CD); 
assign Q= Q_int;
assign QN=~ Q_int;

endmodule

//
// Verilog Simulation model for GTECH_FD24
//

module GTECH_FD24(D0, D1, D2, D3, CP, CD,
		Q0, Q1, Q2, Q3,
		QN0, QN1, QN2, QN3);
input		D0;
input		D1;
input		D2;
input		D3;
input		CP;
input		CD;
output		Q0,QN0;
output		Q1,QN1;
output		Q2,QN2;
output		Q3,QN3;

        GTECH_UDP_FD2  (Q0_int, D0, CP, CD);
        GTECH_UDP_FD2  (Q1_int, D1, CP, CD);
        GTECH_UDP_FD2  (Q2_int, D2, CP, CD);
        GTECH_UDP_FD2  (Q3_int, D3, CP, CD);
assign Q0= Q0_int;
assign Q1= Q1_int;
assign Q2= Q2_int;
assign Q3= Q3_int;
assign QN0=~ Q0_int;
assign QN1=~ Q1_int;
assign QN2=~ Q2_int;
assign QN3=~ Q3_int;
endmodule

//
// Verilog Simulation model for GTECH_FD28
//

module GTECH_FD28(D0, D1, D2, D3, D4, D5, D6, D7, CP, CD,
		Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7,
		QN0, QN1, QN2, QN3, QN4, QN5, QN6, QN7);
input		D0;
input		D1;
input		D2;
input		D3;
input		D4;
input		D5;
input		D6;
input		D7;
input		CP;
input		CD;
output		Q0,QN0;
output		Q1,QN1;
output		Q2,QN2;
output		Q3,QN3;
output		Q4,QN4;
output		Q5,QN5;
output		Q6,QN6;
output		Q7,QN7;


        GTECH_UDP_FD2  (Q0_int, D0, CP, CD);
        GTECH_UDP_FD2  (Q1_int, D1, CP, CD);
        GTECH_UDP_FD2  (Q2_int, D2, CP, CD);
        GTECH_UDP_FD2  (Q3_int, D3, CP, CD);
        GTECH_UDP_FD2  (Q4_int, D4, CP, CD);
        GTECH_UDP_FD2  (Q5_int, D5, CP, CD);
        GTECH_UDP_FD2  (Q6_int, D6, CP, CD);
        GTECH_UDP_FD2  (Q7_int, D7, CP, CD);
assign Q0= Q0_int;
assign Q1= Q1_int;
assign Q2= Q2_int;
assign Q3= Q3_int;
assign Q4= Q4_int;
assign Q5= Q5_int;
assign Q6= Q6_int;
assign Q7= Q7_int;
assign QN0=~ Q0_int;
assign QN1=~ Q1_int;
assign QN2=~ Q2_int;
assign QN3=~ Q3_int;
assign QN4=~ Q4_int;
assign QN5=~ Q5_int;
assign QN6=~ Q6_int;
assign QN7=~ Q7_int;

endmodule

//
// Verilog Simulation model for GTECH_FD2S
//

module GTECH_FD2S(D,TI,TE,CP,CD,Q,QN);
input	D,TI,TE,CP,CD;
output	Q,QN;

        GTECH_UDP_MUX2 (DT, D, TI, TE);
        GTECH_UDP_FD2 (Q_int, DT, CP, CD);
assign Q= Q_int;
assign QN=~ Q_int;


endmodule

//
// Verilog Simulation model for GTECH_FD3
//

module GTECH_FD3(D,CP,CD,SD,Q,QN);
input	D,CP,CD,SD;
output	Q,QN;
wire Q_int_int;

        GTECH_UDP_FD3 (Q_int, D, CP, CD, SD); 
assign Q= Q_int;
        assign Q_int_int = ((SD === 1'b0) & (CD === 1'b0))?1'b1: Q_int;
assign QN=~ Q_int_int;
endmodule

//
// Verilog Simulation model for GTECH_FD34
//

module GTECH_FD34(D0, D1, D2, D3, CP, CD, SD,
		Q0, Q1, Q2, Q3,
		QN0, QN1, QN2, QN3);
input		D0;
input		D1;
input		D2;
input		D3;
input		CP,CD,SD;
output		Q0,QN0;
output		Q1,QN1;
output		Q2,QN2;
output		Q3,QN3;

        GTECH_UDP_FD3 FD34_00 (Q0_int, D0, CP, CD, SD);
        GTECH_UDP_FD3 FD34_01 (Q1_int, D1, CP, CD, SD);
        GTECH_UDP_FD3 FD34_02 (Q2_int, D2, CP, CD, SD);
        GTECH_UDP_FD3 FD34_03 (Q3_int, D3, CP, CD, SD);
assign Q0= Q0_int;
assign Q1= Q1_int;
assign Q2= Q2_int;
assign Q3= Q3_int;
assign QN0=~ Q0_int;
assign QN1=~ Q1_int;
assign QN2=~ Q2_int;
assign QN3=~ Q3_int;

endmodule

//
// Verilog Simulation model for GTECH_FD38
//

module GTECH_FD38(D0, D1, D2, D3, D4, D5, D6, D7, CP, CD, SD,
		Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7,
		QN0, QN1, QN2, QN3, QN4, QN5, QN6, QN7);
input		D0;
input		D1;
input		D2;
input		D3;
input		D4;
input		D5;
input		D6;
input		D7;
input		CP,CD,SD;
output		Q0,QN0;
output		Q1,QN1;
output		Q2,QN2;
output		Q3,QN3;
output		Q4,QN4;
output		Q5,QN5;
output		Q6,QN6;
output		Q7,QN7;

        GTECH_UDP_FD3 FD38_00 (Q0_int, D0, CP, CD, SD);
        GTECH_UDP_FD3 FD38_01 (Q1_int, D1, CP, CD, SD);
        GTECH_UDP_FD3 FD38_02 (Q2_int, D2, CP, CD, SD);
        GTECH_UDP_FD3 FD38_03 (Q3_int, D3, CP, CD, SD);
        GTECH_UDP_FD3 FD38_04 (Q4_int, D4, CP, CD, SD);
        GTECH_UDP_FD3 FD38_05 (Q5_int, D5, CP, CD, SD);
        GTECH_UDP_FD3 FD38_06 (Q6_int, D6, CP, CD, SD);
        GTECH_UDP_FD3 FD38_07 (Q7_int, D7, CP, CD, SD);
assign Q0= Q0_int;
assign Q1= Q1_int;
assign Q2= Q2_int;
assign Q3= Q3_int;
assign Q4= Q4_int;
assign Q5= Q5_int;
assign Q6= Q6_int;
assign Q7= Q7_int;
assign QN0=~ Q0_int;
assign QN1=~ Q1_int;
assign QN2=~ Q2_int;
assign QN3=~ Q3_int;
assign QN4=~ Q4_int;
assign QN5=~ Q5_int;
assign QN6=~ Q6_int;
assign QN7=~ Q7_int;

endmodule

//
// Verilog Simulation model for GTECH_FD3S
//

module GTECH_FD3S(D,TI,TE,CP,CD,SD,Q,QN);
input	D,TI,TE,CP,CD,SD;
output	Q,QN;
wire Q_int_int;

        GTECH_UDP_MUX2  (DT, D, TI, TE);
        GTECH_UDP_FD3 (Q_int, DT, CP, CD, SD);
assign Q= Q_int;
        assign Q_int_int = ((SD === 1'b0) & (CD === 1'b0))?1'b1: Q_int;
assign QN=~ Q_int_int;

endmodule

//
// Verilog Simulation model for GTECH_FD4
//

module GTECH_FD4(D,CP,SD,Q,QN);
input	D,CP,SD;
output	Q,QN;

        GTECH_UDP_FD4 (Q_int, D, CP, SD); 
assign Q= Q_int;
assign QN=~ Q_int;

endmodule

//
// Verilog Simulation model for GTECH_FD44
//

module GTECH_FD44(D0, D1, D2, D3, CP, SD,
		Q0, Q1, Q2, Q3,
		QN0, QN1, QN2, QN3);
input		D0;
input		D1;
input		D2;
input		D3;
input		CP;
input		SD;
output		Q0,QN0;
output		Q1,QN1;
output		Q2,QN2;
output		Q3,QN3;

        GTECH_UDP_FD4  (Q0_int, D0, CP, SD);
        GTECH_UDP_FD4  (Q1_int, D1, CP, SD);
        GTECH_UDP_FD4  (Q2_int, D2, CP, SD);
        GTECH_UDP_FD4  (Q3_int, D3, CP, SD);
assign Q0= Q0_int;
assign Q1= Q1_int;
assign Q2= Q2_int;
assign Q3= Q3_int;
assign QN0=~ Q0_int;
assign QN1=~ Q1_int;
assign QN2=~ Q2_int;
assign QN3=~ Q3_int;

endmodule

//
// Verilog Simulation model for GTECH_FD48
//

module GTECH_FD48(D0, D1, D2, D3, D4, D5, D6, D7, CP, SD,
		Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7,
		QN0, QN1, QN2, QN3, QN4, QN5, QN6, QN7);
input		D0;
input		D1;
input		D2;
input		D3;
input		D4;
input		D5;
input		D6;
input		D7;
input		CP;
input		SD;
output		Q0,QN0;
output		Q1,QN1;
output		Q2,QN2;
output		Q3,QN3;
output		Q4,QN4;
output		Q5,QN5;
output		Q6,QN6;
output		Q7,QN7;

        GTECH_UDP_FD4  (Q0_int, D0, CP, SD);
        GTECH_UDP_FD4  (Q1_int, D1, CP, SD);
        GTECH_UDP_FD4  (Q2_int, D2, CP, SD);
        GTECH_UDP_FD4  (Q3_int, D3, CP, SD);
        GTECH_UDP_FD4  (Q4_int, D4, CP, SD);
        GTECH_UDP_FD4  (Q5_int, D5, CP, SD);
        GTECH_UDP_FD4  (Q6_int, D6, CP, SD);
        GTECH_UDP_FD4  (Q7_int, D7, CP, SD);
assign Q0= Q0_int;
assign Q1= Q1_int;
assign Q2= Q2_int;
assign Q3= Q3_int;
assign Q4= Q4_int;
assign Q5= Q5_int;
assign Q6= Q6_int;
assign Q7= Q7_int;
assign QN0=~ Q0_int;
assign QN1=~ Q1_int;
assign QN2=~ Q2_int;
assign QN3=~ Q3_int;
assign QN4=~ Q4_int;
assign QN5=~ Q5_int;
assign QN6=~ Q6_int;
assign QN7=~ Q7_int;

endmodule

//
// Verilog Simulation model for GTECH_FD4S
//

module GTECH_FD4S(D,TI,TE,CP,SD,Q,QN);
input	D,TI,TE,CP,SD;
output	Q,QN;

        GTECH_UDP_MUX2 (DT, D, TI, TE);
        GTECH_UDP_FD4 (Q_int, DT, CP, SD);
assign Q= Q_int;
assign QN=~ Q_int;

endmodule

//
// Verilog Simulation model for GTECH_FJK1
//

module GTECH_FJK1(J,K,CP,Q,QN);
input	J,K,CP;
output	Q,QN;
   
        GTECH_UDP_FJK1 (Q_int, J, K, CP);
assign Q= Q_int;
assign QN=~ Q_int;

endmodule

//
// Verilog Simulation model for GTECH_FJK1S
//

module GTECH_FJK1S(J,K,TI,TE,CP,Q,QN);
input	J,K,TI,TE,CP;
output	Q,QN;

assign TIB=~ TI;
        GTECH_UDP_MUX2 (J_int, J, TI, TE);
        GTECH_UDP_MUX2 (K_int, K, TIB, TE);
        GTECH_UDP_FJK1 (Q_int, J_int, K_int, CP);
assign Q= Q_int;
assign QN=~ Q_int;

endmodule

//
// Verilog Simulation model for GTECH_FJK2
//

module GTECH_FJK2(J,K,CP,CD,Q,QN);
input	J,K,CP,CD;
output	Q,QN;

        GTECH_UDP_FJK2 (Q_int, J, K, CP, CD); 
assign Q= Q_int;
assign QN=~ Q_int;

endmodule

//
// Verilog Simulation model for GTECH_FJK2S
//

module GTECH_FJK2S(J,K,TI,TE,CP,CD,Q,QN);
input	J,K,TI,TE,CP,CD;
output	Q,QN;

assign TIB=~ TI;
        GTECH_UDP_MUX2 (J_int, J, TI, TE);
        GTECH_UDP_MUX2 (K_int, K, TIB, TE);
        GTECH_UDP_FJK2 (Q_int, J_int, K_int, CP, CD); 
assign Q= Q_int;
assign QN=~ Q_int;

endmodule

//
// Verilog Simulation model for GTECH_FJK3
//

module GTECH_FJK3(J,K,CP,CD,SD,Q,QN);
input	J,K,CP,CD,SD;
output	Q,QN;
wire Q_int_int;

        GTECH_UDP_FJK3 (Q_int, J, K, CP, CD, SD);  
assign Q= Q_int;
        assign Q_int_int = ((SD === 1'b0) & (CD === 1'b0))?1'b1: Q_int;
assign QN=~ Q_int_int;

endmodule

//
// Verilog Simulation model for GTECH_FJK3S
//

module GTECH_FJK3S(J,K,TI,TE,CP,CD,SD,Q,QN);
input	J,K,TI,TE,CP,CD,SD;
output	Q,QN;
wire Q_int_int;

assign TIB=~ TI;
        GTECH_UDP_MUX2 (J_int, J, TI, TE);
        GTECH_UDP_MUX2 (K_int, K, TIB, TE);
        GTECH_UDP_FJK3 (Q_int, J_int, K_int, CP, CD, SD);
assign Q= Q_int;
        assign Q_int_int = ((SD === 1'b0) & (CD === 1'b0))?1'b1: Q_int;
assign QN=~ Q_int_int;

endmodule

//
// Verilog Simulation model for GTECH_FJK4
//

module GTECH_FJK4(J,K,CP,SD,Q,QN);
input	J,K,CP,SD;
output	Q,QN;

        GTECH_UDP_FJK4 (Q_int, J, K, CP, SD);
assign Q= Q_int;
assign QN=~ Q_int;

endmodule

//
// Verilog Simulation model for GTECH_FJK4S
//

module GTECH_FJK4S(J,K,TI,TE,CP,SD,Q,QN);
input	J,K,TI,TE,CP,SD;
output	Q,QN;

assign TIB=~ TI;
        GTECH_UDP_MUX2 (J_int, J, TI, TE);
        GTECH_UDP_MUX2 (K_int, K, TIB, TE);
        GTECH_UDP_FJK4 (Q_int, J_int, K_int, CP, SD);
assign Q= Q_int;
assign QN=~ Q_int;
endmodule

//
// Verilog Simulation model for GTECH_INBUF
//

module GTECH_INBUF(PAD_IN,DATA_IN);
output	DATA_IN;
input	PAD_IN;
assign  DATA_IN = PAD_IN & 1'b1;
endmodule

//
// Verilog Simulation model for GTECH_INOUTBUF
//

module GTECH_INOUTBUF(DATA_OUT,OE,PAD_INOUT,DATA_IN);
input	DATA_OUT,OE;
output	DATA_IN;
inout	PAD_INOUT;
assign  PAD_INOUT = OE? (DATA_OUT & 1'b1) : 1'bz;
assign  DATA_IN = PAD_INOUT & 1'b1;
endmodule

//
// Verilog Simulation model for GTECH_ISO0
//

module GTECH_ISO0_EN1(EN,DI,DO);
input	EN,DI;
output	DO;
assign DO=EN&DI;
endmodule

//
// Verilog Simulation model for GTECH_ISO1
//

module GTECH_ISO1_EN1(EN,DI,DO);
input	EN,DI;
output	DO;
wire	en_n;
assign en_n=~EN;
assign DO=DI|en_n;
endmodule

//
// Verilog Simulation model for GTECH_ISO0
//

module GTECH_ISO0_EN0(EN,DI,DO);
input	EN,DI;
output	DO;
wire	en_n;
assign en_n=~EN;
assign DO=en_n&DI;
endmodule

//
// Verilog Simulation model for GTECH_ISO1
//

module GTECH_ISO1_EN0(EN,DI,DO);
input	EN,DI;
output	DO;
assign DO=DI|EN;
endmodule

//
// Verilog Simulation model for GTECH_ISOLATCH_EN1
//

module GTECH_ISOLATCH_EN1(EN,DI,DO);
input   EN,DI;
output  DO;
wire	Q;
 
        GTECH_UDP_LD1_Q (Q, DI, EN);
assign DO= Q;
endmodule

//
// Verilog Simulation model for GTECH_ISOLATCH_EN0
//

module GTECH_ISOLATCH_EN0(EN,DI,DO);
input   EN,DI;
output  DO;
wire	Q;
 
        GTECH_UDP_LD2_Q (Q, DI, EN);
assign DO= Q;
endmodule

//
// Verilog Simulation model for GTECH_LD1
//

module GTECH_LD1(D,G,Q,QN);
input	D,G;
output	Q,QN;

        GTECH_UDP_LD1_Q (Q_int, D, G); 
assign Q= Q_int;
assign QN=~ Q_int;

endmodule

//
// Verilog Simulation model for GTECH_LD2
//

module GTECH_LD2(D,GN,Q,QN);
input	D,GN;
output	Q,QN;

        GTECH_UDP_LD2_Q (Q_int, D, GN);  
assign Q= Q_int;
assign QN=~ Q_int;
endmodule

//
// Verilog Simulation model for GTECH_LD2_1
//

module GTECH_LD2_1(D,GN,Q);
input   D,GN;
output  Q;
 
        GTECH_UDP_LD2_Q (Q_int, D, GN);
assign Q= Q_int;
endmodule

//
// Verilog Simulation model for GTECH_LD3
//

module GTECH_LD3(D,G,CD,Q,QN);
input	D,G,CD;
output	Q,QN;

        GTECH_UDP_LD3_Q (Q_int, D, G, CD);   
assign Q= Q_int;
assign QN=~ Q_int;

endmodule

//
// Verilog Simulation model for GTECH_LD4
//

module GTECH_LD4(D,GN,CD,Q,QN);
input	D,GN,CD;
output	Q,QN;

        GTECH_UDP_LD4_Q (Q_int, D, GN, CD);    
assign Q= Q_int;
assign QN=~ Q_int;

endmodule

//
// Verilog Simulation model for GTECH_LD4_1
//

module GTECH_LD4_1(D,GN,CD,Q);
input   D,GN,CD;
output  Q;
 
        GTECH_UDP_LD4_Q (Q_int, D, GN, CD);
assign Q= Q_int;
endmodule

//
// Verilog Simulation model for GTECH_LSR0
//

module GTECH_LSR0(S,R,Q,QN);
input	S,R;
output	Q,QN;
wire Q_int_int;

        GTECH_UDP_LSR0_Q (Q_int, S, R);    
assign Q= Q_int;
        assign Q_int_int = ((S === 1'b0) & (R === 1'b0))?1'b1: Q_int;
assign QN=~ Q_int_int;

endmodule

//
// Verilog Simulation model for GTECH_MAJ23
//

module GTECH_MAJ23(A,B,C,Z);
input	A,B,C;
output	Z;
wire	AB,AC,BC;
assign AB=A&B;
assign AC=A&C;
assign BC=B&C;
assign Z=AB|AC|BC;
endmodule

//
// Verilog Simulation model for GTECH_MUX2
//

module GTECH_MUX2(A,B,S,Z);
input	A,B,S;
output	Z;
       
        GTECH_UDP_MUX2 (Z_int, A, B, S);
assign Z= Z_int;
endmodule

//
// Verilog Simulation model for GTECH_MUX4
//

module GTECH_MUX4(D0,D1,D2,D3,A,B,Z);
input	D0,D1,D2,D3,A,B;
output	Z;

        GTECH_UDP_MUX4 (Z_int, D0, D1, D2, D3, A, B);
assign Z= Z_int;
endmodule

//
// Verilog Simulation model for GTECH_MUX8
//

module GTECH_MUX8(D0,D1,D2,D3,D4,D5,D6,D7,A,B,C,Z);
input	D0,D1,D2,D3,D4,D5,D6,D7,A,B,C;
output	Z;

        GTECH_UDP_MUX4 (D1_int, D0, D1, D2, D3, A, B);
        GTECH_UDP_MUX4 (D2_int, D4, D5, D6, D7, A, B);
        GTECH_UDP_MUX2 (Z_int, D1_int, D2_int, C);
assign Z= Z_int;

endmodule

//
// Verilog Simulation model for GTECH_MUXI2
//

module GTECH_MUXI2(A,B,S,Z);
input	A,B,S;
output	Z;
       
        GTECH_UDP_MUX2 (Z_int, A, B, S);
assign Z=~ Z_int;
endmodule

//
// Verilog Simulation model for GTECH_NAND2
//

module GTECH_NAND2(A,B,Z);
input	A,B;
output	Z;
assign Z=~(A&B);
endmodule

//
// Verilog Simulation model for GTECH_NAND3
//

module GTECH_NAND3(A,B,C,Z);
input	A,B,C;
output	Z;
assign Z=~(A&B&C);
endmodule

//
// Verilog Simulation model for GTECH_NAND4
//

module GTECH_NAND4(A,B,C,D,Z);
input	A,B,C,D;
output	Z;
assign Z=~(A&B&C&D);
endmodule

//
// Verilog Simulation model for GTECH_NAND5
//

module GTECH_NAND5(A,B,C,D,E,Z);
input	A,B,C,D,E;
output	Z;
assign Z=~(A&B&C&D&E);
endmodule

//
// Verilog Simulation model for GTECH_NAND8
//

module GTECH_NAND8(A,B,C,D,E,F,G,H,Z);
input	A,B,C,D,E,F,G,H;
output	Z;
assign Z=~(A&B&C&D&E&F&G&H);
endmodule

//
// Verilog Simulation model for GTECH_NOR2
//

module GTECH_NOR2(A,B,Z);
input	A,B;
output	Z;
assign Z=~(A|B);
endmodule

//
// Verilog Simulation model for GTECH_NOR3
//

module GTECH_NOR3(A,B,C,Z);
input	A,B,C;
output	Z;
assign Z=~(A|B|C);
endmodule

//
// Verilog Simulation model for GTECH_NOR4
//

module GTECH_NOR4(A,B,C,D,Z);
input	A,B,C,D;
output	Z;
assign Z=~(A|B|C|D);
endmodule

//
// Verilog Simulation model for GTECH_NOR5
//

module GTECH_NOR5(A,B,C,D,E,Z);
input	A,B,C,D,E;
output	Z;
assign Z=~(A|B|C|D|E);
endmodule

//
// Verilog Simulation model for GTECH_NOR8
//

module GTECH_NOR8(A,B,C,D,E,F,G,H,Z);
input	A,B,C,D,E,F,G,H;
output	Z;
assign Z=~(A|B|C|D|E|F|G|H);
endmodule

//
// Verilog Simulation model for GTECH_NOT
//

module GTECH_NOT(A,Z);
input	A;
output	Z;
assign Z=~A;
endmodule

//
// Verilog Simulation model for GTECH_OA21
//

module GTECH_OA21(A,B,C,Z);
input	A,B,C;
output	Z;
wire	AB;
assign AB=A|B;
assign Z=AB&C;
endmodule

//
// Verilog Simulation model for GTECH_OA22
//

module GTECH_OA22(A,B,C,D,Z);
input	A,B,C,D;
output	Z;
wire	AB,CD;
assign AB=A|B;
assign CD=C|D;
assign Z=AB&CD;
endmodule

//
// Verilog Simulation model for GTECH_OAI21
//

module GTECH_OAI21(A,B,C,Z);
input	A,B,C;
output	Z;
wire	AB;
assign AB=A|B;
assign Z=~(AB&C);
endmodule

//
// Verilog Simulation model for GTECH_OAI22
//

module GTECH_OAI22(A,B,C,D,Z);
input	A,B,C,D;
output	Z;
wire	AB,CD;
assign AB=A|B;
assign CD=C|D;
assign Z=~(AB&CD);
endmodule

//
// Verilog Simulation model for GTECH_OAI2N2
//

module GTECH_OAI2N2(A,B,C,D,Z);
input	A,B,C,D;
output	Z;
wire	AB,CD;
assign AB=A|B;
assign CD=~(C&D);
assign Z=~(AB&CD);
endmodule

//
// Verilog Simulation model for GTECH_ONE
//

module GTECH_ONE(Z);
output	Z;
wire	Z;
assign	Z = 1'b1;
endmodule

//
// Verilog Simulation model for GTECH_OR2
//

module GTECH_OR2(A,B,Z);
input	A,B;
output	Z;
assign Z=A|B;
endmodule

//
// Verilog Simulation model for GTECH_OR3
//

module GTECH_OR3(A,B,C,Z);
input	A,B,C;
output	Z;
assign Z=A|B|C;
endmodule

//
// Verilog Simulation model for GTECH_OR4
//

module GTECH_OR4(A,B,C,D,Z);
input	A,B,C,D;
output	Z;
assign Z=A|B|C|D;
endmodule

//
// Verilog Simulation model for GTECH_OR5
//

module GTECH_OR5(A,B,C,D,E,Z);
input	A,B,C,D,E;
output	Z;
assign Z=A|B|C|D|E;
endmodule

//
// Verilog Simulation model for GTECH_OR8
//

module GTECH_OR8(A,B,C,D,E,F,G,H,Z);
input	A,B,C,D,E,F,G,H;
output	Z;
assign Z=A|B|C|D|E|F|G|H;
endmodule

//
// Verilog Simulation model for GTECH_OR_NOT
//

module GTECH_OR_NOT(A,B,Z);
input	A,B;
output	Z;
wire	BN;
assign BN=~B;
assign Z=A|BN;
endmodule

//
// Verilog Simulation model for GTECH_OUTBUF
//

module GTECH_OUTBUF(DATA_OUT,OE,PAD_OUT);
input	DATA_OUT,OE;
output	PAD_OUT;
assign  PAD_OUT = OE? (DATA_OUT & 1'b1) : 1'bz;
endmodule

//
// Verilog Simulation model for GTECH_TBUF
//

module GTECH_TBUF(A,E,Z);
input   A,E;
output  Z;
bufif1  U1 ( Z,A,E);
endmodule

//
// Verilog Simulation model for GTECH_XNOR2
//

module GTECH_XNOR2(A,B,Z);
input	A,B;
output	Z;
assign Z=~(A|B);
endmodule

//
// Verilog Simulation model for GTECH_XNOR3
//

module GTECH_XNOR3(A,B,C,Z);
input	A,B,C;
output	Z;
assign Z=~(A|B|C);
endmodule

//
// Verilog Simulation model for GTECH_XNOR4
//

module GTECH_XNOR4(A,B,C,D,Z);
input	A,B,C,D;
output	Z;
assign Z=~(A|B|C|D);
endmodule

//
// Verilog Simulation model for GTECH_XOR2
//

module GTECH_XOR2(A,B,Z);
input	A,B;
output	Z;
assign Z=A^B;
endmodule

//
// Verilog Simulation model for GTECH_XOR3
//

module GTECH_XOR3(A,B,C,Z);
input	A,B,C;
output	Z;
assign Z=A^B^C;
endmodule

//
// Verilog Simulation model for GTECH_XOR4
//

module GTECH_XOR4(A,B,C,D,Z);
input	A,B,C,D;
output	Z;
assign Z=A^B^C^D;
endmodule

//
// Verilog Simulation model for GTECH_ZERO
//

module GTECH_ZERO(Z);
output	Z;
wire	Z;
assign	Z = 1'b0;
endmodule

	
//Primitive convert to module

module GTECH_UDP_FD1  (Q, D, CP);
    output Q;
    input D, CP;
    reg Q;

always@(posedge CP)
	Q = D;
	
endmodule

module GTECH_UDP_FD2  (Q, D, CP, CD);
	output Q;
    input D, CP, CD;
    reg Q;
	
always@(posedge CP or negedge CD)
	if(~CD)
	begin
	Q <= 1'b0;
	end
	else
	begin
	Q <= D;
	end
endmodule

module GTECH_UDP_FD3 (Q, D, CP, CD, SD);
	output Q;
    input  D, CP, CD, SD;
    reg    Q;
	
always@(posedge CP or negedge CD or negedge SD)
if(~CD)
Q<=1'b0;
else if(~SD)
Q<=1'b1;
else 
Q<=D;

endmodule

module GTECH_UDP_FD4  (Q, D, CP, SD); 
	output Q;  
    input D, CP, SD; 
    reg Q;

always@(posedge CP or negedge SD)
if(~SD)
begin
Q<=1'b1;
end
else
begin
Q<=D;
end
endmodule

module GTECH_UDP_FJK1  (Q, J, K,CP);
	output Q;
    input J, K, CP;
    reg Q;

always@(posedge CP)
if(J == 0 & K == 1)
begin
Q <= 1'b0;
end
else if (J == 1 & K == 0)
begin
Q <= 1'b1;
end
else if (J == 1 & K == 1)
begin
Q <= ~Q;
end
else
begin
Q <= Q;
end

endmodule

module GTECH_UDP_FJK2  (Q, J, K,CP, CD);
    output Q; 
    input J, K, CP, CD; 
    reg Q;
	
always@(posedge CP or negedge CD)

if(~CD)
begin
	Q <= 1'b0;
end
else
	begin
	if(J == 0 & K == 1)
	begin
	Q <= 1'b0;
	end
	else if (J == 1 & K == 0)
	begin
	Q <= 1'b1;
	end
	else if (J == 1 & K == 1)
	begin
	Q <= ~Q;
	end
	else
	begin
	Q <= Q;
	end
	end

endmodule

module GTECH_UDP_FJK3  (Q, J, K,CP, CD, SD); 
    output Q;    
    input J, K, CP, CD, SD;  
    reg Q; 
	
always@(posedge CP or negedge CD or negedge SD)
if(~CD)
Q<=1'b0;
else if(~SD)
Q<=1'b1;
else 
	begin
	if(J == 0 & K == 1)
	begin
	Q <= 1'b0;
	end
	else if (J == 1 & K == 0)
	begin
	Q <= 1'b1;
	end
	else if (J == 1 & K == 1)
	begin
	Q <= ~Q;
	end
	else
	begin
	Q <= Q;
	end
	end
	
endmodule


module GTECH_UDP_FJK4  (Q, J, K,CP, SD);
    output Q;  
    input J, K, CP, SD; 
    reg Q;

always@(posedge CP or negedge SD)
if(~SD)
Q<=1'b1;
else
begin
	if(J == 0 & K == 1)
	begin
	Q <= 1'b0;
	end
	else if (J == 1 & K == 0)
	begin
	Q <= 1'b1;
	end
	else if (J == 1 & K == 1)
	begin
	Q <= ~Q;
	end
	else
	begin
	Q <= Q;
	end
end
endmodule





module GTECH_UDP_LD1_Q  (Q, D, G);
    output Q;
    input D, G;
    reg Q;

always@(G)
	Q <= D;
endmodule



module GTECH_UDP_LD2_Q  (Q, D, GN);
    output Q;
    input D, GN;
    reg Q;
	
always@(~GN)
Q <=D;
endmodule

module GTECH_UDP_LD3_Q  (Q, D, G, CD);
    output Q;
    input D, G, CD;
    reg Q;

always@(G or CD)
if(~CD)
begin
Q <= 1'b0;
end
else
begin
Q <=D;
end

endmodule


module GTECH_UDP_LD4_Q  (Q, D, GN, CD);
	output Q;
    input D, GN, CD;
    reg Q;
	
always@(~GN or CD)
if(~CD)
begin
Q <= 1'b0;
end
else
begin
Q <= D;
end
endmodule


module GTECH_UDP_LSR0_Q  (Q, S, R);
    output Q;
    input S, R;
    reg Q;

	always@(S or R)
		if(S != R)
		begin
		Q <=S;
		end
		else if (S == 1'b1 & R == 1'b1)
		begin
		Q <= 1'bz;
		end
		else
		begin
		Q <= Q;
		end
endmodule



module GTECH_UDP_MUX2 (Z, A, B, S);

   output Z;
   input A, B, S;
   assign Z = S ? B : A;
endmodule



module GTECH_UDP_MUX4 (Z, D0, D1, D2, D3, A, B);
    output Z;
    input D0, D1, D2, D3, A, B;
    assign Z = A ? (B ? (D3):(D2)):(B ? (D1):(D0));
endmodule


