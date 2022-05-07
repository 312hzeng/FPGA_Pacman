module wall (input [9:0]DrawX,
             input [9:0] DrawY,
             output isWall
				 );
								  
	 
	 
	 always_comb 
	 begin
	    logic [10:0]index;
		 logic [5:0] drawx, drawy;
		 
		 int maze[812]; //28 * 29
		 maze = '{
			 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //0
			 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //1
			 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //2
			 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, //3
			 0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1, //4
			 0,1,0,1,1,1,0,1,1,1,1,1,0,0,1,0,1,1,1,1,1,1,0,1,1,1,0,1, //5
			 0,1,0,1,1,1,0,1,1,1,1,1,0,0,1,0,1,1,1,1,1,1,0,1,1,1,0,1, //6
			 0,1,0,1,1,1,0,1,1,1,1,1,0,0,1,0,1,1,1,1,1,1,0,1,1,1,0,1, //7
			 0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1, //8
			 0,1,0,1,1,1,0,1,0,0,0,1,1,1,1,1,1,1,0,0,0,1,0,1,1,1,0,1, //9
			 0,1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,1, //10
			 0,1,1,1,1,1,0,1,1,1,1,1,0,0,1,0,0,1,1,1,1,1,0,1,1,1,1,1, //11
			 0,1,1,1,1,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,1,1,1, //12
			 0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0, //13 
			 0,1,1,1,1,1,0,1,0,0,1,1,1,0,0,0,1,1,1,0,0,1,0,1,1,1,1,1, //14
			 0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0, //15
			 0,1,1,1,1,1,0,1,0,0,1,0,0,0,0,0,0,0,1,0,0,1,0,1,1,1,1,1, //16
			 0,1,1,1,1,1,0,1,0,0,1,0,0,0,0,0,0,0,1,0,0,1,0,1,1,1,1,1, //17
			 0,0,0,0,0,0,0,1,0,0,1,1,1,1,1,1,1,1,1,0,0,1,0,0,0,0,0,0, //18
			 0,1,1,1,1,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,1,1,1, //19
			 0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1, //20
			 0,1,0,1,1,1,0,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,0,1,1,1,0,1, //21
			 0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1, //22
			 0,1,0,0,0,1,0,0,1,0,1,1,1,1,1,1,1,1,1,0,1,0,0,1,0,0,0,1, //23
			 0,1,1,1,0,1,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,1,0,1,1,1, //24
			 0,1,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,1, //25
			 0,1,0,0,1,1,1,1,1,1,1,1,1,0,1,0,1,1,1,1,1,1,1,1,1,0,0,1, //26
			 0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1, //27 
			 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1  //28
		 };
	
	    drawx[5:0] = DrawX[9:4];
		 drawy[5:0] = DrawY[9:4];

		 if(drawx <= 27 && drawx >= 0 && drawy <= 28 && drawy >= 0)
		 begin
	        index = drawy * 28 + drawx;
			  if(maze[index] == 1)
			      isWall = 1;
			  else
					isWall = 0;
		 end
		 
		 else
		     isWall = 0;
	 end
endmodule

