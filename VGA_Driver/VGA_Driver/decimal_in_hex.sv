//Module which displays 1-10 on a HEX display
module decimal_in_hex (num, HEX);

	input logic [31:0] num;
	output logic [6:0] HEX;
	
	always_comb begin
		case (num)
			0: HEX = 7'b1000000;
			1: HEX = 7'b1111001;
			2: HEX = 7'b0100100;
			3: HEX = 7'b0110000;
			4: HEX = 7'b0011001;
			5: HEX = 7'b0010010;
			6: HEX = 7'b0000010;
			7: HEX = 7'b1111000;
			8: HEX = 7'b0000000;
			9: HEX = 7'b0010000;
			10: HEX = 7'b1000000;
			default: HEX = 7'bx;
		endcase
	end
endmodule

module dec_in_hex_testbench();

	logic [31:0] num;
	logic [6:0] HEX;
	
	logic clk;
	
	initial begin
		clk <= 0;
		forever #50 clk <= ~clk;
	end
	
	initial begin
		num <= 1; #100;
		num <= 9; #100;
		$stop;
	end
endmodule

	