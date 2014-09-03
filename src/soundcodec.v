// ====================================================================
// PWM sound module for radio-86rk
// Copyright (C) 2014 Andy Karpov
//
// This core is distributed under modified BSD license. 
// For complete licensing information see LICENSE.TXT.
// -------------------------------------------------------------------- 
//
// Design File: soundcodec.v
//
// --------------------------------------------------------------------

`default_nettype none

module soundcodec(
	input	clk,
   input pulse,
	input	reset_n,
   output o_pwm
);

reg [8:0] PWM_accumulator;

always @(posedge clk) PWM_accumulator <= PWM_accumulator[7:0] + {pulse,7'b1};

assign o_pwm = PWM_accumulator[8];
  
endmodule
