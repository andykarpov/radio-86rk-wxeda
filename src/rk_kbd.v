// ====================================================================
//                Radio-86RK FPGA REPLICA
//
//            Copyright (C) 2011 Dmitry Tselikov
//
// This core is distributed under modified BSD license. 
// For complete licensing information see LICENSE.TXT.
// -------------------------------------------------------------------- 
//
// An open implementation of Radio-86RK keyboard
//
// Author: Dmitry Tselikov   http://bashkiria-2m.narod.ru/
// Modified by: Andy Karpov  <andy.karpov@gmail.com>
// Added PS2Controller with debouncer and error checking
// 
// Design File: rk_kbd.v
//

module rk_kbd(
	input clk,
	input reset,
	inout ps2_clk,
	inout ps2_dat,
	input[7:0] addr,
	output reg[7:0] odata,
	output[2:0] shift);

reg scancode_ready;
reg[9:0] scancode;
reg[2:0] shifts;
assign shift = shifts[2:0];
	
Keyboard kbd(
	.Reset(reset), .Clock(clk),
	.PS2Clock(ps2_clk), .PS2Data(ps2_dat),
	.CodeReady(scancode_ready), .ScanCode(scancode)
);

reg[7:0] keymatrix[7:0]; // multi-dimensional array of key matrix 
                                                                                                                                                                          
always @(addr,keymatrix) begin                                                                                                                                             
        odata =                                                                                                                                                           
                (keymatrix[0] & {8{addr[0]}})|                                                                                                                             
                (keymatrix[1] & {8{addr[1]}})|                                                                                                                             
                (keymatrix[2] & {8{addr[2]}})|                                                                                                                             
                (keymatrix[3] & {8{addr[3]}})|                                                                                                                             
                (keymatrix[4] & {8{addr[4]}})|                                                                                                                             
                (keymatrix[5] & {8{addr[5]}})|                                                                                                                             
                (keymatrix[6] & {8{addr[6]}})|                                                                                                                             
                (keymatrix[7] & {8{addr[7]}});                                                                                                                             
end

reg[2:0] c;
reg[3:0] r;

