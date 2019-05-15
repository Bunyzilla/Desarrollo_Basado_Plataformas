valorluz = 300;
valortemp = 25;

//creamos una referencia a la base de datos para enviar el valor de la pagina en que nos encontramos
//dbluz = firebase.database().ref("home/sensores").child("sensorLuz");
dbluz = firebase.database().ref("home").child("sensorLuz");
dbTemp = firebase.database().ref("home").child("sensorTemp");

// llamamos los valores cadavez que un cambio  existe en la base de datos

dbluz.on('value', function(snap){
  luz.innerText = snap.val() // enviar los valores a html
  valorluz = snap.val(); // usar los valores en la funcion
  console.log(luz)
  cambiarImagen(valorluz, valortemp);
});

dbTemp.on('value', function(snap){
  temp.innerText = snap.val()
  valortemp = snap.val();
  console.log(temp)
  cambiarImagen(valorluz, valortemp);
});

function cambiarImagen(valorluz, valortemp){ 
    if(valorluz<=7){
        console.log("Es de dia");
        if(valortemp<17){  
            console.log("dia frio");
            $("#imgDiaFrio").siblings().fadeOut(3000);
            $("#imgDiaFrio").fadeIn(3000);
            $("#dia").text("Dia Frio");
        }
        else if(valortemp>17 && valortemp<=23){
            console.log("dia fresco");
            $("#imgDiaFresco").siblings().fadeOut(3000);
            $("#imgDiaFresco").fadeIn(3000)
            $("#dia").text("Dia Fresco");
        }
        else if(valortemp>24 && valortemp<=26){
            console.log("dia Calido");
            $("#imgDiaCalido").siblings().fadeOut(3000);
            $("#imgDiaCalido").fadeIn(3000);
            $("#dia").text("Dia Calido");
        }
        else if(valortemp>26){
            console.log("dia Caluroso");
            $("#imgDiaCaluroso").siblings().fadeOut(3000);
            $("#imgDiaCaluroso").fadeIn(3000);
            $("#dia").text("Dia Caluroso");
        }
    }
    else {
        console.log("Es de noche");
        $("#imgNoche").siblings().fadeOut(3000);
        $("#imgNoche").fadeIn(3000);          
        $("#dia").text("Noche");
    }
}
