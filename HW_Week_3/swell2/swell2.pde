/**
  marine weather data from world weather online
  Minim Gain code resource Damien Di Fede
*/

import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
FilePlayer filePlayer;
Gain       gain;
AudioOutput out;

// you can use your own file by putting it in the data directory of this sketch
// and changing the value assigned to fileName here.
String waveAudio = "surf.mp3";
JSONObject json;
String key = "x";
float mapSwell;

void setup()
{
  size(640, 240);

  minim = new Minim(this);                          
  filePlayer = new FilePlayer( minim.loadFileStream(waveAudio) );
  filePlayer.loop();
  
  // start the Gain at 0 dB, which means no change in amplitude
  gain = new Gain(0.f);
  
  // get a line out from Minim. It's important that the file is the same audio format 
  // as our output (i.e. same sample rate, number of channels, etc).
  out = minim.getLineOut();
  
  // patch the file player to the output
  filePlayer.patch(gain).patch(out);
  
  json = loadJSONObject("http://api.worldweatheronline.com/free/v2/marine.ashx?key=" + key + "&format=json&q=40,-73");
  JSONArray data = json.getJSONObject("data").getJSONArray("weather");
  JSONObject weatherRaw = data.getJSONObject(0);
  JSONArray hourly = weatherRaw.getJSONArray("hourly");
  print(hourly);
  JSONObject zero = hourly.getJSONObject(7);
  float swellHt = zero.getFloat("swellHeight_m");
  mapSwell = swellHt;
  println("wave ht: " + mapSwell);
                        
}

void draw()
{
  float dB = map(mapSwell, 0.0, 4.0, -6.0, 6.0);
  gain.setValue(dB);
  
  background( 64, 141, 167 );
  stroke( 28, 107, 160 );
//draw wave
  for( int i = 0; i < out.bufferSize() - 1; i++ )
  {
    float x1  =  map( i, 0, out.bufferSize(), 0, width );
    float x2  =  map( i+1, 0, out.bufferSize(), 0, width );

    strokeWeight(4);
    line( x1, 50 + out.left.get(i)*50, x2, 400 + out.left.get(i+1)*50);
  }  
  textSize(18);
  float waveFeet = mapSwell*3.28;
  text("Current wave height: " + mapSwell + " m, " + waveFeet + " ft", 10, 30);
  fill( 120, 182, 164 );
}