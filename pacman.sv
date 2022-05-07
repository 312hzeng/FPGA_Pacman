//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------

//equation: * 16
module  pacman ( input Reset, frame_clk,
					  input UpWall, DownWall, LeftWall, RightWall,
					  input [7:0] keycode,
                 output [9:0]  PacmanX, PacmanY, PacmanS);
    
    logic [9:0] Pacman_X_Pos, Pacman_X_Motion, Pacman_Y_Pos, Pacman_Y_Motion, Pacman_Size;
	 
    parameter [9:0] Pacman_X_Center= 231;  // Center position on the X axis
    parameter [9:0] Pacman_Y_Center= 312;  // Center position on the Y axis
    parameter [9:0] Pacman_X_Min=32;       // Leftmost point on the X axis
    parameter [9:0] Pacman_X_Max=431;     // Rightmost point on the X axis
    parameter [9:0] Pacman_Y_Min=64;       // Topmost point on the Y axis
    parameter [9:0] Pacman_Y_Max=447;     // Bottommost point on the Y axis
    parameter [9:0] Pacman_X_Step=1;      // Step size on the X axis
    parameter [9:0] Pacman_Y_Step=1;      // Step size on the Y axis
		 
	 assign Pacman_Size = 8; 	 
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin
        if (Reset)  // Asynchronous Reset
        begin 
            Pacman_Y_Motion <= 10'd0; 
				Pacman_X_Motion <= 10'd0; 
				Pacman_Y_Pos <= Pacman_Y_Center;
				Pacman_X_Pos <= Pacman_X_Center;
        end
		  
		  else
		  begin 
				 if((Pacman_X_Pos[9:4] == 26 && Pacman_Y_Pos[9:4] == 15) && Pacman_X_Motion > 0)  //hole 1
					begin
					 Pacman_Y_Pos = 246;
					 Pacman_X_Pos = 42;
				 	 Pacman_X_Motion <= Pacman_X_Motion;
					end
				else if((Pacman_X_Pos[9:4] == 2 && Pacman_Y_Pos[9:4] == 15) && Pacman_X_Motion[9] == 1)  //hole 1 op dir
					begin
					 Pacman_Y_Pos = 246;
					 Pacman_X_Pos = 412;
				 	 Pacman_X_Motion <= -1;
					end
				else if((Pacman_X_Pos[9:4] == 26 && Pacman_Y_Pos[9:4] == 13) && Pacman_X_Motion > 0)  //hole 2
					begin
					 Pacman_Y_Pos = 215;  
					 Pacman_X_Pos = 42;
				 	 Pacman_X_Motion <= Pacman_X_Motion;
					end
				else if((Pacman_X_Pos[9:4] == 2 && Pacman_Y_Pos[9:4] == 13) && Pacman_X_Motion[9] == 1)  //hole 2 op dir
					begin
					 Pacman_Y_Pos = 215;  
					 Pacman_X_Pos = 412;  
				 	 Pacman_X_Motion <= -1;
					end
				else if((Pacman_X_Pos[9:4] == 26 && Pacman_Y_Pos[9:4] == 18) && Pacman_X_Motion > 0)  //hole 3
					begin
					 Pacman_Y_Pos = 294;  
					 Pacman_X_Pos = 42;
				 	 Pacman_X_Motion <= Pacman_X_Motion;
					end
				else if((Pacman_X_Pos[9:4] == 2 && Pacman_Y_Pos[9:4] == 18) && Pacman_X_Motion[9] == 1)  //hole 3 op dir
					begin
					 Pacman_Y_Pos = 294;  //check  
					 Pacman_X_Pos = 412;  
				 	 Pacman_X_Motion <= -1;
					end
					
				 if ( (Pacman_Y_Pos + Pacman_Size) >= Pacman_Y_Max  && ((keycode == 0 && Pacman_Y_Motion > 0) || keycode == 8'h16))  // Ball is at the bottom edge, dont move!
					begin
					  Pacman_Y_Motion <= 0;  
					  Pacman_X_Motion <= 0;
					end
					  
				 else if ( (Pacman_Y_Pos - Pacman_Size) <= Pacman_Y_Min && ((keycode == 0 && Pacman_Y_Motion[9] == 1) || keycode == 8'h1A))  // Ball is at the top edge, BOUNCE!
					begin
					  Pacman_Y_Motion <= 0;
					  Pacman_X_Motion <= 0;
					 end
				 else if ( (Pacman_X_Pos + Pacman_Size) >= Pacman_X_Max && ((keycode == 0 && Pacman_X_Motion > 0 )|| keycode == 8'h07))  // Ball is at the Right edge, BOUNCE!
					begin
					  Pacman_X_Motion <= 0;  
					  Pacman_Y_Motion <= 0;
					end
					  
				 else if ( (Pacman_X_Pos - Pacman_Size) <= Pacman_X_Min && ((keycode == 0 && Pacman_X_Motion[9] == 1) || keycode == 8'h04))  // Ball is at the Left edge, BOUNCE!
					begin
					  Pacman_X_Motion <= 0;
					  Pacman_Y_Motion <= 0;
					end
				 
				 else 
				   begin
					  Pacman_Y_Motion <= Pacman_Y_Motion;  // Ball is somewhere in the middle, can move with keycode now
					  Pacman_X_Motion <= Pacman_X_Motion;  //added code
					  unique case (keycode)
					    8'h04 : begin //A  -- left
									  if(LeftWall == 0)
									  begin
										  Pacman_X_Motion <= -1; 
										  Pacman_Y_Motion <= 0;	
									  end
									  else
									  begin
										  Pacman_X_Motion <= 0;
										  Pacman_Y_Motion <= 0;
									  end 
								  end
								  
						 8'h07 : begin //D  -- right
									  if(RightWall == 0)
									  begin
										  Pacman_X_Motion <= 1; 
										  Pacman_Y_Motion <= 0;
									  end
									  else
									  begin
										  Pacman_X_Motion <= 0;  
										  Pacman_Y_Motion <= 0;
									  end 
								  end

								  
						 8'h16 : begin //S  -- down
								  if(DownWall == 0)
									  begin								   
										  Pacman_X_Motion <= 0;
										  Pacman_Y_Motion <= 1;
									  end
									  else
									  begin
										  Pacman_X_Motion <= 0;  // 2's complement.
										  Pacman_Y_Motion <= 0;
									  end 
								  end
								  
						 8'h1A : begin //W  -- up
									  if(UpWall == 0)
									  begin
										  Pacman_X_Motion <= 0;
										  Pacman_Y_Motion <= -1; 
									  end
									  else
									  begin
										  Pacman_X_Motion <= 0;  // 2's complement.
										  Pacman_Y_Motion <= 0;
									  end 
								  end	  
						 default: 
								 begin
									 if((LeftWall == 1 && Pacman_X_Motion[9] != 0) || (RightWall == 1 && Pacman_X_Motion > 0))
										begin
											Pacman_X_Motion <= 0; 
											Pacman_Y_Motion <= 0;
										end
									 else if((UpWall == 1 && Pacman_Y_Motion[9] != 0) || (DownWall == 1 && Pacman_Y_Motion > 0))
										begin
											Pacman_X_Motion <= 0;
											Pacman_Y_Motion <= 0;
										end
									 else
										begin
											Pacman_X_Motion <= Pacman_X_Motion;
											Pacman_Y_Motion <= Pacman_Y_Motion;
										end
								 end
					endcase
				end
				 
				 Pacman_Y_Pos <= (Pacman_Y_Pos + Pacman_Y_Motion);  // Update ball position
				 Pacman_X_Pos <= (Pacman_X_Pos + Pacman_X_Motion);
           

	    end  
	end
    
       
    assign PacmanX = Pacman_X_Pos;
   
    assign PacmanY = Pacman_Y_Pos;    
	 
	 assign PacmanS = Pacman_Size;

endmodule
