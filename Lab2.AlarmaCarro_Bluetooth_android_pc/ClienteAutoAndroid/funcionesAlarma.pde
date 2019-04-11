

boolean alarma[] = {false, false, false, false, false};

//Datos para la alarma A
int muestrasAcel[][] = { {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0} };
boolean inicioMuestras = false;
int pivoteMuestra = 0;
int variableTiempoAlarma1 = 0;

//Datos para la alarma B
double muestrasGps[][] = { { 0.0, 0.0 }, { 0.0, 0.0 } };
boolean inicioMuestrasGps = false;
int pivoteMuestraGps = 0;
int variableTiempoAlarmaGps = 0; 

//Datos para la alarma C
boolean muestrasPoxi[] = { false, false } ;
boolean inicioMuestrasPoxi = false;
int pivoteMuestraPoxi = 0;
int variableTiempoAlarmaPoxi = 0; 

void imprimirEstadoAlarmas() {
  actDatosGps();
  actDatosSensores();

  checarAlarmaA();
  checarAlarmaB();
  checarAlarmaC();
  text("Estado de las alarmas\n" + 
    "Alarma a: " + alarma[0] + "\n" +
    "Alarma b: " + alarma[1] + "\n" +
    "Alarma c: " + alarma[2] + "\n" +
    "Alarma d: " + alarma[3] + "\n" +
    "Alarma e: " + alarma[4] + "\n" +
  /*"Muestras acelerometro\n"+
   "0: " + muestrasAcel[0][0] + "\n" +
   "1: " + muestrasAcel[0][1] + "\n" +
   "2: " + muestrasAcel[0][2] + "\n" +
   "3: " + muestrasAcel[0][3] */
  /*"Muestras GPS\n" +
   "Longitud: \n" 
   + muestrasGps[0][0] + "\n" +
   + muestrasGps[0][1] + "\n" +
   "Latitud: \n" +
   + muestrasGps[1][0] + "\n" +
   + muestrasGps[1][1] + "\n" */
    "Muestras Proximidad\n" +
    muestrasPoxi[0] + "\n" +
    muestrasPoxi[1] + "\n"
    , width/2, height/2);

  text("CLIC LARGO PARA\nPARAR ALARMA", width/2, height-50);
}

//Apagar alarma
void onLongPress(float x, float y) {
  alarma[0] = false;
  alarma[1] = false;
  alarma[2] = false;
  alarma[3] = false;
  alarma[4] = false;
}

//a) Actividad en el sensor de aceleración nos indica que el auto puede haber sido alcanzado por otro carro estando estacionado, 
//   o que podrían estarse robando las copas del auto
void checarAlarmaA() {
  if (inicioMuestras == false) {
    for (int x = 0; x<4; x++) {
      muestrasAcel[0][x] = int(nfp(accelerometer.x, 1, 0));
      muestrasAcel[1][x] = int(nfp(accelerometer.y, 1, 0));
      muestrasAcel[2][x] = int(nfp(accelerometer.z, 1, 0));
    }
    inicioMuestras = true;
  }

  if (variableTiempoAlarma1 == 20) {
    muestrasAcel[0][pivoteMuestra] = int(nfp(accelerometer.x, 1, 0));
    muestrasAcel[1][pivoteMuestra] = int(nfp(accelerometer.y, 1, 0));
    muestrasAcel[2][pivoteMuestra] = int(nfp(accelerometer.z, 1, 0));

    if (pivoteMuestra == 3) {
      for (int y = 1; y<4; y++) {
        if ( muestrasAcel[0][y-1] != muestrasAcel[0][y] || 
          muestrasAcel[1][y-1] != muestrasAcel[1][y] || 
          muestrasAcel[2][y-1] != muestrasAcel[2][y] ) {
          alarma[0] = true;
        }
      }
      pivoteMuestra = 0;
    } else {
      pivoteMuestra++;
    }

    variableTiempoAlarma1 = 0;
  } else {
    variableTiempoAlarma1++;
  }
}

//b) Actividad en el sensor de aceleración y en el GPS indica que se están robando el auto

void checarAlarmaB() {
  if (inicioMuestrasGps == false) {
    for (int x = 0; x<2; x++) {
      muestrasGps[0][x] = float(nfp((float)longitude, 4, 5));
      muestrasGps[1][x] = float(nfp((float)latitude, 4, 5));
    }
    inicioMuestrasGps = true;
  }

  if (variableTiempoAlarmaGps == 50) {
    muestrasGps[0][pivoteMuestraGps] = float(nfp((float)longitude, 4, 5));
    muestrasGps[1][pivoteMuestraGps] = float(nfp((float)latitude, 4, 5));

    if (pivoteMuestraGps == 1) {
      if ( muestrasAcel[0][0] != muestrasAcel[0][1] || 
        muestrasAcel[1][0] != muestrasAcel[1][1] &&
        alarma[0] ) {
        alarma[1] = true;
      }
      pivoteMuestraGps = 0;
    } else {
      pivoteMuestraGps++;
    }

    variableTiempoAlarmaGps = 0;
  } else {
    variableTiempoAlarmaGps++;
  }
}

//c) Actividad en el sensor de proximidad indica que alguien está asomandose por las ventanas del auto

void checarAlarmaC() {
  if (inicioMuestrasPoxi == false) {
    for (int x = 0; x<2; x++) {
      muestrasPoxi[x] = proximity;
    }
    inicioMuestrasPoxi = true;
  }

  if (variableTiempoAlarmaPoxi == 25) {
    muestrasPoxi[pivoteMuestraPoxi] = proximity;

    if (pivoteMuestraPoxi == 1) {
      if ( muestrasPoxi[0] != muestrasPoxi[1] ) {
        alarma[2] = true;
      }
      pivoteMuestraPoxi = 0;
    } else {
      pivoteMuestraPoxi++;
    }

    variableTiempoAlarmaPoxi = 0;
  } else {
    variableTiempoAlarmaPoxi++;
  }
}
//d) Actividad en el sensor touch indica que alguien esta intentando abrir/romper los cristales del auto

void onDoubleTap(float x, float y) {
  text("DOUBLE", x, y-10);
  println("DOUBLE:" + x + "," + y);
  alarma[3] = true;
  /*if (rectSize > 100)
    rectSize = 100;
  else
    rectSize = height - 100;*/
}

//e) Actividad en el sensor touch y en el sensor de luz indica que alguien entro al auto
