module pacman_updown_counter(input clock, Reset, 
										output logic [1:0] out);
	
	logic [1:0] count;
	logic up;
	always_ff @ (posedge clock)
	begin
		if(Reset)
		begin
			count <= 0;
			up <= 1'b1;
		end
		else
		begin
			if(count == 2)
			begin
				count <= count - 1;
				up = 0;
			end
			else if(up == 1 && count < 2)
				count <= count + 1;
			else if(count == 0)
			begin
				count <= count + 1;
				up = 1;
			end
			else if(up == 0 && count > 0)
				count <= count - 1;
		end
	end
	
	assign out = count;
endmodule
