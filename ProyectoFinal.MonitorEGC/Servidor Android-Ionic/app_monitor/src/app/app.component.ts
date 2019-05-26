import { Component } from '@angular/core';

import { Platform } from '@ionic/angular';
import { SplashScreen } from '@ionic-native/splash-screen/ngx';
import { StatusBar } from '@ionic-native/status-bar/ngx';

import * as firebase from 'firebase';

const config = {
  apiKey: "AIzaSyAm8Ru8jWTmY1H5BKfAig06ciwqzEhrExQ",
    authDomain: "proyectofinal-61a37.firebaseapp.com",
    databaseURL: "https://proyectofinal-61a37.firebaseio.com",
    projectId: "proyectofinal-61a37",
    storageBucket: "proyectofinal-61a37.appspot.com",
    messagingSenderId: "481531593186",
    appId: "1:481531593186:web:38fa0992936331b5"
};

@Component({
  selector: 'app-root',
  templateUrl: 'app.component.html'
})
export class AppComponent {
  constructor(
    private platform: Platform,
    private splashScreen: SplashScreen,
    private statusBar: StatusBar
  ) {
    this.initializeApp();
  }

  initializeApp() {
    this.platform.ready().then(() => {
      this.statusBar.styleDefault();
      this.splashScreen.hide();
    });
    firebase.initializeApp(config);
  }
}
