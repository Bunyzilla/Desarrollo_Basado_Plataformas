//#include "DHT.h"
//#define DHTPIN 7
//#define DHTTYPE DHT11
//DHT dht(DHTPIN, DHTTYPE);
 
int led = 13; //led Rojo de prueba de conexión

int valueBt = 0;
char inbyte = 0; //Char para leer el led
 
void setup() {
  // initialise serial communications at 9600 bps:
  Serial2.begin(9600);
  Serial.begin(9600);
  //pinMode(led, OUTPUT);
  //digitalWrite(led, LOW);
  //dht.begin();
}
 
void loop() {
  //when serial values have been received this will be true
  
  if (Serial2.available() > 0)
  {
    inbyte = Serial2.read();
    Serial2.println(inbyte);
    switch (inbyte)
    {
    case 'w':
      Serial2.print("#entro al W");
      setValueBt(9);
      break;
    case 's':
      Serial2.print("#entro al S");
      setValueBt(21);
      break;
    case 'a':
      Serial2.print("#entro al A");
      setValueBt(42);
      break;
    case 'd':
      Serial2.print("#entro al D");
      setValueBt(112);
      break;
    case 'l':
      Serial2.print("#entro al L");
      setValueBt(152);
      break;
    case 'k':
      Serial2.print("#entro al K");
      setValueBt(185);
      break;
    case 'q':
      Serial2.print("#entro al Q");
      setValueBt(200);
      break;
    case 'e':
      Serial2.print("#entro al E");
      setValueBt(215);
      break;
    case 'z':
      Serial2.print("#entro al Z");
      setValueBt(243);
      break;
    case 'c':
      Serial2.print("#entro al C");
      setValueBt(251);
      break;
    case 't':
      Serial2.print("#entro al T");
      setValueBt(0);
      break;
    
    default:
      break;
    }
  }else{
    Serial2.print("#No llego nada   ");
  }
  
  sendAndroidValues();
  delay(2000); 
}
 
void setValueBt(int color){
  valueBt = color;
}

//enviar los valores por el dipositivo android por el modulo Bluetooth
void sendAndroidValues(){
  Serial2.print("<valor>"); //hay que poner # para el comienzo de los datos, así Android sabe que empieza el String de datos
  Serial2.print(valueBt);
  Serial2.print("</valor>"); //separamos los datos con el +, así no es más fácil debuggear la información que enviamos
  Serial2.println();
  delay(10);        //agregamos este delay para eliminar tramisiones faltantes
}
