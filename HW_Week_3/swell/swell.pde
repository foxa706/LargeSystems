import ddf.minim.*;

Minim minim;
AudioPlayer surf;

JSONObject json;
String key = "73f221c1438fe228567fbace5e12b";

void setup() {
  size(400, 400);
  json = loadJSONObject("http://api.worldweatheronline.com/free/v2/marine.ashx?key=" + key + "&format=json&q=41,-74");
  JSONArray data = json.getJSONObject("data").getJSONArray("weather");
  JSONObject weatherRaw = data.getJSONObject(0);
  JSONArray hourly = weatherRaw.getJSONArray("hourly");
  JSONObject zero = hourly.getJSONObject(0);
  float swellHt = zero.getFloat("swellHeight_m");
  
  minim = new Minim(this);
  surf = minim.loadFile("surf.mp3", 2048);
  
  println("swell height is ");
  print(swellHt);
  print("meters high");
  
}

//  to do: if ( ht < 0.2 ) surf.loop();