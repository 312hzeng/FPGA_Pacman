module color_mapper(input [9:0] PacmanX, PacmanY, DrawX, DrawY, Pacman_Size, Ghost1X, Ghost1Y, Ghost1_Size, Ghost2X, Ghost2Y, Ghost2_Size,
						  input isWall, blank, isFood, isIntro,
						  input [1:0] LC, pac_move, intro,
						  output logic fail, fail_finish,
						  output logic [7:0] Red, Green, Blue);
	 
	 
	 logic isPacman, isLife, isGhost1, isGhost2;//, isFood;
	 logic [9:0] drawpacmanx, drawpacmany;
	 logic [9:0] drawghost1x, drawghost1y;
    logic [9:0] drawghost2x, drawghost2y;
	 
	 int PDistX, PDistY, PSize;
	 assign PDistX = DrawX - PacmanX;
    assign PDistY = DrawY - PacmanY;
    assign PSize = Pacman_Size; 
	 
	 int G1DistX, G1DistY, G1Size;
	 assign G1DistX = DrawX - Ghost1X;
    assign G1DistY = DrawY - Ghost1Y;
    assign G1Size = Ghost1_Size; 
	 
	 int G2DistX, G2DistY, G2Size;
	 assign G2DistX = DrawX - Ghost2X;
    assign G2DistY = DrawY - Ghost2Y;
    assign G2Size = Ghost2_Size; 
	 
	 logic pacman, life, food;
	 logic [1:0] ghost1, ghost2;
	 
	 always_comb
	 begin
		  if(PacmanX[9:4] == Ghost1X[9:4] && PacmanY[9:4] == Ghost1Y[9:4])
				fail = 1;
		  else if (PacmanX[9:4] == Ghost2X[9:4] && PacmanY[9:4] == Ghost2Y[9:4])
				fail = 1;
		  else
				fail = 0;
	 end
	 always_comb
	 begin
		  if(fail == 1 && LC == 0)
				fail_finish = 1;
		  else
				fail_finish = 0;
	 end
		
		
		
		
	 //determine if Pixel is within Pacman range, ghost range, lifecounter range or food range	
		
    always_comb
    begin
        if ( ( PDistX*PDistX + PDistY*PDistY) <= (PSize * PSize) )
            isPacman = 1'b1;				
		  else
				isPacman = 1'b0;
	 end
	 
	 always_comb
    begin
        if (((G1DistX >= 0 && G1DistX < 8) || (G1DistX <= 0 && G1DistX > -8)) && ((G1DistY >= 0 && G1DistY < 8) || (G1DistY <= 0 && G1DistY > -8))) 
            isGhost1 = 1'b1;				
		  else
				isGhost1 = 1'b0;
	 end
	 
	 always_comb
    begin
        if (((G2DistX >= 0 && G2DistX < 8) || (G2DistX <= 0 && G2DistX > -8)) && ((G2DistY >= 0 && G2DistY < 8) || (G2DistY <= 0 && G2DistY > -8))) 
            isGhost2 = 1'b1;				
		  else
				isGhost2 = 1'b0;
	 end
	 
	 always_comb
	 begin
		if( ((DrawX[9:4] == 1 && DrawY[9:4] == 2 ) || (DrawX[9:4] == 2 && DrawY[9:4] == 2 )) && LC == 2)
            isLife = 1'b1;
		else if ((DrawX[9:4] == 1 && DrawY[9:4] == 2 ) && LC == 1)
				isLife = 1'b1;
		else
				isLife = 1'b0;
	 end
	     
	 assign drawpacmanx = PDistX + 8;
	 assign drawpacmany = PDistY + 8;
	 
	 assign drawghost1x = G1DistX + 8;
    assign drawghost1y = G1DistY + 8;
	 
	 assign drawghost2x = G2DistX + 8;
    assign drawghost2y = G2DistY + 8;
	 
	 font_rom Pacman(.DrawX(drawpacmanx), 
						  .DrawY(drawpacmany),
						  .isPacman(isPacman),
						  .pac_move(pac_move),
						  .data(pacman),	                 
						  .isFood(0)

	 );
	 font_rom Life(.DrawX(DrawX), 
						  .DrawY(DrawY),
						  .isPacman(isLife),
						  .pac_move(0),						  
						  .data(life),
						  .isFood(0)

	 );
	 
	 font_rom Ghost1(.DrawX(drawghost1x), 
						  .DrawY(drawghost1y),
						  .isPacman(0),
						  .pac_move(0),						  
						  .isGhost1(isGhost1),
	                 .isFood(0),
						  .data(ghost1)
	 );
	 
	 font_rom Ghost2(.DrawX(drawghost2x), 
						  .DrawY(drawghost2y),
						  .isPacman(0),
						  .pac_move(0),						
						  .isGhost2(isGhost2),
	                 .isFood(0),
						  .data(ghost2)
	 );
	 
	 
	 font_rom Food(.DrawX(DrawX), 
					  .DrawY(DrawY),
					  .isPacman(0),
					  .pac_move(0),					  
					  .isGhost1(0),
					  .isFood(isFood),
					  .data(food));

	 
	 
	 
	 
	 
	 
	 always_comb
    begin:RGB_Display
	     if(blank == 0)
		      begin
				    Red = 8'h00; 
                Green = 8'h00;
				    Blue = 8'h00;
			   end

		  else
			   begin
				  
				  if (isIntro == 0 && isPacman == 1'b1 && pacman == 1)
					  begin
							Red = 255; 
							Green = 255;
							Blue = 0;
					  end
					  
					else if(isIntro == 0 && isGhost1 == 1'b1 && ghost1 == 1) 
					begin
							Red = 255;
							Green = 0;
							Blue = 0;
					end
					else if(isIntro == 0 && isGhost1 == 1'b1 && ghost1 == 2) //eye
					begin
							Red = 255;
							Green = 255;
							Blue = 255;
					end
					else if(isIntro == 0 && isGhost2 == 1'b1 && ghost2 == 1) 
					begin
							Red = 0;
							Green = 255;
							Blue = 0;
					end
					else if(isIntro == 0 && isGhost2 == 1'b1 && ghost2 == 2) //eye
					begin
							Red = 255;
							Green = 255;
							Blue = 255;
					end
					else if(isIntro == 0 && isLife == 1'b1 && life == 1)
					  begin
							Red = 255; 
							Green = 255;
							Blue = 0;
					  end  
					else if (isIntro == 0 && isWall == 1'b1) 
					  begin 
							Red = 8'h00; 
							Green = 8'h00;
							Blue = 8'h7f;
					  end
				  else if (isIntro == 0 && isFood == 1 && food ==1)
					  begin
					      Red = 255;
							Green = 200;
							Blue = 200;
					  end
					  
					else if(isIntro == 1 && intro == 2'b01) 
					begin
							Red = 255;
							Green = 0;
							Blue = 0;
					end
					else if(isIntro == 1 && intro == 2'b10) 
					begin
							Red = 0;
							Green = 255;
							Blue = 0;
					end
					else if(isIntro == 1 && intro == 2'b11) 
					begin
							Red = 0;
							Green = 0;
							Blue = 255;
					end

				  else 
					  begin 
							Red = 8'h00; 
							Green = 8'h00;
							Blue = 8'h00;
					  end 
		  end
    end 
    
endmodule
