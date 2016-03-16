import processing.net.*;

Client c;//communicating socket
void setup(){
 c = new Client(this, "127.0.0.1", 12345);
  
}

void draw(){
  byte[] buffer = new byte[3];
  buffer[0]= (byte)200;
  buffer[1]= (byte)100;
  buffer[2]= (byte)100;
  c.write(buffer);
}