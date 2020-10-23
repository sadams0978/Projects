//PA Modified from Samuel Adams
//https://github.com/sadams0978/
//Pacman and Ghost variables
float speed = 1;
float pacmanX = 80;
float pacmanY = 80;
float ghostX = 100;
float ghostY = 100;
float xDelta = 2;
float yDelta = 4;
final float PACMAN_SIZE = 70;
final float GHOST_SIZE = 50;
final float GHOST_PUPIL = 7;
final float GHOST_WHITE = 15;
int numberDots = 50;
int score = 0;
//Array (Single and Multidimensional!) for Dots and Color
int[] dotsX = new int [50];
int[] dotsY = new int [50];
int dotColor [][] = new int [3] [50];
int timeStart, timeEnd;
int z = 0;

//Imports Sound Library
import processing.sound.*;
SoundFile file;

public void setup() {

//set canvas size and color and general options
 frameRate(144);
  size(1200, 500);
  smooth(8);
  background(0);
  textSize(100);
  assignDotPositions();
  textAlign(CENTER);
  timeStart = millis();

//Music
  file = new SoundFile(this, "Theme_Song.mp3");
  file.loop();
  }

/*
* draw - move pacman on diagonals and bounce off top
* and bottom while rapping around left to right
*/
public void draw() {
  timeStart = millis();
  movePacman();
  moveGhost();
  drawDots();
  dotCheck();
  if (numberDots == 0) {
  endScreen();
  System.out.println(System.nanoTime());

  }
}

//Assigns random (x,y) points
public void assignDotPositions() {
  for ( int i = 0; i <50; i++) {
    dotsX[i] = (int) random (100, 1150);
    dotsY[i] = (int) random (50, 450);
//Chooses Random Dot Color
    dotColor[0][i] = (int) random (50, 200);
    dotColor[1][i] = (int) random (50, 200);
    dotColor[2][i] = (int) random (50, 200);
  }
}

//Draws the random points
public void drawDots() {
   for ( int i = 0; i <50; i++) {
     fill(dotColor[0][i], dotColor[1][i], dotColor[2][i]);
    circle(dotsX[i], dotsY[i], 5);
  }
}
//Pacman Eats Dots
public void dotCheck() {
  textSize(15);
  fill(255);
  text("Instructions: Use the WASD Keys to move Pac Man Collecting the Dots! The faster, the higher the score!", 600, 25);
  for (int i = 0; i < 50; i++) {
    if (numberDots >= 35)
    fill(255,0,0);
    else if (numberDots >= 10)
    fill(255, 255, 0);
    else fill (0,255,0);
  //Scoring System
   text("You have " + numberDots +" Dots Left",600 ,50);
   float dist = sqrt((dotsX[i] - pacmanX) * (dotsX[i] - pacmanX) + (dotsY[i] - pacmanY) * (dotsY[i] - pacmanY));
    if (dist <= 40) {
    dotsX[i] = dotsX[i] + 5000;
    numberDots = numberDots- 1;
    int timeBonus = int (700000 / millis());
    score = (score +5) + timeBonus;
  }
 }
}
//The "End Screen and restarts the program!"
public void endScreen () {
  for (z = z; z < 1; z++){
    timeEnd = millis();
    text("It took you " + (timeEnd-timeStart) + "Seconds!", 600, 300);
  }
  // int time = int (timeEnd - timeStart)/1000;
  background(0);
  file.stop();
  textSize(40);
  fill (0, 255, 0);
  text("You Win! Use q to quit or Click to Play Again!",600,100);
  text("Your Score: " + score,600, 200);
  if (key == 'q') {
  exit();
  }
  else if (mousePressed) {
   setup();
   speed = 1;
  pacmanX = 80;
  pacmanY = 80;
  ghostX = 100;
  ghostY = 100;
  xDelta = 2;
  yDelta = 4;
  numberDots = 50;
  file.loop();
  }
}
/*
* DrawPacman - draws a packman a the given x, y
*/
public void drawPacman(float start, float stop) {
//General Drawing of Pac Man
  background(0);
  fill(0);
  fill(201,242,39);
  arc(pacmanX, pacmanY, PACMAN_SIZE, PACMAN_SIZE, start, stop);
}
 public void movePacman() {
     if (key == 'w' && pacmanY > 0) {
      pacmanY = pacmanY - 3;
      drawPacman(radians(30-90),radians(300-90));

    }else if (key == 's' && pacmanY < 500) {
      pacmanY = pacmanY + 3;
      drawPacman(radians(30+90),radians(300+90));

    }else if (key == 'a' && pacmanX > 0) {
      pacmanX = pacmanX - 3;
      drawPacman(radians(30-180),radians(300-180));

    }else if (key == 'd' && pacmanX < 1200) {
      pacmanX = pacmanX + 3;
      drawPacman(radians(30),radians(300));

   }else drawPacman(radians(30),radians(300));
 //Makes pacman wrap depending on the location
if (pacmanX > 1250){
    makePacmanWrap();
  }
}

/*
* makePacmanWrap - puts pacman on left when it reaches right
*/
void makePacmanWrap() {
pacmanX = 5;
pacmanY = random(0, 485);
xDelta = 2;
yDelta = 4;
}

void drawGhost() {
//Draws the Ghost
noStroke();
fill(0,0,255);
circle(ghostX-10, ghostY+5, GHOST_SIZE);
rect(ghostX-35, ghostY+5, GHOST_SIZE, GHOST_SIZE/2);

//Draws Eyes and Pupil
fill(255);
circle(ghostX, ghostY, GHOST_WHITE);
fill(0);
circle(ghostX, ghostY, GHOST_PUPIL);
fill(255);
circle(ghostX-20, ghostY, GHOST_WHITE);
fill(0);
circle(ghostX-20, ghostY, GHOST_PUPIL);
}

void moveGhost() {
//Constrains to Canvas
float MouseX = constrain(mouseX, 30, 1175);
float MouseY = constrain(mouseY, 25, 470);

//Takes those constrainted values and moves direction based on them
double ghostXdelta = MouseX / ghostX;
double ghostYdelta = MouseY / ghostY;

if (ghostXdelta >1){
ghostX++;
drawGhost();
} else if (ghostXdelta <1) {
ghostX --;
drawGhost();
} else if (ghostYdelta <1){
ghostY --;
drawGhost();
} else if (ghostYdelta >1) {
 ghostY ++;
 drawGhost();
} else drawGhost();

}
