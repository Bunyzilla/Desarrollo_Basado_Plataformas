import ketai.sensors.*;
KetaiLocation location; // 1
double longitude, latitude, altitude;
float accuracy;

String datosGps;

void setupGPS() {
  location = new KetaiLocation(this); 
}

void actDatosGps(){
    if (location.getProvider() == "none") // 3
        datosGps = "Location data is unavailable. \n" +
        "Please check your location settings.";
    else
        datosGps = "Latitude: \n" + latitude + "\n" + // 4
        "Longitude: \n" + longitude + "\n" +
        "Altitude: " + altitude + "\n" +
        "Accuracy: " + accuracy + "\n" +
        "Provider: " + location.getProvider();
}

void onLocationEvent(double _latitude, double _longitude, 
  double _altitude, float _accuracy) { // 5
  longitude = _longitude;
  latitude = _latitude;
  altitude = _altitude;
  accuracy = _accuracy;
  //println("lat/lon/alt/acc: " + latitude + "/" + longitude + "/"+ altitude + "/" + accuracy);
}
