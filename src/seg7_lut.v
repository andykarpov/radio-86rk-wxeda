// ====================================================================
//                Bashkiria-2M FPGA REPLICA
//
//            Copyright (C) 2010 Dmitry Tselikov
//
// This core is distributed under modified BSD license. 
// For complete licensing information see LICENSE.TXT.
// -------------------------------------------------------------------- 
//
// An open implementation of Bashkiria-2M home computer
//
// Author: Dmitry Tselikov   http://bashkiria-2m.narod.ru/
// 
// Design File: seg7_lut.v
//
// Four 7-segment indicator design file of Bashkiria-2M replica.

module seg7_lut(
	output reg[6:0] oSEG,
	input[3:0] iDIG);

always @(iDIG)
begin
	case(iDIG)
	4'h1: oSEG = 7'b1111001;	// ---t----
	4'h2: oSEG = 7'b0100100; 	// |	  |
	4'h3: oSEG = 7'b0110000; 	// lt	 rt
	4'h4: oSEG = 7'b0011001; 	// |	  |
	4'h5: oSEG = 7'b0010010; 	// ---m----
	4'h6: oSEG = 7'b0000010; 	// |	  |
	4'h7: oSEG = 7'b1111000; 	// lb	 rb
	4'h8: oSEG = 7'b0000000; 	// |	  |
	4'h9: oSEG = 7'b0011000; 	// ---b----
	4'ha: oSEG = 7'b0001000;
	4'hb: oSEG = 7'b0000011;
	4'hc: oSEG = 7'b1000110;
	4'hd: oSEG = 7'b0100001;
	4'he: oSEG = 7'b0000110;
	4'hf: oSEG = 7'b0001110;
	4'h0: oSEG = 7'b1000000;
	endcase
end

endmodule

module seg7_lut4(
	output[6:0] oSEG0,
	output[6:0] oSEG1,
	output[6:0] oSEG2,
	output[6:0] oSEG3,
	input[15:0] iDIG);

seg7_lut seg0(oSEG0, iDIG[3:0]);
seg7_lut seg1(oSEG1, iDIG[7:4]);
seg7_lut seg2(oSEG2, iDIG[11:8]);
seg7_lut seg3(oSEG3, iDIG[15:12]);

endmodule
