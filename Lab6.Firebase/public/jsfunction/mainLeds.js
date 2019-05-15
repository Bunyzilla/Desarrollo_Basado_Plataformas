//creamos una referencia a la base de datos para enviar el valor de la pagina en que nos encontramos
/*
var db = firebase.database().ref('home/pagina').set({
    pagina: 1
});
*/
//creamos una referencia a la base de datos y el hijo donde se almacena el valor 

//db = firebase.database().ref('home/onoff');
db = firebase.database().ref('//');

//con el metodo on se obtiene el valor almacenado en el hijo o nodo

db.on('value',function(data){
    console.log("data: ", data.val());
    //referencia al elemento por medio del identificador, propiedad jquerty que agrega el valor a la propiedad checked 
    //$("#led1").prop('checked', data.val().Led1);
    $("#led1").prop('checked', data.val().pin0);
    $("#led2").prop('checked', data.val().pin10);
});

// cuando demos clic en el switch la variable estado almacenara el valor que esta contenga y
//el metodo update enviara este valor a la base de datos

$("#led1").click(function(){
    var estado = $(this).is(':checked');
    db.update({
        //Led1:estado,
        pin10:estado,
    });
});

$("#led2").click(function(){
    var estado = $(this).is(':checked');
    db.update({
        Led1:estado,
    });
});