always @(*) begin
	case (scancode[7:0])
	8'h6C: {c,r} = 7'h00; // 7 home
	8'h7D: {c,r} = 7'h10; // 9 pgup
	8'h76: {c,r} = 7'h20; // esc
	8'h05: {c,r} = 7'h30; // F1
	8'h06: {c,r} = 7'h40; // F2
	8'h04: {c,r} = 7'h50; // F3
	8'h0C: {c,r} = 7'h60; // F4
	8'h03: {c,r} = 7'h70; // F5

	8'h0D: {c,r} = 7'h01; // tab
	8'h71: {c,r} = 7'h11; // . del
	8'h5A: {c,r} = 7'h21; // enter
	8'h66: {c,r} = 7'h31; // bksp
	8'h6B: {c,r} = 7'h41; // 4 left
	8'h75: {c,r} = 7'h51; // 8 up
	8'h74: {c,r} = 7'h61; // 6 right
	8'h72: {c,r} = 7'h71; // 2 down

	8'h45: {c,r} = 7'h02; // 0
	8'h16: {c,r} = 7'h12; // 1
	8'h1E: {c,r} = 7'h22; // 2
	8'h26: {c,r} = 7'h32; // 3
	8'h25: {c,r} = 7'h42; // 4
	8'h2E: {c,r} = 7'h52; // 5
	8'h36: {c,r} = 7'h62; // 6
	8'h3D: {c,r} = 7'h72; // 7

	8'h3E: {c,r} = 7'h03; // 8
	8'h46: {c,r} = 7'h13; // 9
	8'h55: {c,r} = 7'h23; // =
	8'h0E: {c,r} = 7'h33; // `
	8'h41: {c,r} = 7'h43; // ,
	8'h4E: {c,r} = 7'h53; // -
	8'h49: {c,r} = 7'h63; // .
	8'h4A: {c,r} = 7'h73; // gray/ + /

	8'h4C: {c,r} = 7'h04; // ;
	8'h1C: {c,r} = 7'h14; // A
	8'h32: {c,r} = 7'h24; // B
	8'h21: {c,r} = 7'h34; // C
	8'h23: {c,r} = 7'h44; // D
	8'h24: {c,r} = 7'h54; // E
	8'h2B: {c,r} = 7'h64; // F
	8'h34: {c,r} = 7'h74; // G

	8'h33: {c,r} = 7'h05; // H
	8'h43: {c,r} = 7'h15; // I
	8'h3B: {c,r} = 7'h25; // J
	8'h42: {c,r} = 7'h35; // K
	8'h4B: {c,r} = 7'h45; // L
	8'h3A: {c,r} = 7'h55; // M
	8'h31: {c,r} = 7'h65; // N
	8'h44: {c,r} = 7'h75; // O

	8'h4D: {c,r} = 7'h06; // P
	8'h15: {c,r} = 7'h16; // Q
	8'h2D: {c,r} = 7'h26; // R
	8'h1B: {c,r} = 7'h36; // S
	8'h2C: {c,r} = 7'h46; // T
	8'h3C: {c,r} = 7'h56; // U
	8'h2A: {c,r} = 7'h66; // V
	8'h1D: {c,r} = 7'h76; // W

	8'h22: {c,r} = 7'h07; // X
	8'h35: {c,r} = 7'h17; // Y
	8'h1A: {c,r} = 7'h27; // Z
	8'h54: {c,r} = 7'h37; // [
	8'h52: {c,r} = 7'h47; // '
	8'h5B: {c,r} = 7'h57; // ]
	8'h5D: {c,r} = 7'h67; // \!
	8'h29: {c,r} = 7'h77; // space

	8'h12: {c,r} = 7'h08; // lshift
	8'h59: {c,r} = 7'h08; // rshift
	8'h14: {c,r} = 7'h18; // rctrl + lctrl
	8'h11: {c,r} = 7'h28; // lalt

/*	8'h0B: {c,r} = 7'h50; // F6
	8'h83: {c,r} = 7'h70; // F7
	8'h0A: {c,r} = 7'h12; // F8
	8'h01: {c,r} = 7'h33; // F9
	8'h07: {c,r} = 7'h56; // F12 - stop
	8'h7C: {c,r} = 7'h46; // gray*
	8'h7B: {c,r} = 7'h66; // gray-
	8'h78: {c,r} = 7'h67; // F11 - rus
	8'h73: {c,r} = 7'h28; // 5 center
	8'h7A: {c,r} = 7'h48; // 3 pgdn
	8'h69: {c,r} = 7'h68; // 1 end
	8'h70: {c,r} = 7'h78; // 0 ins
*/	default: {c,r} = 7'h7F;
	endcase
end

always @(posedge clk or posedge reset) begin
	if (reset) begin
		keymatrix[0] <= 0;
		keymatrix[1] <= 0;
		keymatrix[2] <= 0;
		keymatrix[3] <= 0;
		keymatrix[4] <= 0;
		keymatrix[5] <= 0;
		keymatrix[6] <= 0;
		keymatrix[7] <= 0;
		shifts[2:0] <= 3'b0;
	end else begin
		if(r!=4'hF && scancode_ready) keymatrix[r][c] <= ~scancode[8];
		if (scancode_ready) // extended e0
		begin
			case (scancode[7:0])
			8'h12: shifts[0] = ~scancode[8]; // lshift
			8'h59: shifts[0] = ~scancode[8]; // rshift
			8'h14: shifts[1] = ~scancode[8]; // rctrl + lctrl
			8'h11: shifts[2] = ~scancode[8]; // lalt
			//default:
			//	shifts[2:0] = 3'b0;
			endcase
		end
	end
end



endmodule
