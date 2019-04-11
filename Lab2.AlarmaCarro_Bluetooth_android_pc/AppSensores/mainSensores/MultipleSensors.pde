import ketai.sensors.*;
KetaiSensor sensor;
PVector accelerometer;
float light, proximityf;
boolean proximity;

String datosSensores;

void setupSensors() {
  sensor = new KetaiSensor(this);
  sensor.start();
  sensor.list();
  accelerometer = new PVector();
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

public void mousePressed() {
  if (sensor.isStarted())
    sensor.stop();
  else
    sensor.start();
  println("KetaiSensor isStarted: " + sensor.isStarted());
}
