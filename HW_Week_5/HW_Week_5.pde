import processing.net.*;

Client c;
String input;
int data[];

PFont f;
PImage img;

void setup() 
{
  size(400,400);
  background(255);
  f = createFont("Comic_Sans.ttf", 28);
  textFont(f);
  img = loadImage("Doge-1.png");
  img.resize(225,300);
  image(img, 75, 75);
  frameRate(5); 
  c = new Client(this, "ipHere", 12345); // Replace with your server's IP and port
}

void draw() 
{
  if (mousePressed == true) {
    c.write(pmouseX + " " + pmouseY + "\n");
  }
  // Receive data from server
  if (c.available() > 0) {
    input = c.readString();
    input = input.substring(0, input.indexOf("\n")); // Only up to the newline
    data = int(split(input, ' ')); // Split values into an array
    // Draw line using received coords
    stroke(0);
    text("wow", data[0], data[1]);
    float r = random(00.0, 200.0);
    float g = random(0.0, 200.0);
    float b = random(0.0, 200.0);
    fill(r, g, b);
  }
}