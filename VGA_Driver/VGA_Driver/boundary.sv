/*
	SHIFT_DELAY = Controls how quickly the helicopter flies through the cave
	GAP 			= Distance between ceiling and ground
	WEIGHT		= How quickly the game goes faster as the player's score increases
	
	Start indicates a new game beginning, x and y mouse are from the PS2 mouse, and xcurr and ycurr are the 
	inputs from the VGA driver.
	Color is the output to the VGA driver.
	Point and score are outputs to the DE1_SoC HEX display.
	
	If the helicopter hits a boundary, gameover will remain true.
*/
module boundary #(parameter SHIFT_DELAY = 4000000, parameter GAP = 300, parameter WEIGHT = 50000) 
						(clk, start, reset, gameover, x_mouse, y_mouse, x_curr, y_curr, color, point, score);

	input logic clk, reset, start;
	input logic [9:0] x_mouse, x_curr;
	input logic [8:0] y_mouse, y_curr;
	output logic [23:0] color;
	output logic [8:0] point;
	input logic [31:0] score;
	
	parameter GREEN = 24'h00FF00;
	parameter BLACK = 24'h000000;
	parameter RED = 24'hFF0000;
	parameter WHITE = 24'hFFFFFF;
	
	enum{idle, game, over} ps, ns;
	
	// collision logic, if collision, output a game over signal
	output logic gameover;
	
	// boundary upper end points array
	logic [8:0] top [639:0];
	bound_gen generation (.clk, .reset, .point, .start, .gameover);
	
	// fsm transition logic
	always_comb begin
		case(ps)
			idle: if (start) ns = game;
						else ns = idle;
			game: if (gameover) ns = over;
						else ns = game;
			over: if (reset) ns = idle;
						else ns = over;
		endcase
	end
	
	logic unsigned [63:0] shift_counter;
	
	always_ff @(posedge clk) begin
		if (reset) begin
			top <= '{default: 240 - GAP/2}; //reset top array values to default 90
			gameover <= 0; //gameover not true
			ps <= idle;
			shift_counter <= 1;
		end else begin
			if (ps == game) begin
				//game over logic
				if ((inv_y_mouse <= top[x_mouse] || inv_y_mouse+14 >= top[x_mouse]+GAP)
				    || (inv_y_mouse <= top[x_mouse+26] || inv_y_mouse+14 >= top[x_mouse+26]+GAP)) 
					gameover <= 1;
				//slow shifter
				if (shift_counter == SHIFT_DELAY) begin
					for (int i = 1; i < 640; i++) top[i-1] <= top[i];
					top[639] <= point; //change to output from bound_gen;
					shift_counter <= 1;
				end else shift_counter <= shift_counter + 1;
			end
			ps <= ns;
		end
	end 
	
	// color drawing logic 
	
	logic [8:0] inv_y_mouse;
	assign inv_y_mouse = 480 - y_mouse;
	
	//gameover logic is okay, but it never goes to over state
	//assign gameover = (inv_y_mouse <= top[x_mouse] || inv_y_mouse+10 >= top[x_mouse]+300);
	

	//Helicopter pixel drawing -------------------------------------------------------------
	logic [23:0] heli_color;
	helicopter_drawer heli(.x_curr, .x_mouse, .y_curr, .y_mouse(inv_y_mouse), .heli_color);
	//End helicopter drawing ---------------------------------------------------------------
		
	always_comb
		case(ps)
			idle: color = WHITE;
			game: begin
						// Mouse (helicopter) logic
						// if x_curr and y_curr equal the box values (x_mouse + 24, y_mouse + 15), set color to be from helicopter logic
						if (y_curr >= inv_y_mouse && y_curr <= inv_y_mouse + 14 &&
							 x_curr >= x_mouse && x_curr <= x_mouse + 26) color = heli_color;
						
						// boundary logic
						else if (y_curr < top[x_curr] || y_curr > top[x_curr]+GAP) color = GREEN;
						
						// blank part
						else color = BLACK;
					end
			over: color = RED;
		endcase
	
endmodule

//module boundary_testbench();
//	logic clk, reset;
//	logic [9:0] x_mouse, x_curr;
//	logic [8:0] y_mouse, y_curr;
//	logic [23:0] color;
//	logic [8:0] point;
//	
//	boundary dut (.*);
//	
//	initial begin
//		clk <= 0;
//		forever #50 clk <= ~clk;
//	end
//
//	initial begin
//		reset <= 1;
//		//test no collision, mouse drawing logic
//		//point = 90, 100, y_curr < point || y_curr > point+300
//		reset <= 0; x_mouse <= 500; y_mouse <= 500; x_curr <= 500; y_curr <= 500; @(posedge clk); @(posedge clk);
//		//point = 100
//		//test no collision, boundary drawing logic
//		reset <= 0; x_mouse <= 500; y_mouse <= 500; x_curr <= 0; y_curr <= 0; @(posedge clk); @(posedge clk);
//		//point = 100
//		//test no collision, blank part
//		reset <= 0; x_mouse <= 500; y_mouse <= 500; x_curr <= 700; y_curr <= 700; @(posedge clk); @(posedge clk);
//		//point = 100
//		//test collision
//		reset <= 0; x_mouse <= 0; y_mouse <= 0; x_curr <= 0; y_curr <= 0; @(posedge clk); @(posedge clk);
//		$stop;
//	end
//endmodule
