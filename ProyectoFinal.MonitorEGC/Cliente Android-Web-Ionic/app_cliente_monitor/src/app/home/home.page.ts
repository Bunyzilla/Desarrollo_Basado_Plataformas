import { Component ,ViewChild } from '@angular/core';
import { Chart } from 'chart.js';
//Controles para la alerta
import { AlertController} from '@ionic/angular';


//Se importa una variable para poder usarla como la conexion
//al firebase 
import * as firebase from 'Firebase';


@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {
  //Variables para la grafica
  lineChart: any;
  showGrafica: boolean = false;
  //firebase
  ref = firebase.database().ref('/data');

  valorSensorRef = firebase.database().ref('/data/valorSensor');
  nombreRef = firebase.database().ref('/data/nombre');
  edadRef = firebase.database().ref('/data/edad');
  estadoTransmisionRef = firebase.database().ref('/data/estadoTransmision');
  estadoAlarmaRef = firebase.database().ref('/data/estadoAlarma');
  
  
  color = "lightgreen";
  //Variable con la que actualizamos la interfaz
  //lo importante es ejecutar las funciones en orden
  dataSend = {
    nombre : "",
    edad : 0,
    estadoTransmision : "false",
    estadoAlarma : "false",
    valorSensor : {
      tiempo : "0",
      valor : 0
    },
  };

  @ViewChild('lineCanvas') lineCanvas;

  //Se crean los bidings y sus respectivas acciones
  constructor(private alertCtrl: AlertController) {
    this.nombreRef.on('value', resp => {
      this.dataSend.nombre = snapshotToObject(resp);
    });
    this.edadRef.on('value', resp => {
      this.dataSend.edad = snapshotToObject(resp);
    });
    this.estadoTransmisionRef.on('value', resp => {
      this.dataSend.estadoTransmision = snapshotToObject(resp);
    });
    this.estadoAlarmaRef.on('value', resp => {
      this.dataSend.estadoAlarma = snapshotToObject(resp);
      if(this.dataSend.estadoAlarma == "true"){
        this.showAlarma("El paciente "+this.dataSend.nombre+" requiere atencion!");
      }
      console.log(this.dataSend);
      
    });
    this.valorSensorRef.on('value', resp => {
      this.dataSend.valorSensor = snapshotToObject(resp);
      this.addData(this.dataSend.valorSensor.tiempo, this.dataSend.valorSensor.valor);
    });
  }

  ngOnInit(){
    this.ionViewDidLoad();
  }

  async showAlarma(msg) {
    let alert = await this.alertCtrl.create({
      header: 'Alerta!',
      subHeader: msg,
      buttons: ['ACEPTAR']
    });
    alert.present();
  }
  /////////////////////////////////FIREBASE/////////////////////
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
}

export const snapshotToObject = snapshot => {
  let item = snapshot.val();
  return item;
}
