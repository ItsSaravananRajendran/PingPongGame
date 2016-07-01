/* @pjs font="ARCADECLASSIC.TTF"; */

//global variables
float ballRadius , ballX , ballY , topMargin, bottomMargin  , speedX, speedY, dampingFactor, dirX , dirY,timer;
boolean startGame, selectLevel , timedOut;
string scoreStatement;
//rgb color
int r,g,b;
// player declaration
computer comp= new computer();
player you = new player();	
	

//instructionBanner
void instructionBanner(){
	textSize(32);
	fill(255);
	text("CLICK   BELOW.....",300,360);
}

//PONG banner
void pongBanner(int x, int y){
		textSize(120);
		r%=255;
		g%=255;
		b%=255;
		fill(r,g,b);
		r+=3;
		g+=3;
		b+=3;
		noStroke();
		rect(x,y,300,150,10);
		fill(r,g,b);
		fill(150);
		rect(x+10,y+10,280,130,10);
		fill(0);
		text("PONG",x+20,y+110);
}

//playButton
void playButton(){
	textSize(42);
	fill(g+2,b+5,r+21);
	noStroke();
	rect(325,400,150,50,10);
	fill(150);
	rect(330,405,140,40,5);
	fill(0);
	text("play",350,439);	
}

//beginners Button
void beginnersButton(){
	textSize(40);
	fill(b,g,r);
	noStroke();
	rect(50,300,195,50,10);
	fill(150);
	rect(55,305,185,40,5);
	fill(0);
	text("BEGINEER",60,340);
}

//intermediate Button
void intermediateButton(){
	textSize(35);
	fill(b,g,r);
	noStroke();
	rect(270,300,245,50,10);
	fill(150);
	rect(275,305,235,40,5);
	fill(0);
	text("INTERMEDIATE",280,337);
}

//expert button
void expertButton(){
	textSize(40);
	fill(b,g,r);
	noStroke();
	rect(550,300,170,50,10);
	fill(150);
	rect(555,305,160,40,5);
	fill(0);
	text("EXPERT",570,340);
}

//instruction Banner for player
void gameplayInstruction(){
	textSize(32);
	fill(255);
	text("SELECT DIFFICULTY",250,260);
	string instruction1="Press   w  to  move  the  paddle  up";
	string instruction2="Press  s  to  move  the  paddle  down";
	string instruction3="First  one  to  score  10  points  wins  the  game";
	text("How  to  play  the  game",240, 400);
	text(instruction1,190,460);
	text(instruction2,175,490);
	textSize(35);
	fill(255,0,0);
	text(instruction3,60,540);
				
}


void mousePressed(){
	//prevents unwanted mouse press
	if(comp.score>9 || you.score > 9){
		//resets the games
		startGame = false;
		selectLevel=false;	
		timedOut=false;
		comp.score=0;
		you.score=0;
		loop();	
	}
	//starts the game
	if(!startGame){
		//play button
		if(mouseX>325 && mouseX<475 && mouseY>400 && mouseY<450){
		startGame= true;
	}
		}
	else{
		if(!selectLevel){
			//beginners button
			if(mouseX > 50&& mouseX<245 && mouseY>300 && mouseY<350){
				dampingFactor=0.55;
				selectLevel=true;
			}
			
			//intermediate button
			if(mouseX > 270 && mouseX< 515&& mouseY>300 && mouseY<350){
				dampingFactor=0.60;
				selectLevel=true;
			}
			
			if(mouseX > 550 && mouseX< 720 && mouseY>300 && mouseY<350){
				dampingFactor=0.65;
				selectLevel=true;
			}
		}
	}
}

//creates the Border
void createBorder(){
	for(int i=0;i<=height;i+=20){
		stroke(255);
		line(400,i,400,i+10);
	}
}

//abstract class of paddle
abstract class paddle{
	//paddle size
	int paddleLength=90, paddleWidth = 10;
	//score
	public int score;
	//position 
	float paddleY = 255.0 , paddleX;
	//speed
	float paddleSpeed=.1;
	//hitting the ball
	abstract void paddleHit();

	
	//displays the paddle
	public void paddleDisplay(){
		fill(255);
		rect(this.paddleX,this.paddleY,this.paddleWidth,this.paddleLength,5);
	}
	
	//bring within range
	void backToRange(){
		if(this.paddleY>=540){
			this.paddleY=539;
		}
		if(this.paddleY<=0){
			this.paddleY=1;
		}
	}
}

//player class
class player extends paddle{
	//constructor
	player(){
		this.paddleX=770; // width-30
		this.score=0;
	}

	//paddle hits the ball
	void paddleHit(){
		if(this.paddleY<=ballY && ballY <= (this.paddleY+paddleLength)){
			if(ballX>755){
				//reflect ball
				paddleBounce();
				//increases the ballspeed	
				if(dirX<0){
					dirX-=this.paddleSpeed;	
				}			
				else{
					dirX-=this.paddleSpeed;
				}			
				this.paddleSpeed=0;	
			}
		}
	}		
	
