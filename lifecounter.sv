module lifecounter(input clock, Reset, fail,
						 output logic [1:0] LC);
				
	logic [1:0] lifecounter;
	always_ff @ (posedge clock)
	begin
		if(Reset)
			lifecounter <= 2;
		else
		begin
			if(fail && lifecounter == 0)
			begin
				lifecounter <= 0;
			end
			else if(fail)
				lifecounter <= lifecounter - 1;
			else
				lifecounter <= lifecounter;
		end
	end
	
	
	
	assign LC = lifecounter;
						 
endmodule
