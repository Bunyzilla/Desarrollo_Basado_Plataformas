import ketai.sensors.*;

KetaiSensor sensor;
PVector accelerometer;
float light, proximityf;
boolean proximity;

String datosSensores;

import ketai.ui.*; 
import android.view.MotionEvent; 

//Se usa para crear los eventos del touch
KetaiGesture gesture; 

void setupSensors() {
  sensor = new KetaiSensor(this);
  sensor.start();
  sensor.list();
  accelerometer = new PVector();
  //Variable para los eventos del touch que los manejamos como funciones de la alarma
  gesture = new KetaiGesture(this);
}

void actDatosSensores(){
  datosSensores = "Accelerometer :" + "\n"
    + "x: " + nfp(accelerometer.x, 1, 2) + "\n"
    + "y: " + nfp(accelerometer.y, 1, 2) + "\n"
    + "z: " + nfp(accelerometer.z, 1, 2) + "\n"
    + "Light Sensor : " + light + "\n"
    + "Proximity Sensor : " + proximity + "\n";
}

void onAccelerometerEvent(float x, float y, float z, long time, int accuracy){
  accelerometer.set(x, y, z);
}

void onLightEvent(float v){
  light = v;
}


void onProximityEvent(float b){
  proximityf = b;
  if(proximityf==0){
      proximity = true;
  }else{
      proximity = false;
  }
}

