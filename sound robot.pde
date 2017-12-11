import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// Sound for hit
Minim minim;
AudioPlayer player;

float x = 0;
float y = 0;
float dx = 1;
float dy = 1;

float accx = 0.5;
float accy = 0.8;

float bw = 150;
float bh = 30;
String bTxt = "START";

float radEnemy = 30;

Boolean scene1 = true;
Boolean scene2 = false;
Boolean scene3 = false;

// parameters for robot
float rw = 45;
float rh = 153;

void setup() {
  size(600, 600);
   setupSound();
}
void setupSound() {
    // instantiate lib and load sound to play
  minim = new Minim(this);
  player = minim.loadFile("hit.wav");
}

void draw() {
  background(255);

  if (scene2 == true) {
    // draw robot
    drawMycustomRobot(mouseX, mouseY, 100, 200, 500);
    
    x = x+accx*dx;
    y = y +accy*dy;

    if (x > width || x < 0)
    {
      accx = random(0.1, 5);
      dx = dx*-1;
    }

    if ( y > height || y < 0) {
      accy = random(0.1, 5);
      dy = dy*-1;
    }

   
    
    fill(#125FFF);
    noStroke();
    ellipse(x, y, radEnemy, radEnemy);

    // Check hit detection with robot and enemy ball
    if (mouseX + rw/2 > x-radEnemy/2 && mouseX - rw/2 < x + radEnemy/2
      && mouseY + rh/2> y - radEnemy/2 && mouseY - rh/2 < y + radEnemy/2) {
        scene3 = true;
        scene1 = false;
        scene2 = false;
         /// Play preloaded sound when it hits 
      player.rewind();
      player.play();
        
    }
  }

  if (scene1 == true) {
    startButton();
  }
  
  // Scene 3 content
  if(scene3 == true) {
    fill(255,0,0,150);
    rect(0,0,width,height); 
  }
}

void startButton() {
  pushMatrix();
  translate(width/2 - bw/2, height/2 - bh/2);
  fill(#FF5303);


  noStroke();
  rect(0, 0, bw, bh);

  fill(255);
  text(bTxt, bw/2 - textWidth(bTxt)/2, 18 );
  popMatrix();
}

void mousePressed() {
  if (mouseX > width/2 - bw/2 && mouseX < width/2 - bw/2 + bw
    && mouseY > height/2 - bh/2 && mouseY < height/2 - bh/2 + bh) {
    scene1 = false;
    scene2 = true;
    scene3 = false;
  }
}

void drawMycustomRobot(float xpos, float ypos, float r, float g, float b) {
  pushMatrix();

  //translate(mouseX,mouseY);
  translate(xpos - 50 + 25, ypos - 150 + 75);
  fill(255,0,0,50);
  rect(100,40,200,190);
  scale(0.5, 0.5);
  //Draw rectangle
fill(#FF766A);
stroke(#030000);
rect(330,100,150,90);
fill(#D37F77);
rect(280,220,240,170);
fill(#DE9A94);
rect(290,240,230,150);
fill(#F5C3BE);
rect(300,260,220,130);
fill(#F59188);
rect(310,280,210,110);
fill(#FF7164);
rect(320,300,200,90);
fill(#F0D1CE);
rect(330,320,190,70);
fill(#F0928A);
rect(340,340,180,50);
fill(#F0D1CE);
rect(350,360,170,30);
fill(#FF766A);
rect(360,380,160,10);


//Drawing eyes
fill(#5F312D);
stroke(#FFFDFC);
ellipse(355,120,25,25);
ellipse(455,120,25,25);

//Draw mouth
fill(#DB2B1B);
stroke(#FFFDFC);
rect(380,150,50,25);

//Drawing legs
fill(#DB2B1B);
stroke(#030000);
rect(305,395,15,15);
rect(305,440,15,15);
rect(485,395,15,15);
rect(485,440,15,15);

//Drawing arms
fill(#FF7164);
rect(525,305,75,25);
rect(200,305,75,25);
  popMatrix();
}