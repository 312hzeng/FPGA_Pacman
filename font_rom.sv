module font_rom (input [9:0]DrawX, DrawY,
					  input isPacman, isGhost1, isGhost2, isFood,
					  input [1:0] pac_move,
					  output[1:0] data
					  );

	always_comb 
	begin

		logic [3:0] drawx, drawy;
		logic [10:0] index;

		int Pac1[256];
		int Pac2[256];
		int Pac3[256];
		int Pac4[256];
		int Pac5[256];
		int Pac6[256];
		int Ghost1[256];
		int Ghost2[256];
		int Ghost3[256];
		int Ghost4[256];
		int Ghost5[256];
		int Ghost6[256];
		int Ghost7[256];
		int Ghost8[256];
		int Food[256];
	
	
		Pac1 = '{
			// pacman horizontal
			0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0, //0
			0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0, //1
			0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0, //2
			0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0, //3
			0,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1, //4
			0,1,1,1,1,0,0,1,1,1,1,0,0,0,0,0, //5
			1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0, //6				pac1 -> pac2 -> pac3 -> pac2 
			1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0, //7
			1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0, //8
			1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0, //9
			0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0, //10
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, //11
			0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0, //12
			0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0, //13
			0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0, //14
			0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0  //15
		};

		Pac2 = '{
			//mouth partially closed - horizontal
			0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0, //0
			0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0, //1
			0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0, //2
			0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0, //3
			0,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1, //4
			0,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1, //5
			1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0, //6
			1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0, //7
			1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0, //8
			1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0, //9
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, //10
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, //11
			0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0, //12
			0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0, //13
			0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0, //14
			0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0  //15
		};

		Pac3 = '{
			//mouth fully closed - horizontal
			0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0, //0
			0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0, //1
			0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0, //2
			0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0, //3
			0,1,1,1,1,0,0,1,1,1,1,1,1,1,1,0, //4
			0,1,1,1,1,0,0,1,1,1,1,1,1,1,1,0, //5
			1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, //6
			1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, //7
			1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, //8
			1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, //9
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0, //10
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0, //11
			0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0, //12
			0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0, //13
			0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0, //14
			0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0  //15
		};

		Pac4 = '{
			// pacman vertical
			0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,  //0
			0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,  //1
			0,0,1,1,1,0,0,0,0,0,0,1,1,1,0,0,  //2
			0,0,1,1,1,0,0,0,0,0,0,1,1,1,1,0,  //3
			0,1,1,1,1,0,0,0,0,0,0,1,1,1,1,0,  //4
			1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,  //5
			1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,  //6
			1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,  //7
			1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,  //8
			1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,  //9
			0,1,1,1,0,0,1,1,1,1,1,1,1,1,1,0,  //10
			0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,  //11
			0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,  //12
			0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,  //13
			0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,  //14
			0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0  //15
		};

		Pac5 = '{
			// mouth partially closed - vertical
			0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,  //0
			0,0,0,1,1,1,0,0,0,0,1,1,1,0,0,0,  //1
			0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,  //2
			0,0,1,1,1,1,0,0,0,0,1,1,1,1,1,0,  //3
			0,1,1,1,1,1,0,0,0,0,1,1,1,1,1,0,  //4
			1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,  //5
			1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,  //6
			1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,  //7
			1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,  //8
			1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,  //9
			0,1,1,1,0,0,1,1,1,1,1,1,1,1,1,0,  //10
			0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,  //11
			0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,  //12
			0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,  //13
			0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,  //14
			0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0  //15
		};

		Pac6 = '{
			//mouth fully closed - vertical
			0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0, //0
			0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0, //1
			0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0, //2
			0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0, //3
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0, //4
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0, //5
			1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, //6
			1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, //7
			1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, //8
			1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1, //9
			0,1,1,1,0,0,1,1,1,1,1,1,1,1,1,0, //10
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0, //11
			0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0, //12
			0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0, //13
			0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0, //14
			0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0  //15
		};


		Ghost1 = '{
			//ghost eyes left
			0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,  //0
			0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,  //1
			0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,  //2
			0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,  //3
			0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,  //4
			0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,  //5
			0,0,1,2,2,0,0,1,1,2,2,0,0,1,0,0,  //6
			0,1,1,2,2,0,0,1,1,2,2,0,0,1,1,0,  //7
			0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,  //8
			0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,  //9
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //10
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //11
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //12
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //13
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //14
			0,1,1,1,1,0,1,1,1,1,0,1,1,1,1,0  //15
		};

		Ghost2 = '{
			//ghost eyes left, second movement
			0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,  //0
			0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,  //1
			0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,  //2
			0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,  //3
			0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,  //4
			0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,  //5
			0,0,1,2,2,0,0,1,1,2,2,0,0,1,0,0,  //6
			0,1,1,2,2,0,0,1,1,2,2,0,0,1,1,0,  //7
			0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,  //8
			0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,  //9
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //10
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //11
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //12
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //13
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //14
			0,1,1,0,1,1,1,1,0,1,1,1,1,0,1,1  //15
		};

		Ghost3 = '{
			//ghost eyes right
			0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,  //0
			0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,  //1
			0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,  //2
			0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,  //3
			0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,  //4
			0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,  //5
			0,0,1,0,0,2,2,1,1,0,0,2,2,1,0,0,  //6
			0,1,1,0,0,2,2,1,1,0,0,2,2,1,1,0,  //7
			0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,  //8
			0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,  //9
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //10
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //11
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //12
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //13
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //14
			0,1,1,1,1,0,1,1,1,1,0,1,1,1,1,0  //15
		};

		Ghost4 = '{
			//ghost eyes right, second movement
			0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,  //0
			0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,  //1
			0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,  //2
			0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,  //3
			0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,  //4
			0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,  //5
			0,0,1,0,0,2,2,1,1,0,0,2,2,1,0,0,  //6
			0,1,1,0,0,2,2,1,1,0,0,2,2,1,1,0,  //7
			0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,  //8
			0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,  //9
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //10
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //11
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //12
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //13
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //14
			0,1,1,0,1,1,1,1,0,1,1,1,1,0,1,1  //15
		};


		Ghost5 = '{
			//ghost eyes up
			0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,  //0
			0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,  //1
			0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,  //2
			0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,  //3
			0,0,1,0,2,2,0,1,1,0,2,2,0,1,0,0,  //4
			0,0,1,0,2,2,0,1,1,0,2,2,0,1,0,0,  //5
			0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,  //6
			0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,  //7
			0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,  //8
			0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,  //9
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //10
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //11
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //12
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //13
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //14
			0,1,1,1,1,0,1,1,1,1,0,1,1,1,1,0  //15
		};

		Ghost6 = '{
			//ghost eyes up, second movement
			0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,  //0
			0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,  //1
			0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,  //2
			0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,  //3
			0,0,1,0,2,2,0,1,1,0,2,2,0,1,0,0,  //4
			0,0,1,0,2,2,0,1,1,0,2,2,0,1,0,0,  //5
			0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,  //6
			0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,  //7
			0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,  //8
			0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,  //9
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //10
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //11
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //12
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //13
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //14
			0,1,1,0,1,1,1,1,0,1,1,1,1,0,1,1  //15
		};

		Ghost7 = '{
			//ghost eyes up
			0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,  //0
			0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,  //1
			0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,  //2
			0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,  //3
			0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,  //4
			0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,  //5
			0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,  //6
			0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,  //7
			0,1,1,0,2,2,0,1,1,0,2,2,0,1,1,0,  //8
			0,1,1,0,2,2,0,1,1,0,2,2,0,1,1,0,  //9
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //10
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //11
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //12
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //13
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //14
			0,1,1,1,1,0,1,1,1,1,0,1,1,1,1,0  //15
		};

		Ghost8 = '{
			//ghost eyes up, second movement
			0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,  //0
			0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,  //1
			0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,  //2
			0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,  //3
			0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,  //4
			0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,  //5
			0,0,1,0,0,0,0,1,1,0,0,0,0,1,0,0,  //6
			0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,  //7
			0,1,1,0,2,2,0,1,1,0,2,2,0,1,1,0,  //8
			0,1,1,0,2,2,0,1,1,0,2,2,0,1,1,0,  //9
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //10
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //11
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //12
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //13
			0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,  //14
			0,1,1,0,1,1,1,1,0,1,1,1,1,0,1,1  //15
		};
		
		Food = '{
			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  //0
			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  //0
			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  //0
			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  //0
			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  //0
			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  //0
			0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,  //0
			0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,  //0
			0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,  //0
			0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,  //0
			0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,  //0
			0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,  //0
			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  //0
			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  //0
			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  //0
			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0  //0
		};
		
		drawx = DrawX[3:0];
		drawy = DrawY[3:0];
		index = drawy * 16 + drawx;
		
		if(isPacman == 1 && pac_move == 0)
		begin
			  data = Pac1[index];
		end
		else if(isPacman == 1 && pac_move == 1)
		begin
			  data = Pac2[index];
		end
		else if(isPacman == 1 && pac_move == 2)
		begin
			  data = Pac3[index];
		end
		else if(isGhost1 == 1)
		begin
		    data = Ghost1[index];
		end
		else if(isGhost2 == 1)
		begin
		    data = Ghost3[index];
		end
		else if(isFood == 1)
		begin
			  data = Food[index];
		end
		
		else
		     data= 0;
		
  end
endmodule
