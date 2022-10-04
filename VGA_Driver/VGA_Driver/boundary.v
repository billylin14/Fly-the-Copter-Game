module boundary ();

	input logic clk;
	input logic [639:0] x_curr;
	input logic [479:0] y_curr;
	output logic [23:0] color;
	
	parameter GREEN = 24'h00FF00;
	parameter BLACK = 24'h000000;
	assign color = draw ? GREEN:BLACK;
	
	logic [639:0] bound;
	
	
	
	