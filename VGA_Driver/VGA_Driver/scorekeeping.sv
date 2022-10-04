//Counts up score to be displayed on HEX display once start is asserted.
//will hold score constant once game is over
module scorekeeping #(parameter RATE = 25) (clk, reset, start, gameover, score);
//25 close but slower than seconds
//24 about 2 times faster than seconds
	input logic clk, reset, start, gameover;
	output logic [31:0] score;
	
	//Generate clk off of CLOCK_50, whichclock picks rate
	logic [31:0] clock;
	clock_divider cdiv (.reset, .clock(clk), .divided_clocks(clock));
	
	logic incr;
	
	logic slow_clk;
	assign slow_clk = clock[RATE];
	
	enum {idle, run, over} ps, ns;
	
	always_comb
		case (ps) 
			idle: if (start) ns = run;
					else ns = idle;
			run: if (gameover) ns = over;
					else ns = run;
			over: ns = over;
		endcase
	
	always_ff @(posedge clk) begin
		if (reset) begin
			score <= 0;
			ps <= idle;
		end else begin
			if (ps == run) 
				if (incr) score <= score + 1;
			ps <= ns;
		end
	end
	
	antiHold detect_incr (.clk, .reset, .in(slow_clk), .out(incr));
endmodule

module scorekeeping_testbench();

	logic clk, reset, start, gameover;
	logic [31:0] score;
	
	scorekeeping dut (.*);
	
	initial begin
		clk <= 0;
		forever #50 clk <= ~clk;
	end
	
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; repeat(100000) @(posedge clk);
		$stop;
	end
endmodule
