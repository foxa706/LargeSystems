import processing.net.*;
Server s;
Client c;

// indexes in the buffer
int X = 0;
int Y = 1;
int bX = 2;
int bY = 3;

float player1x, player1y;
float player2x, player2y;

float ballX, ballY,
      p1BallX, p1BallY,
      qBallY = ballY /4,
      qBallX = ballX /4;
float sendBallx = qBallX, sendBally = qBallY;


void setup() {
   s = new Server(this, 1234); 
   size(500, 500);
}

void draw() {
  //send
  //byte[] buffer = new byte[4];
  //float mouseBuffy = (mouseY-50)/4;
  
  //buffer[X] = (byte)0;
  //buffer[Y] = (byte)mouseBuffy;
  //buffer[bX] = (byte)sendBallx;
  //buffer[bY] = (byte)sendBally;
  
  //s.write(buffer);
  
  //recieve
  Client c = s.available();
  if(c != null) {
    byte[] bufferIn = new byte[4];
    c.readBytes(bufferIn);
    player1x = bufferIn[X];
    player1y = bufferIn[Y]*4;
    p1BallX = bufferIn[bX]*4;
    p1BallY = bufferIn[bY]*4;
    println(bufferIn);
    }
  
  println("Player1:  " + player1x + "X, " + player1y + "Y");
  println("Ball: " + p1BallX +"X, "+ p1BallY + "Y");
  //------------------
  background(210, 135, 237);
  ballX = p1BallX;
  ballY = p1BallY;
  ellipse(ballX, ballY, 20, 20);
  fill(135, 212, 237);
  //ballX = ballX + speedX;
  //ballY = ballY + speedY;
    
}