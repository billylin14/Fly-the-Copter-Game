/*
	Billy Lin and Cameron Wutzke
	
	EE371 final lab- 3/9/2020
	
	This is a helicopter game which displays a helicopter on a VGA screen and allows the user to control it
	using a PS2 mouse.
	The score will increase on the HEX display and show the current value of the top of the cave (on the right of the 
	screen). When the helicopter crashes, the screen will turn red indicating game over.
	
	Reset = switch9
	Start game = Key3
*/
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW,
					 CLOCK_50, VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS, PS2_CLK, PS2_DAT);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;

	input CLOCK_50;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;
	
	inout  PS2_CLK;
	inout  PS2_DAT;

	logic reset, start_game, gameover;
	assign reset = SW[9];
	logic [9:0] x, x_mouse, x_mouse_ps2;
	logic [8:0] y, y_mouse, y_mouse_ps2;
	logic [7:0] r, g, b;
	
	//display the signal
	assign LEDR[9] = reset;
	assign LEDR[8] = gameover;
	
	assign start_game = ~KEY[3];
	
	//display the latest generated top point
	logic [8:0] point;
	
	SEG7_LUT HEX_0 (HEX0, point[3:0]);
	SEG7_LUT HEX_1 (HEX1, point[7:4]);
	SEG7_LUT HEX_2 (HEX2, point[8]);
	
	//display the score
	logic [31:0] score;
   scorekeeping getScore (.clk(CLOCK_50), .reset, .start(start_game), .gameover, .score);

	decimal_display user_score(.score, .HEX5, .HEX4, .HEX3);
	
	//draw screen module and VGA driver
	boundary draw_screen (.clk(CLOCK_50), .start(start_game), .reset, .gameover, .x_mouse, .y_mouse,
								.x_curr(x), .y_curr(y), .color({r,g,b}), .point, .score);
	
	video_driver #(.WIDTH(640), .HEIGHT(480))
		v1 (.CLOCK_50, .reset, .x, .y, .r, .g, .b,
			 .VGA_R, .VGA_G, .VGA_B, .VGA_BLANK_N,
			 .VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS);
	
	//mouse movement module
	ps2 #(
			.WIDTH(640),
			.HEIGHT(480),
			.BIN(10),
			.HYSTERESIS(3))
	U1(
			.start(~KEY[0]), //reset
			.reset(start_game),  
			.CLOCK_50(CLOCK_50),  
			.PS2_CLK(PS2_CLK), 
			.PS2_DAT(PS2_DAT), 
			.button_left(LEDR[0]),  
			.button_right(LEDR[1]),  
			.button_middle(LEDR[2]),  
			.bin_x(x_mouse_ps2),
			.bin_y(y_mouse_ps2)
			);
	
	//mouse control logic
	control_mouse mouse (.clk(CLOCK_50), .reset, .start(start_game), .gameover, .x_mouse_ps2, .y_mouse_ps2, .x_mouse, .y_mouse);
	
endmodule
