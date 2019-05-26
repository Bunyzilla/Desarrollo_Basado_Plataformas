#include "eHealth.h"

// The setup routine runs once when you press reset:
void setup() {
  Serial.begin(9600);  
  Serial1.begin(9600);  
}
int tiempo = 0;
// The loop routine runs over and over again forever:
void loop() {

  float ECG = eHealth.getECG();
  if(ECG>2.3){
    ECG = map(ECG, 2.3, 4, 3, 10);
  }else{
    ECG = map(ECG, 0, 2.3, 2, 3);
  }
  tiempo+=1;
  Serial.print(ECG, 2);
  Serial.print(","); 
  Serial.print(tiempo);
  Serial.println(","); 
   
  Serial1.print(ECG, 2);
  Serial1.print(","); 
  Serial1.print(tiempo); 
  Serial1.println(","); 
  
  delay(50);
}
