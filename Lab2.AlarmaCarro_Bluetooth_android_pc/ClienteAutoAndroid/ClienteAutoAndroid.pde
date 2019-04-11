

void setup() {
    orientation(PORTRAIT);
    textAlign(CENTER, CENTER);
    textSize(50);
    //setUp Gps
    setupGPS();
    //setUp Acelerometro
    setupSensors();
}

void draw() {
    background(78, 93, 75);

    //imprimirInfoSensores();

    imprimirEstadoAlarmas();
}