	//padddle movement
	public void movePaddle(float paddledir){
		paddleY+=paddledir;
		this.paddleSpeed+=.01;
	}
}

//computer class
class computer extends paddle{
	//constructor
	computer(){
		this.paddleX=20; //0+20
		this.score=0;
	}
		
	void paddleHit(){
		if(this.paddleY<=ballY && ballY <= (paddleY+this.paddleLength)){
			if(ballX<45){
				//reflect ball
				paddleBounce();
				//transfers speed
				if(dirX<0){
					dirX-=this.paddleSpeed;	
				}			
				else{
					dirX-=this.paddleSpeed;
				}		
			}
			this.paddleSpeed=0;
		}
	}
	
	void paddleMovement(){
		paddleY=(float) (dampingFactor*ballY);
		this.paddleSpeed+=.1;
	}
}

//user control
void keyPressed(){
	int keypair=(int)key;
	//when w is pressed
	if(keypair==119){
		you.movePaddle(-5.0);
	}		
	//when s is pressed
	if(keypair==115){
		you.movePaddle(5.0);
	}
}

void keyReleased(){
	you.paddleSpeed=0.0;
}



void setup(){
	//canvas size
	size(800,600);	
	background(0);
	//sets the speed
	speedX=2;
	speedY=2;
	//margin
	topMargin=30;
	bottomMargin=height;	 
	//game options
	startGame=false;
	selectLevel=false;	
	timedOut=false;
	//color
	r=100;
	g=150;
	b=15;	
	//loads font
	textFont(createFont("ARCADECLASSIC.TTF",120));
	timer=2.5;
	ballRadius=15;
}

void draw(){
	background(0);
	if(startGame){
		//game screen
		if(selectLevel){
			createBorder();
			textSize(60);
			fill(150);
			text("Comp",150,300);
			text("you",550,300);		
			if(timedOut){
				ballMove();
				ballDisplay();
				ballBounce();
				leftScreen();
				displayScore();
				checkWinner();
				comp.paddleDisplay();
				you.paddleDisplay();
				comp.paddleHit();
				you.paddleHit();
				comp.paddleMovement();
				you.backToRange();
			}
			else{
				
				textSize(50);
				fill(255);
				text("Game starts in ",220,250);
				textSize(60);	
				timer-=0.01;
				text(timer,340,350);
				if(timer<0.1){
					timedOut=true;
				}
				
			}
			
		}
		//difficulty selecting screen
		else{
			pongBanner(250,50);
			beginnersButton();	
			intermediateButton();
			expertButton();
			gameplayInstruction();
			stroke(255);
			line(0,370,800,370);
			//centers the ball
			ballCenter();
			//set direction of the ball
			setDirection();
			timer=3.0;
		}
	}	
	//Start game screen 
	else{	
		pongBanner(250,100);
		playButton();
		instructionBanner();
	}
}

//center the ball
void ballCenter(){
	ballX=width/2;
	ballY=height/2;
}

//ball movment
void ballMove(){
	ballX=dirX+speedX+ballX;
	ballY=dirY+speedY+ballY;
}


//set direction of ball
void setDirection(){
	dirX=random(-1,1);
	dirY=random(-1,1);
	if(dirX<0 && speedX>0){
		speedX*=-1;
	}
	if(dirY<0 && speedY>0){
		speedY*=-1;
	}
}

void ballDisplay(){
	fill(255);
	ellipse(ballX,ballY,ballRadius,ballRadius);
}

//reflect from top and bottom 
void ballBounce(){
	if(ballY>(height-ballRadius) || ballY<(ballRadius)){
		dirY*=-1;
		speedY*=-1;
	}
}

//left the screen
void leftScreen(){
	if(ballX>width){
		ballCenter();
		setDirection();
		comp.score++;
	}
	if(ballX<0){
		ballCenter();
		setDirection();
		you.score++;
	}
}

void displayScore(){
	textSize(70);
	text(comp.score,300,70);
	text(you.score,470,70);
}

void checkWinner(){
	if(comp.score>9){
		fill(0);
		noStroke();
		rect(100,250,250,100);
		rect(500,250,250,100);
		textSize(50);
		fill(255);
		text("i  won.. ",350,400);
		text(" click  to  try   again",200,500);
		noLoop();
	}
	if(you.score>9){
		fill(0);
		noStroke();
		rect(100,250,250,100);
		rect(500,250,250,100);
		textSize(50);
		fill(255);
		text("You  won.. ",310,400);
		text(" click  to  try  your  luck  again",70,500);
		noLoop();
	}
}

//reflect from paddle
void paddleBounce(){
	dirX*=-1;
	speedX*=-1;
}









  
