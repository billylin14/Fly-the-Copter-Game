/*
	Control mouse holds the mouse x and y at (0,240) until start is asserted.
*/
module control_mouse (clk, reset, start, gameover, x_mouse_ps2, y_mouse_ps2, x_mouse, y_mouse);

	input logic clk, reset, start, gameover; //game control logics
	input logic [9:0] x_mouse_ps2;
	input logic [8:0] y_mouse_ps2;
	output logic [9:0] x_mouse;
	output logic [8:0] y_mouse;
	
	enum{idle, run, over} ps, ns;
	
	always_comb
		case(ps)
			idle: if (start) ns = run;
					else ns = idle;
			run: if (gameover) ns = over;
					else ns = run;
			over: if (reset) ns = idle;
					else ns = over;
		endcase
		
	always_ff @(posedge clk) 
		if (reset) begin
			ps <= idle;
			x_mouse <= 0;
			y_mouse <= 240;
		end else begin
			ps <= ns;
			if (ps == run) begin
				x_mouse <= x_mouse_ps2;
				y_mouse <= y_mouse_ps2;
			end
		end
endmodule
		