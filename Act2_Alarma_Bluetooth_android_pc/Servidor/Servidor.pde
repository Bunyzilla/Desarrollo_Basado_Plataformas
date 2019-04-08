import oscP5.*;
import netP5.*;
import ketai.net.*;

OscP5 msgCelular1;
NetAddress remoteLocationCelular1;

// Variables Globales 
String[] event = new String[5];

String myIPAddress;
String remoteAddress = "192.168.1.64";
String prueba;

void setup() {
  size( 1200 , 600 );

  initNetworkConnection();
  event[0] = "0";
  event[1] = "0";
  event[2] = "0";
  event[3] = "0";
  event[4] = "0";

  textAlign(CENTER, CENTER);
  textSize(24);

  rectMode(RADIUS);
  ellipseMode(RADIUS);
  noStroke();
  smooth();
}

void initNetworkConnection(){
  msgCelular1 = new OscP5(this, 12000);
  remoteLocationCelular1 = new NetAddress(remoteAddress, 12000); // 1 Customize!
  myIPAddress = KetaiNet.getIP(); // 11
}

void draw() {
  background(51);

  ///////////////////////////////////////////////////////
  text("Alertas Celular Cliente: " + prueba + "\n" +
  "Alerta 1 : " +  event[0] + "\n" + 
  "Alerta 2 : " +  event[1] + "\n" + 
  "Alerta 3 : " +  event[2] + "\n" + 
  "Alerta 4 : " +  event[3] + "\n" + 
  "Alerta 5 : " +  event[4] + "\n" + 
  "Local IP Address: \n" + myIPAddress + "\n" +
  "Remote IP Address: \n" + remoteAddress, width/2, height/2);

  //Envia un mensaje al celular
  OscMessage myMessage = new OscMessage("mouseStatus");
  myMessage.add("valor del servnuerodor"); // 2
  msgCelular1.send(myMessage, remoteLocationCelular1); 
}

//Recibimos msg del celular
void oscEvent(OscMessage theOscMessage) {
    prueba = theOscMessage.get(0).stringValue();
    event[0] = theOscMessage.get(1).stringValue();
    event[1] = theOscMessage.get(2).stringValue();
    event[2] = theOscMessage.get(3).stringValue();
    event[3] = theOscMessage.get(4).stringValue();
    event[4] = theOscMessage.get(5).stringValue();
}


