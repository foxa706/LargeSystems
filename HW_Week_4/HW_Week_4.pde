/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
 
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress myRemoteLocation;

PImage img;
float location;
float oldLocation;
PFont f;

void setup() {
  size(400,400);
  background(255);
  f = createFont("Comic_Sans.ttf", 28);
  textFont(f);
  img = loadImage("Doge-1.png");
  img.resize(225,300);
  image(img, 75, 75);
  //frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12000);
  
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("149.31.126.128",12000);
}


void draw() {
  if (location != oldLocation){
  text("wow", location, oldLocation);
  float r = random(00.0, 200.0);
  float g = random(0.0, 200.0);
  float b = random(0.0, 200.0);
  fill(r, g, b);
  }
}

void mousePressed() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/Hey_Raha");
  
  //myMessage.add(666); /* add an int to the osc message */
  float num = random(-20.0, 20.0);
  myMessage.add(num); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 
}



/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  oldLocation = location;
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  location = theOscMessage.get(0).floatValue();
}