//Player 1 -- CLIENT
//OSC Pong Midterm - Audrey Fox
//Large Systems 
//Spring 2016
import processing.net.*;
Client c;

// buffer index
int X = 0;
int Y = 1;
int bX = 2;
int bY = 3;

float speedX = random(3,5);
float speedY = random(3,5);

float ballX, ballY;

float player1x = 490, player1y;
float player2x = 0, player2y;

void setup(){
  c = new Client(this, "127.0.0.1", 1234);
  size(500, 500);
  ellipseMode(CENTER);
  noStroke();
}

void draw(){
  background(210, 135, 237);//purpleish
  //send
  c = new Client(this, "127.0.0.1", 1234);
  float p1BuffY = (mouseY-50)/4,
        updateBallY = ballY /4,
        updateBallX = ballX /4;
  float sendBallx = updateBallX, sendBally = updateBallY;

  byte[] buffer = new byte[4];
  float sendP1x=player1x/4;
  
  buffer[X] = (byte)sendP1x;
  buffer[Y] = (byte)p1BuffY;
  buffer[bX] = (byte)sendBallx;
  buffer[bY] = (byte)sendBally;
  c.write(buffer);
  println(buffer);
  
  //read
  if(c.available() > 0) {
  byte[] bufferIn = new byte[4];
  c.readBytes(bufferIn);
  player2x = bufferIn[X];
  player2y = bufferIn[Y]*4;
  //ballX = bufferIn[bX]*4;
  //ballY = bufferIn[bY]*4;
  println(bufferIn);
  }
    
    ellipse(ballX, ballY, 20, 20);
    fill(135, 212, 237);//lt blue
    ballX = ballX + speedX;
    ballY = ballY + speedY;
    
    
    player1y= mouseY-50;
  
    rect(player1x, player1y, 10, 100);//player1
    rect(player2x, player2y, 10, 100);//player2
  

    //if ball hits player1
      if(ballX > 5 && ballX < 10 && ballY > mouseY-50 && ballY < mouseY+50 ){
      speedX = speedX * -1.0;
      ballX = ballX + speedX;
      fill(255);
    }
    
    //if ball hits player2
    if(ballX > width-10 && ballX < width-5 && ballY > mouseY-50 && ballY < mouseY+50 ){
      speedX = speedX * -1.0;
      ballX = ballX + speedX;
      fill(255);
    }
  
    //if the ball hits top or bottom
    if (ballY < 0 || ballY > height) {
      speedY = speedY * -1.0;
      ballY = ballY + speedY;
    }

    //if the ball goes off screen
     if (ballX < 0 || ballX > width) {
      speedY = speedY * (random(1)*-1.0);
      ballY = 250;
      ballX = 250;
    }
 }
 