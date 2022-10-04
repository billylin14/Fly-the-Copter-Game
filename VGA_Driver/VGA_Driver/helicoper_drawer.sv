/*
	x = curr_x, y = curr_y (outputs from VGA driver)
	x_mouse and y_mouse are inputs from mouse driver
	
	Helicopter drawer is pixel art to make a small helicopter
*/
module helicopter_drawer(input logic [9:0] x_curr, x_mouse, input logic [8:0] y_curr, y_mouse,
								output logic [23:0] heli_color);
								
	parameter RED 		= 24'hFF0000;
	parameter WHITE 	= 24'hFFFFFF;
	parameter GREY		= 24'he0e0e0;
	parameter BLACK 	= 24'h000000;
	
	
	always_comb begin
		//draw white for main propeller
		if((y_curr == y_mouse 		&&		(x_mouse + 15 == x_curr || x_mouse + 16 == x_curr || x_mouse + 17 == x_curr)) ||
			(y_curr == y_mouse + 1 &&		(x_curr >= x_mouse + 6) && (x_curr <= x_mouse + 26))							||
			(y_curr == y_mouse + 2 &&		((x_curr == x_mouse + 1) || (x_curr == x_mouse + 16))))
			heli_color = WHITE;
			
		//draw white for rear propeller
		else if((y_curr == y_mouse + 3 &&		(x_curr == x_mouse + 1))	||
			(y_curr == y_mouse + 4 &&		(x_curr <= x_mouse + 2))	||
			(y_curr == y_mouse + 5 &&		((x_curr == x_mouse + 1) || (x_curr == x_mouse + 2)))	||
			(y_curr == y_mouse + 6 &&		(x_curr == x_mouse + 1)))
			heli_color = WHITE;
			
		//draw grey for the landing gear
		else if((y_curr == y_mouse + 12 &&	(x_curr == x_mouse + 17 || x_curr == x_mouse + 23))	||
			(y_curr == y_mouse + 13 &&	(x_curr == x_mouse + 17 || x_curr == x_mouse + 23 || x_curr == x_mouse + 26))	||
			(y_curr == y_mouse + 14 &&	(x_curr >= x_mouse + 13 && x_curr <= x_mouse +26)))
			heli_color = GREY;
			
		//draw red for the main helicopter body
		else if((y_curr == y_mouse + 3	&& (x_curr >= x_mouse + 15 && x_curr <= x_mouse + 20))		||
			(y_curr == y_mouse + 4 && (x_curr >= x_mouse + 14 && x_curr <= x_mouse + 22))		||
			(y_curr == y_mouse + 5	&& (x_curr == x_mouse + 3 || x_curr == x_mouse + 4  || (x_curr >= x_mouse + 11 && x_curr <= x_mouse +23))) ||
			(y_curr == y_mouse + 6	&& (x_curr >= x_mouse + 5 && x_curr <= x_mouse + 25))		||
			(y_curr == y_mouse + 7 && (x_curr >= x_mouse + 9 && x_curr <= x_mouse + 26))		||
			(y_curr == y_mouse + 8	&& (x_curr >= x_mouse + 10 && x_curr <= x_mouse + 26))	||
			(y_curr == y_mouse + 9	&& (x_curr >= x_mouse + 11 && x_curr <= x_mouse + 26))	||
			(y_curr == y_mouse + 10 && (x_curr >= x_mouse + 12 && x_curr <= x_mouse + 25))	||
			(y_curr == y_mouse + 11 && (x_curr >= x_mouse + 13 && x_curr <= x_mouse + 25)))
			heli_color = RED;
		else
			heli_color = BLACK;
	end
endmodule
