import netP5.*; // 1
import oscP5.*;
import ketai.net.*;
import ketai.sensors.*;

OscP5 oscP5;
KetaiSensor sensor;
NetAddress remoteIpServer;

float myAccelerometerX, myAccelerometerY, myAccelerometerZ;
int x, y, p;
String myIPAddress;
String remoteAddress = "192.168.1.72"; // 2 Customize!

void setup() {
  sensor = new KetaiSensor(this);
  orientation(PORTRAIT);
  textAlign(CENTER, CENTER);
  textSize(50);
  // Inicia la coneccion con el servidor
  initNetworkConnection();
  sensor.start();
}

void draw() {
  background(78, 93, 75);
  text("Remote Mouse Info: \n" + 
      "mouseX: " + x + "\n" +
      "mouseY: " + y + "\n" +
      "mousePressed: " + p + "\n\n" +
      "Local Accelerometer Data: \n" +
      "y: " + nfp(myAccelerometerY, 1, 3) + "\n\n" +
      "Local IP Address: \n" + myIPAddress + "\n\n" +
      "Remote IP Address: \n" + remoteAddress, width/2, height/2
  );
  OscMessage myMessage = new OscMessage("accelerometerData"); // 4
  myMessage.add( 1 );
  myMessage.add( myAccelerometerY ); // 5
  myMessage.add(myAccelerometerZ);
  oscP5.send(myMessage, remoteIpServer); // 6
}

//Recibimos datos del servidor
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkTypetag("iii")){
    x = theOscMessage.get(0).intValue(); // 8
    y = theOscMessage.get(1).intValue();
    p = theOscMessage.get(2).intValue();
  }
}

void onAccelerometerEvent(float x, float y, float z){
  myAccelerometerX = x;
  myAccelerometerY = y;
  myAccelerometerZ = z;
}

void initNetworkConnection(){
  oscP5 = new OscP5(this, 12000); // 9
  remoteIpServer = new NetAddress(remoteAddress, 12000); // 10
  myIPAddress = KetaiNet.getIP(); // 11
}