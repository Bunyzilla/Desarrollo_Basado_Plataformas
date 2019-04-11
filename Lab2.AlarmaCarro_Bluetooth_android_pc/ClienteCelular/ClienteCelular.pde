
void setup(){ 
  fullScreen();
  orientation(PORTRAIT);
  background(78, 93, 75);
  stroke(255);
  textSize(16*displayDensity);
  
  event[0] = "1";
  event[1] = "0";
  event[2] = "0";
  event[3] = "0";
  event[4] = "0";
  // Inicia la conexion con el servidor
  initNetworkConnection();
  //start listening for BT connections
  bt.start();
}

void draw()
{
  if (isConfiguring)
  {
    pantallaPrincipal();
    //Enviar info al servidor 911
    enviarInfoServidor();
  } else
  { 
    //Dibuja el circulo echo y recibido por el bluetooth
    pantallaPatronCompartido();
  }
  //Dibuja los botones y borra los datos de la pantalla
  drawUI();
}