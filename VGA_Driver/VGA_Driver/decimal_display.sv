//takes in a score and displays the value in decimal to three HEX displays

module decimal_display (score, HEX5, HEX4, HEX3);

	input logic [31:0] score;
	output logic [6:0] HEX5, HEX4, HEX3;
	
	decimal_in_hex houndreds (.num(score/100), .HEX(HEX5));
	decimal_in_hex tens (.num(score/10%10), .HEX(HEX4));
	decimal_in_hex ones (.num(score%10), .HEX(HEX3));
	
endmodule

module dec_display_testbench();

	logic [31:0] score;
	logic [6:0] HEX5, HEX4, HEX3;
	
	logic clk;
	
	initial begin
		clk <= 0;
		forever #50 clk <= ~clk;
	end
	
	initial begin
		score <= 1; #100;
		score <= 9; #100;
		score <= 10; #100;
		score <= 99; #100;
		score <= 100; #100;
		score <= 999; #100;
		$stop;
	end
endmodule
