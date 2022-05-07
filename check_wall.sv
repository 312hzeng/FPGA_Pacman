module check_wall(input [9:0] DrawX,
						input [9:0] DrawY,
						input [9:0] ObjectX, ObjectY, ObjectS,
						output logic isWall, UpWall, DownWall, LeftWall, RightWall); 
	 
	 
	 
	 wall wall(.DrawX(DrawX),
				  .DrawY(DrawY),
				  .isWall(isWall)
	 );
	 
	 wall UPWALL(.DrawX(ObjectX),
				    .DrawY(ObjectY - ObjectS),
				    .isWall(UpWall)
	 );
	 wall DOWNWALL(.DrawX(ObjectX),
				  .DrawY(ObjectY + ObjectS),
				  .isWall(DownWall)
	 );
	 wall LEFTWALL(.DrawX(ObjectX - ObjectS),
				      .DrawY(ObjectY),
				      .isWall(LeftWall)
	 );
	 wall RIGHTWALL(.DrawX(ObjectX + ObjectS),
				       .DrawY(ObjectY),
				       .isWall(RightWall)
	 );
	 
endmodule
