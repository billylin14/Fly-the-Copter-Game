// Billy Lin
// EE 371
// 1/16/20
// Lab 1 clock_divider.sv

// input with a clock, a reset,
// the program outputs a clock with a slower rate

module clock_divider (reset, clock, divided_clocks);
	// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ...
	// [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...
	input logic reset, clock;    
	output logic [31:0] divided_clocks;     
	
	always_ff @(posedge clock) begin 
		if (reset) divided_clocks <= 0;
		else divided_clocks <= divided_clocks + 1;
    end
endmodule

//Test the output rate of clock
module clock_divider_testbench();

	logic clock, reset;    
	logic [31:0] divided_clocks;
	
	logic clock_15;
	assign clock_15 = divided_clocks[15]; //the clock rate used in DE1_SoC
	
	//clock setup
	parameter clk_period = 100;
	
	initial begin
		clock <= 0;
		forever #(clk_period/2) clock <= ~clock;
	end
	
	clock_divider dut (.reset, .clock, .divided_clocks);
	
	initial begin
		reset <= 1; @(posedge clock); 
		reset <= 0; @(posedge clock);
		for (int i = 0; i < 10**10; i++) begin
			@(posedge clock);
		end
		$stop;
	end
endmodule
