// ====================================================================
//                Radio-86RK FPGA REPLICA
//
//            Copyright (C) 2011 Dmitry Tselikov
//
// This core is distributed under modified BSD license. 
// For complete licensing information see LICENSE.TXT.
// -------------------------------------------------------------------- 
//
// An open implementation of Radio-86RK video output
//
// Author: Dmitry Tselikov   http://bashkiria-2m.narod.ru/
// 
// Design File: rk_video.v
//

module rk_video(
	input clk50mhz,
	output hr,
	output vr,
	output cce,
	output [3:0] r,
	output [3:0] g,
	output [3:0] b,
	input[3:0] line,
	input[6:0] ichar,
	input vsp,
	input lten,
	input rvv
);

reg[1:0] state;
reg[9:0] h_cnt;
reg[9:0] v_cnt;
reg[2:0] d_cnt;
reg[5:0] data;
wire[7:0] fdata;

assign hr = h_cnt >= 10'd478 && h_cnt < 10'd530 ? 1'b0 : 1'b1;
assign vr = v_cnt >= 10'd608 && v_cnt < 10'd614 ? 1'b0 : 1'b1;
assign cce = d_cnt==3'b000 && state==2'b01;

assign r = data[5] ? 4'b1000 : 4'b0;
assign g = data[5] ? 4'b1000 : 4'b0;
assign b = data[5] ? 4'b1000 : 4'b0;

font from(.address({ichar[6:0],line[2:0]}), .clock(clk50mhz), .q(fdata));

always @(posedge clk50mhz)
begin
	casex (state)
	2'b00: state <= 2'b01;
	2'b01: state <= 2'b10;
	2'b1x: state <= 2'b00;
	endcase
	if (state==2'b00) begin
		if (d_cnt==3'b101) begin
			data <= lten ? 6'h3F : vsp ? 6'b0 : fdata[5:0]^{6{rvv}};
		end else
			data <= {data[4:0],1'b0};
		if (h_cnt+1'b1 == 10'd533) begin
			h_cnt <= 0; d_cnt <= 0;
			if (v_cnt+1'b1 == 10'd625 ) begin
				v_cnt <= 0;
			end else begin
				v_cnt <= v_cnt+1'b1;
			end
		end else begin
			h_cnt <= h_cnt+1'b1;
			if (d_cnt+1'b1 == 3'b110) begin
				d_cnt <= 0;
			end else
				d_cnt <= d_cnt+1'b1;
		end
	end
end

endmodule
