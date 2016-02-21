
/**
 * Created by volkswagen1 on 17.02.2016.
 */
function p_delete(e){
    var model=document.getElementById("id_model");
    while (model.firstChild) {
        model.removeChild(model.firstChild);
    }


    $.get( "/getModelByBrand", { model: e})
        .done(function( data ) {

//                alert(data.length);
//                alert( "Data Loaded: " + data[1] );
            for(var i=0;i<data.length;i++){
                var model=document.getElementById("id_model");

                var manager=document.createElement("OPTION");
                manager.setAttribute("value",data[i]);
////
                manager.innerHTML=data[i];
                model.appendChild(manager);
//                  alert("привет");
//
            }
        });
//     // 1. Создаём новый объект XMLHttpRequest
//     var xhr = new XMLHttpRequest();
//
//// 2. Конфигурируем его: GET-запрос на URL 'phones.json'
//     xhr.open('GET', 'http://localhost:8080/hello', true);
//
//// 3. Отсылаем запрос
//     xhr.send();
//
//// 4. Если код ответа сервера не 200, то это ошибка
//     if (xhr.status != 200) {
//         // обработать ошибку
//         alert( xhr.status + ': ' + xhr.statusText ); // пример вывода: 404: Not Found
//     } else {
//         // вывести результат
//         alert( xhr.responseText ); // responseText -- текст ответа.
//     }
}