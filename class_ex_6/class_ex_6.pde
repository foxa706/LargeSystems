import processing.net.*;

Server s;//listening socket
Client c;//communicating socket
void setup(){
  s = new Server (this, 12345);
  
}

void draw(){
  println("Server started on " + s);
  c = s.available();//if no connection simply NULL
  if (c != null){
 println("client: " + c);
 
 println(c.readBytes(buffer));
 }
}