import oscP5.*;
import netP5.*;

OscP5 msgCelular1;
OscP5 msgCelular2;
NetAddress remoteLocationCelular1;
NetAddress remoteLocationCelular2;

// Variables Globales para la pelota
float ball_x;
float ball_y;

float ball_dir = 1;  // Direction X
float dy = 0;  // Direction Y

float ball_size = 25;  // Radius

// Variables Globales Pad izquierdo
float paddle_y1;
float extMouseY1;
float PextMouseY1;
// Variables Globales Pad derecho
float paddle_y2;
float extMouseY2;
float PextMouseY2;

// Variables Globales para el tamaño de los pads
int paddle_width = 25;
int paddle_height = 70;

int dist_wall = 15;

int anchoP = 1200, altoP = 600;
void setup() {
  size( 1200 , 600 );

  msgCelular1 = new OscP5(this, 12000);
  msgCelular2 = new OscP5(this, 12000);
  //Ip Celular 1
  remoteLocationCelular1 = new NetAddress("192.168.1.67", 12000); // 1 Customize!
  //Ip Celular 2
  remoteLocationCelular2 = new NetAddress("192.168.1.67", 12001); // 1 Customize!
  
  textAlign(CENTER, CENTER);
  textSize(24);

  rectMode(RADIUS);
  ellipseMode(RADIUS);
  noStroke();
  smooth();
  ball_y = height/2;
  ball_x = 1;
}

void draw() {
  background(51);

  // Movemos los valores de la posicion de la bola 
  // para analisarlas y despues dibujarla en esta posision 
  ball_x += ball_dir * 30;
  ball_y += dy;

  /*
  // resetea la bola si se salio del lado derecho
  if(ball_x > width+ball_size) {
    // Sale del lado derecho
    ball_x = -width/2 - ball_size;
    // Sale en una posicion random en el eje de las Y
    ball_y = random(0, height);
    // Sale Horizontalmente 
    dy = 0;
  }
  */

  // Si toca la pared derecha cambia de direccion 
  if(ball_x > width+ball_size) {
    ball_dir *= -1;
  }
  
  // Si toca la pared izquierda cambia de direccion 
  if(ball_x < ball_size && ball_dir == -1) {
    ball_dir *= -1;
  }

  // Ajustando variable entre los valores permitidos del pad derecho
  paddle_y1 = constrain(
    extMouseY1, paddle_height, height-paddle_height
  );

  // Checar si la bola toca el panel IZQUIERDO
  float py1 = width-dist_wall-paddle_width-ball_size;

  if(ball_x >= py1 
     && ball_y > paddle_y1 - paddle_height - ball_size 
     && ball_y < paddle_y1 + paddle_height + ball_size) {
      ball_dir *= -1;

      if(extMouseY1 != PextMouseY1) {
        dy = (extMouseY1-PextMouseY1)/2.0;
      }
  } 

  // Ajustando variable entre los valores permitidos del pad derecho
  paddle_y2 = constrain(
    extMouseY2, paddle_height, height-paddle_height
  );

  // Checar si la bola toca el panel DERECHO
  float py2 = width-dist_wall-paddle_width-ball_size;

  if(ball_x >= py2 
     && ball_y > paddle_y2 - paddle_height - ball_size 
     && ball_y < paddle_y2 + paddle_height + ball_size) {
      ball_dir *= -1;

      if(extMouseY2 != PextMouseY2) {
        dy = (extMouseY2-PextMouseY2)/2.0;
      }
  } 
  
  // Si esta tocando el piso (menos su ancho)
  // Cambia la direccion en y
  if(ball_y > height-ball_size) {
    dy = dy * -1;
  }
  // Si esta tocando el techo (menos su ancho)
  // Cambia la direccion en y
  if(ball_y < ball_size) {
    dy = dy * -1;
  }

  // Dibujar bola
  fill(255);
  ellipse(ball_x, ball_y, ball_size, ball_size);
  
  // Dibujar panel izquierdo
  fill(153);
  rect(dist_wall, paddle_y1, paddle_width, paddle_height); 

  // Dibujar panel derecho
  fill(153);
  rect(width-dist_wall, paddle_y2, paddle_width, paddle_height);   

  ///////////////////////////////////////////////////////
  text("Remote Accelerometer Info: " + "\n" +
  "Celular 1 y: "+ nfp(extMouseY1, 1, 3) + "\n" +
  "Celular 2 y: "+ nfp(extMouseY2, 1, 3) + "\n" +
  "Local Info: \n" +
  "mousePressed: " + mousePressed, width/2, height/2);

  //Envia un mensaje a los celulares
  // SOLO ENVIA AL 1 U.U
  OscMessage myMessage = new OscMessage("mouseStatus");
  myMessage.add(mouseX); // 2
  myMessage.add(mouseY); // 3
  myMessage.add(int(mousePressed)); // 4
  msgCelular1.send(myMessage, remoteLocationCelular1); 
  OscMessage myMessage2 = new OscMessage("mouseStatus");
  myMessage2.add(mouseX); // 2
  myMessage2.add(mouseY); // 3
  myMessage2.add(int(mousePressed)); // 4
  msgCelular2.send(myMessage2, remoteLocationCelular2); 
}

//Recibimos msg de los mensajes 
void oscEvent(OscMessage theOscMessage) {
  // Checamos si los datos traen 3 decimales para saber
  //Si es el segundo Celular
  //if (theOscMessage.checkTypetag("fff")) {
    int opc = theOscMessage.get(0).intValue() ;
    if( opc == 1 ){
      PextMouseY1 = extMouseY1;
      extMouseY1 = ( 
        map( theOscMessage.get(1).floatValue(), -10 , 10 , 0, altoP) 
      );
    } else if(opc == 2 ){
      PextMouseY2 = extMouseY2;
      extMouseY2 = ( 
        map( theOscMessage.get(1).floatValue(), -10 , 10 , 0, altoP) 
      );
    }
    //println( "l "+ opc );
  //};
}


