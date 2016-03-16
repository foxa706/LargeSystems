//OSC Pong Midterm - Audrey Fox
//Large Systems 
//Spring 2016

float speedX = random(3,5);
float speedY = random(3,5);
float ballX = 250.0,
      ballY = 250.0;
float player1x, player1y;
float player2x, player2y;

void setup(){
  size(500, 500);
  ellipseMode(CENTER);
  noStroke();
}
void draw(){
  background(210, 135, 237);//purpleish
  ellipse(ballX, ballY, 20, 20);
  fill(135, 212, 237);//lt blue
  ballX = ballX + speedX;
  ballY = ballY + speedY;
  
  rect(width-10, mouseY-50, 10, 100);
  rect(0, mouseY-50, 10, 100);
  
  //if ball hits player1
  if(ballX > width-10 && ballX < width-5 && ballY > mouseY-50 && ballY < mouseY+50 ){
    speedX = speedX * -1.0;
    ballX = ballX + speedX;
    fill(255);
  }
  //if ball hits player2
    if(ballX > 5 && ballX < 10 && ballY > mouseY-50 && ballY < mouseY+50 ){
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