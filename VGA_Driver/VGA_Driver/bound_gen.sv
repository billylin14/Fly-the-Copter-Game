/*
	GAP 	= How high the gap between top and bottom of cave is
	INCREMENT_SIZE = How often point will increase and decrease (# of clock cycles)
	
	Point is an output which will increment then decrement once start is asserted.
	When game is over or before game starts, point will be held constant
*/

module bound_gen #(parameter INCREMENT_SIZE = 1000000, parameter GAP = 300) 
						(clk, reset, point, start, gameover);

	input logic clk, reset, start, gameover; 
	output logic [8:0] point; //output the top and bottom endpoints
	
	logic [63:0] counter;
	
	//FSM logics
	enum {idle, increase, decrease, over} ps, ns;
	
	always_comb
		case(ps)
			idle: if (start) ns = increase;
					else ns = idle;
			increase: begin 
				if (gameover) ns = over;
				else begin
					if(point == 639 - GAP) ns = decrease; 
					else ns = increase;
				end
			end
			decrease: begin 
				if (gameover) ns = over;
				else begin
					if(point == 0) ns = increase; 
					else ns = decrease;
				end
			end
			over: ns = over;
		endcase
	
	always_ff @(posedge clk)
		if (reset) begin
			counter <= 0;
			point <= 240 - GAP/2;
			ps <= idle;
		end else begin
			ps <= ns;
			if (ps == increase || ps == decrease) begin
				counter ++;
				if (ps == increase) begin
					if(counter == INCREMENT_SIZE)begin
						point <= point + 1;
						counter <= 0;
					end
				end else begin
					if(counter == INCREMENT_SIZE)begin
						point <= point - 1;
						counter <= 0;
					end
				end
			end 
		end
	
endmodule

module bound_gen_testbench();

	logic clk, reset, start, gameover; //slower clk
	logic [8:0] point; //output the top and bottom endpoints
	
	initial begin
		clk <= 0;
		forever #50 clk <= ~clk;
	end
	
	bound_gen dut (.*);
	defparam dut.INCREMENT_SIZE = 2;
	
	initial begin
		reset <= 1; start <= 0; gameover <= 0;@(posedge clk);
		reset <= 0; repeat (5) @(posedge clk);
		start <= 1; repeat(10) @(posedge clk);
		gameover <= 1; repeat(5) @(posedge clk);
		$stop;
	end
endmodule
		
	
	