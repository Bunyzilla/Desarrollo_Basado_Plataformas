import { Component,ViewChild } from '@angular/core';
import { Chart } from 'chart.js';
import { BluetoothSerial } from '@ionic-native/bluetooth-serial/ngx';
import { AlertController, ToastController } from '@ionic/angular';

import * as firebase from 'Firebase';


@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {
  pairedList: pairedlist;
  listToggle: boolean = false;
  disconectToggle: boolean = false;
  pairedDeviceID: number = 0;
  
  dataSend = {
    nombre : "",
    edad : 0,
    estadoTransmision : "false",
    estadoAlarma : false,
    valorSensor : {
      tiempo : "0",
      valor : 0
    },
  };
  //Variable para cambiar el color a la interfaz
  color = "red";
  
  @ViewChild('lineCanvas') lineCanvas;

  
  lineChart: any;
  showGrafica: boolean = false;
  //firebase
  ref = firebase.database().ref('/data');

  constructor(public bluetoothSerial: BluetoothSerial,private alertCtrl: AlertController, private toastCtrl: ToastController) {
    this.checkBluetoothEnabled();
  }

  ngOnInit(){
    this.ionViewDidLoad();
  }
  //Enviar la actualizacion de los datos del sensor al firebase
  sendInfoSensor() {
    this.ref.update({
        valorSensor : {
          tiempo : this.dataSend.valorSensor.tiempo,
          valor : this.dataSend.valorSensor.valor
        }
    } );
  }

  actualizarAlarma(){
    this.ref.update({
        estadoAlarma : this.dataSend.estadoAlarma
    });
  }
  actualizarTransmision(){
    this.ref.update({
      nombre : this.dataSend.nombre,
      edad : this.dataSend.edad, 
      estadoTransmision : this.dataSend.estadoTransmision
    });
  }
  /////////////////////////////////////FUNFIONES PARA LA GRAFICA///////////////////////////////////////
  handleData(data) {
    var arrayNuevo = data.split(",");
    console.log(arrayNuevo);
    if(this.dataSend.estadoTransmision=="true"){
      this.dataSend.valorSensor.tiempo = arrayNuevo[1];
      this.dataSend.valorSensor.valor = parseFloat( arrayNuevo[0])
      this.sendInfoSensor();
    }
    this.addData(arrayNuevo[1], parseFloat( arrayNuevo[0]));
  }
  
  ionViewDidLoad() {
  this.lineChart = new Chart(this.lineCanvas.nativeElement, {
    type: 'line',
    data: {
        labels: [],
        datasets: [
            {
                label: "ECG en V",
                fill: false,
                lineTension: 0.1,
                backgroundColor: "rgba(75,192,192,0.4)",
                borderColor: "rgba(75,192,192,1)",
                borderCapStyle: 'butt',
                borderDash: [],
                borderDashOffset: 0.0,
                borderJoinStyle: 'miter',
                pointBorderColor: "rgba(75,192,192,1)",
                pointBackgroundColor: "#fff",
                pointBorderWidth: 1,
                pointHoverRadius: 5,
                pointHoverBackgroundColor: "rgba(75,192,192,1)",
                pointHoverBorderColor: "rgba(220,220,220,1)",
                pointHoverBorderWidth: 2,
                pointRadius: 1,
                pointHitRadius: 10,
                data: [],
                spanGaps: false,
            }
        ]
    }

  });
 }

 count = 0;
  addData(label, data) {
    this.lineChart.data.labels.push(label);
    var control = 0;
    if(this.count>100){
      this.lineChart.data.labels.shift();   
    }

    this.lineChart.data.datasets.forEach((dataset) => {
      if(this.count>100){
        if(control == 1){
          dataset.data.push(data);
        }else{
          dataset.data.push(data);
          dataset.data.shift();
          control=1 ;
        }
      }else{
        dataset.data.push(data);
        this.count++;
      }
      
    });
    
    this.lineChart.update();
  }

  removeData() {
    this.lineChart.data.labels.pop();
    this.lineChart.data.datasets.forEach((dataset) => {
      dataset.data.pop();
    });
    this.lineChart.update();
  }

  /////////////////////////////////////FUNFIONES PARA BLUETHOOT///////////////////////////////////////
  checkBluetoothEnabled() {
    this.bluetoothSerial.isEnabled().then(success => {
      this.listPairedDevices();
    }, error => {
      this.showError("Please Enable Bluetooth")
    });
  }

  listPairedDevices() {
    this.bluetoothSerial.list().then(success => {
      this.pairedList = success;
      this.listToggle = true;
      this.disconectToggle = false;
    }, error => {
      this.showError("Please Enable Bluetooth")
      this.listToggle = false;
      this.disconectToggle = false;
    });
  }

  selectDevice() {
    let connectedDevice = this.pairedList[this.pairedDeviceID];
    if (!connectedDevice.address) {
      this.showError('Select Paired Device to connect');
    }else{
      let address = connectedDevice.address;
      let name = connectedDevice.name;
      this.connect(address,name);
    }
  }

  connect(address,name) {
    this.showToast("Intentando: "+name);
    // Attempt to connect device with specified address, call app.deviceConnected if success
    //this.bluetoothSerial.connect("20:15:10:09:74:44").subscribe(success => {
    this.bluetoothSerial.connect(address).subscribe(success => {
      this.showToast("Successfully Connected");
      this.listToggle = false;
      this.disconectToggle = true;
      this.deviceConnected();
    }, error => {
      this.showError("Error conectando con "+name);
    });
  }

  deviceConnected() {
    // Subscribe to data receiving as soon as the delimiter is read
    this.bluetoothSerial.subscribe('\n').subscribe(success => {
      this.handleData(success);
    }, error => {
      this.showError(error);
    });
  }

  deviceDisconnected() {
    // Unsubscribe from data receiving
    this.bluetoothSerial.disconnect();
    this.showToast("Device Disconnected");
    this.disconectToggle = false;
    this.listToggle = true;
  }

  async showError(error) {
    
    let alert = await this.alertCtrl.create({
      header: 'Error',
      subHeader: error,
      buttons: ['Dismiss']
    });
    alert.present();
  }

  
  async showToast(msj) {
    const toast = await this.toastCtrl.create({
      message: msj,
      duration: 1000
    });
    toast.present();
  }
}

interface pairedlist {
  "class": number,
  "id": string,
  "address": string,
  "name": string
}