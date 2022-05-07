module control (input  logic Clk, Reset, finish, fail, Execute,
                output logic replay, restart, isIntro);

    //start is to start the game fully
	 //replay is to replay the game as the gamer fail
	 //play is nothing
    enum logic [3:0] {Start, Replay, Play, Intro}   curr_state, next_state; 

    always_ff @ (posedge Clk)  
    begin
        if (Reset || finish)
            curr_state <= Intro;
        else 
            curr_state <= next_state;
    end

	always_comb
    begin
        
		  next_state  = curr_state;	
        unique case (curr_state) 
				Intro  : 
				begin
						if(Execute)
							next_state = Start;
				end
				Start  : next_state = Play; 
            Replay : next_state = Play;
						 
            Play:  
				begin
						 if(finish)
							  next_state = Intro;
						 else if(fail)
							  next_state = Replay;
				end
        endcase
   
        case (curr_state)
				Intro:
				begin
					replay = 1'b0;
					restart = 1'b0;
					isIntro = 1'b1;
				end
				Start:
				begin
					 isIntro = 1'b0;
					 replay = 1'b0;
					 restart = 1'b1;
				end
	   	   Replay: 
	         begin
					 isIntro = 1'b0;
                replay = 1'b1;
					 restart = 1'b0;
		      end
	   	   Play: 
		      begin
					 isIntro = 1'b0;
                replay = 1'b0;
					 restart = 1'b0;
		      end
	   	   default:  
		      begin 
					 isIntro = 1'b0;
                replay = 1'b0;
					 restart = 1'b0;
		      end
        endcase
    end

endmodule
