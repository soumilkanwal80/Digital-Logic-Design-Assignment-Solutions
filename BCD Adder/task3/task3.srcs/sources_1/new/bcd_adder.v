`timescale 1ns/1ns
module bcdAdder(a8, b8, cout8_out, clk, clr, seg, an, sum16);
	input [7:0] a8, b8;
	//input cin8_in;
	output reg [6:0] seg;
	output reg [3:0] an;
	output reg[11:0] sum16;
	reg [15:0] newarr;
	output cout8_out;
	wire cout8_out;
	wire [7:0] a8, b8;
	wire [11:0] sum16;
	wire [7:0] sumtemp;
	wire [3:0] couttemp, fba2_b4, fba3_b4;
	
	fourBitAdder fba0(
						.a4_in(a8[3:0]),
						.b4_in(b8[3:0]),
						.sum4_out(sumtemp[3:0]),
						.cin4_in(0),
						.cout4_out(couttemp[0])
					);
	assign couttemp[1] = (sumtemp[3]&sumtemp[2])|(sumtemp[3]&sumtemp[1])|couttemp[0];
	
	fourBitAdder fba1(
						.a4_in(a8[7:4]),
						.b4_in(b8[7:4]),
						.sum4_out(sumtemp[7:4]),
						.cin4_in(couttemp[1]),
						.cout4_out(couttemp[2])
					);
	assign couttemp[3] = (sumtemp[7]&sumtemp[6])|(sumtemp[7]&sumtemp[5])|couttemp[2];
	assign fba2_b4[1] = couttemp[1];
	assign fba2_b4[2] = couttemp[1];
	assign fba2_b4[0] = 1'b0;
	assign fba2_b4[3] = 1'b0;

	fourBitAdder fba2(
						.a4_in(sumtemp[3:0]),
						.b4_in(fba2_b4[3:0]),
						.sum4_out(sum16[3:0]),
						.cin4_in(1'b0),
						.cout4_out()
					);
	assign fba3_b4[1] = couttemp[3];
	assign fba3_b4[2] = couttemp[3];
	assign fba3_b4[0] = 1'b0;
	assign fba3_b4[3] = 1'b0;

	fourBitAdder fba3(
						.a4_in(sumtemp[7:4]),
						.b4_in(fba3_b4[3:0]),
						.sum4_out(sum16[7:4]),
						.cin4_in(1'b0),
						.cout4_out()
					);
	   assign sum16[11:9] = 3'b000;
	  assign sum16[8] = couttemp[3];
	
	 //reg [15:0] newarr1 = {0};
    //assign newarr[0] = sum16[0];
    always @* begin
        newarr[0] = sum16[0];
        newarr[1] = sum16[1];
        newarr[2] = sum16[2];
        newarr[3] = sum16[3];
        newarr[4] = sum16[4];
        newarr[5] = sum16[5];
        newarr[6] = sum16[6];
        newarr[7] = sum16[7];
        newarr[8] = sum16[8];
        newarr[9] = sum16[9];
        newarr[10] = sum16[10];
        newarr[11] = sum16[11];
       end
     wire [1:0] s;	 
       reg [3:0] digit;
       wire [3:0] aen;
       reg [19:0] clkdiv;
       input clk;
       input clr;
       assign dp = 1;
       assign s = clkdiv[19:18];
       assign aen = 4'b1111; // all turned off initially
       
       // quad 4to1 MUX.
       
       always @(posedge clk)// or posedge clr)
           
           case(s)
           0:digit = newarr[3:0]; // s is 00 -->0 ;  digit gets assigned 4 bit value assigned to x[3:0]
           1:digit = newarr[7:4]; // s is 01 -->1 ;  digit gets assigned 4 bit value assigned to x[7:4]
           2:digit = newarr[11:8]; // s is 10 -->2 ;  digit gets assigned 4 bit value assigned to x[11:8
           3:digit = newarr[15:12]; // s is 11 -->3 ;  digit gets assigned 4 bit value assigned to x[15:12]
           
           default:digit = newarr[3:0];
           
           endcase
           
           //decoder or truth-table for 7seg display values
           always @(*)
       
       case(digit)
       
       
       //////////<---MSB-LSB<---
       //////////////gfedcba////////////////////////////////////////////              a
       0:seg = 7'b1000000;////0000                                                   __                    
       1:seg = 7'b1111001;////0001                                                f/      /b
       2:seg = 7'b0100100;////0010                                                  g
       //                                                                           __    
       3:seg = 7'b0110000;////0011                                              e /   /c
       4:seg = 7'b0011001;////0100                                                 __
       5:seg = 7'b0010010;////0101                                               d  
       6:seg = 7'b0000010;////0110
       7:seg = 7'b1111000;////0111
       8:seg = 7'b0000000;////1000
       9:seg = 7'b0010000;////1001
       'hA:seg = 7'b0111111; // dash-(g)
       'hB:seg = 7'b1111111; // all turned off
       'hC:seg = 7'b1110111;
       
       default: seg = 7'b0000000; // U
       
       endcase
       
       
       always @(*)begin
       an=4'b1111;
       if(aen[s] == 1)
       an[s] = 0;
       end
       
       
       //clkdiv
       
       always @(posedge clk or posedge clr) begin
       if ( clr == 1)
       clkdiv <= 0;
       else
       clkdiv <= clkdiv+1;
       end
endmodule