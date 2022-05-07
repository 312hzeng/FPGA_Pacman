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

module  ghost2 ( input Reset, frame_clk, 
					  input UpWall, DownWall, LeftWall, RightWall,
                 output [9:0]  GhostX, GhostY, GhostS);
    
    logic [9:0] Ghost_X_Pos, Ghost_X_Motion, Ghost_Y_Pos, Ghost_Y_Motion, Ghost_Size;
	 logic [1:0]randnum;
	 //added
	// int rands;
	 //added
	 
	 
    parameter [9:0] Ghost_X_Center=231;  // Center position on the X axis
    parameter [9:0] Ghost_Y_Center=240;  // Center position on the Y axis
    parameter [9:0] Ghost_X_Min=32;       // Leftmost point on the X axis
    parameter [9:0] Ghost_X_Max=431;     // Rightmost point on the X axis
    parameter [9:0] Ghost_Y_Min=64;       // Topmost point on the Y axis
    parameter [9:0] Ghost_Y_Max=447;     // Bottommost point on the Y axis
    parameter [9:0] Ghost_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ghost_Y_Step=1;      // Step size on the Y axis
		 
	 assign Ghost_Size = 9; 
	 
	 //added
//    lfsr LSFR(.clk(frame_clk),
//				  .reset(Reset),
//				  .enable(1'b1),
//				  .out(rands)
//	 );
//	 assign randnum = rands[0];
	 //added
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin
        if (Reset)  // Asynchronous Reset
        begin 
            Ghost_Y_Motion <= 10'd1; 
				Ghost_X_Motion <= 10'd0; 
				Ghost_Y_Pos <= Ghost_Y_Center;
				Ghost_X_Pos <= Ghost_X_Center;
				randnum <= 0;
        end
		  else
		  begin 
		   randnum <= (Ghost_X_Pos+Ghost_Y_Pos) % 4;
			if((Ghost_X_Pos[9:4] == 26 && Ghost_Y_Pos[9:4] == 15) && Ghost_X_Motion > 0)  //hole
		   begin
			   Ghost_Y_Pos = 246;
				Ghost_X_Pos = 42;
				Ghost_X_Motion <= Ghost_X_Motion;
		   end
			else if((Ghost_X_Pos[9:4] == 26 && Ghost_Y_Pos[9:4] == 13) && Ghost_X_Motion > 0)  //hole
		   begin
			   Ghost_Y_Pos = 215;
				Ghost_X_Pos = 42;
				Ghost_X_Motion <= Ghost_X_Motion;
		   end
			else if((Ghost_X_Pos[9:4] == 14 && Ghost_Y_Pos[9:4] == 16) || (Ghost_X_Pos[9:4] == 6 && Ghost_Y_Pos[9:4] == 25) ||
					(Ghost_X_Pos[9:4] == 14 & Ghost_Y_Pos[9:4] == 22) || (Ghost_X_Pos[9:4] == 9 & Ghost_Y_Pos[9:4] == 19) || 
					(Ghost_X_Pos[9:4] == 12 && Ghost_Y_Pos[9:4] == 13) || (Ghost_X_Pos[9:4] == 8 && Ghost_Y_Pos[9:4] == 10))
			begin
			Ghost_Y_Motion <= -1;  //up
			Ghost_X_Motion <= 0;
			end	
			
			else if((Ghost_X_Pos[9:4] == 14 && Ghost_Y_Pos[9:4] == 13) || (Ghost_X_Pos[9:4] == 20 && Ghost_Y_Pos[9:4] == 15) || 
			       /*(Ghost_X_Pos[9:4] == 6 && Ghost_Y_Pos[9:4] == 22) ||*/ (Ghost_X_Pos[9:4] == 8 && Ghost_Y_Pos[9:4] == 8) 
					 || (Ghost_X_Pos[9:4] == 8 && Ghost_Y_Pos[9:4] == 13) || (Ghost_X_Pos[9:4] == 22 && Ghost_Y_Pos[9:4] == 13))
			begin
			Ghost_Y_Motion <= 0;  //right
			Ghost_X_Motion <= 1;
			end
			
			else if(Ghost_X_Pos[9:4] == 22 && Ghost_Y_Pos[9:4] == 4)
			begin
			Ghost_Y_Motion <= 1;  //down
			Ghost_X_Motion <= 0;
			end
			
			else if (((Ghost_Y_Pos + Ghost_Size) >= Ghost_Y_Max || DownWall == 1)  &&  Ghost_Y_Motion > 0) // Ball is at the bottom edge, BOUNCE!
			begin
				if((randnum == 0 || randnum == 1) && UpWall == 0)
				begin
				Ghost_Y_Motion <= -1;  //up
			   Ghost_X_Motion <= 0;
				end
				else if ((randnum == 2 || randnum == 3) && LeftWall == 0)
				begin
			  	Ghost_Y_Motion <= 0;  //left
				Ghost_X_Motion <= -1;
				end
				else
				begin
				Ghost_Y_Motion <= 0;  //right
				Ghost_X_Motion <= 1;
				end
			end
					  
			else if (((Ghost_Y_Pos - Ghost_Size) <= Ghost_Y_Min || UpWall == 1) && Ghost_Y_Motion[9] == 1)  // Ball is at the top edge, BOUNCE!
			begin
				if((randnum == 0 || randnum == 1) && RightWall == 0)
				begin
				Ghost_Y_Motion <= 0;  //right
				Ghost_X_Motion <= 1;
				end
				else if((randnum == 2 || randnum == 3) && LeftWall == 0)
				begin
				Ghost_Y_Motion <= 0;  //left
				Ghost_X_Motion <= -1;
				end
				else
				begin
			   Ghost_Y_Motion <= 1;  //down
				Ghost_X_Motion <= 0;
				end
			end
			else if (((Ghost_X_Pos + Ghost_Size) >= Ghost_X_Max || RightWall == 1) && Ghost_X_Motion > 0) // Ball is at the Right edge, BOUNCE!
			begin
				if((randnum == 0 || randnum == 1) && LeftWall == 0)
				begin
				Ghost_Y_Motion <= 0;  //left
				Ghost_X_Motion <= -1;
				end
				else if((randnum == 2 || randnum == 3) && DownWall == 0)
				begin
				Ghost_X_Motion <= 0;  //down
				Ghost_Y_Motion <= 1;
				end
				else
				begin
				Ghost_Y_Motion <= -1;  //up
		 	   Ghost_X_Motion <= 0;
				end
			end
					  
			 else if (((Ghost_X_Pos - Ghost_Size) <= Ghost_X_Min || LeftWall == 1) && Ghost_X_Motion[9] == 1) // Ball is at the Left edge, BOUNCE!
			 begin
				if((randnum == 0 || randnum == 1) && DownWall == 0)
				begin
				Ghost_X_Motion <= 0;  //down
				Ghost_Y_Motion <= 1;
				end
				else if((randnum == 2 || randnum == 3) && UpWall == 0)
				begin
				Ghost_X_Motion <= 0;    //up
				Ghost_Y_Motion <= -1;
				end
				else
				begin
				Ghost_Y_Motion <= 0;  //right
				Ghost_X_Motion <= 1;
				end
			end

				 Ghost_Y_Pos <= (Ghost_Y_Pos + Ghost_Y_Motion);  // Update ball position
				 Ghost_X_Pos <= (Ghost_X_Pos + Ghost_X_Motion);

	    end  
	end
    
       
    assign GhostX = Ghost_X_Pos;
   
    assign GhostY = Ghost_Y_Pos;    
	 
	 assign GhostS = Ghost_Size;
endmodule
