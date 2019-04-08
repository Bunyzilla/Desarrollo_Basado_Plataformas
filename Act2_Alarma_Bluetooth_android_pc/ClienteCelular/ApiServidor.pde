import netP5.*; // 1
import oscP5.*;
import ketai.net.*;

//////Conexion Servidor wifi
OscP5 oscP5;
NetAddress remoteIpServer;

String datosServidor;
String myIPAddress;
String remoteAddress = "192.168.1.72"; // 2 Customize!

// Variables Globales 
String[] event = new String[5];

//Recibimos datos del servidor 911
void oscEvent(OscMessage theOscMessage) {
  datosServidor = theOscMessage.get(0).stringValue();
}

void initNetworkConnection(){
  oscP5 = new OscP5(this, 12000); // 9
  remoteIpServer = new NetAddress(remoteAddress, 12000); // 10
  myIPAddress = KetaiNet.getIP(); // 11
}

void enviarInfoServidor(){
    OscMessage myMessage = new OscMessage("accelerometerData"); // 4
    myMessage.add("simon"); //0
    myMessage.add(event[0]);//1
    myMessage.add(event[1]);//2
    myMessage.add(event[2]);//3
    myMessage.add(event[3]);//4
    myMessage.add(event[4]);//5
    
    oscP5.send(myMessage, remoteIpServer); // 6
}

