import processing.net.*;
Server s;
Client c;

// indexes in the buffer
int X = 0;
int Y = 1;
int bX = 2;
int bY = 3;

float player1x, player1y;
float ballX, ballY;


void setup() {
   s = new Server(this, 1234); 
   size(500, 500);
}

void draw() {
  //send
  byte[] buffer = new byte[4];
  //buffer[X] = (byte)mouseX;
  //buffer[Y] = (byte)mouseY;
  //float byteY = (mouseY-50)/4;
  
  buffer[X] = (byte)0;
  buffer[Y] = (byte)1;
  buffer[bX] = (byte)2;
  buffer[bY] = (byte)3;
  
  s.write(buffer);
  
  //recieve
  Client c = s.available();
  if(c != null) {
    byte[] bufferIn = new byte[4];
    c.readBytes(bufferIn);
    player1x = bufferIn[X];
    player1y = bufferIn[Y]*4;
    ballX = bufferIn[bX]*4;
    ballY = bufferIn[bY]*4;
    println(bufferIn);
    }
  
  println("Player1:  " + player1x + "X, " + player1y + "Y");
  println("Ball: " + ballX +"X, "+ ballY + "Y");
  
}