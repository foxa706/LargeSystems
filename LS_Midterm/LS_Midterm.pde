//OSC Pong Midterm - Audrey Fox
//Large Systems 
//Spring 2016
import processing.net.*;
Client c;
Server s;

// buffer index
int X = 0;
int Y = 1;

float speedX = random(3,5);
float speedY = random(3,5);
float ballX = 250.0,
      ballY = 250.0;
float player1x, player1y;
float player2x, player2y;

void setup(){
  c = new Client(this, "127.0.0.1", 1234);
  s = new Server(this, 1234);   
  size(500, 500);
  ellipseMode(CENTER);
  noStroke();
}
void draw(){
  background(210, 135, 237);//purpleish
  Client c = s.available();
  
  if(c != null) {
    byte[] buffer = new byte[2];
    c.readBytes(buffer);
    player1x = buffer[X];
    player1y = buffer[Y]*4;
    println(buffer);
  }
    
    ellipse(ballX, ballY, 20, 20);
    fill(135, 212, 237);//lt blue
    ballX = ballX + speedX;
    ballY = ballY + speedY;
    
    player2x= width-10;
    player2y= mouseY-50;
  
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
 }