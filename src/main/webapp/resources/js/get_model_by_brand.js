
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
//                  alert("������");
//
            }
        });
//     // 1. ������ ����� ������ XMLHttpRequest
//     var xhr = new XMLHttpRequest();
//
//// 2. ������������� ���: GET-������ �� URL 'phones.json'
//     xhr.open('GET', 'http://localhost:8080/hello', true);
//
//// 3. �������� ������
//     xhr.send();
//
//// 4. ���� ��� ������ ������� �� 200, �� ��� ������
//     if (xhr.status != 200) {
//         // ���������� ������
//         alert( xhr.status + ': ' + xhr.statusText ); // ������ ������: 404: Not Found
//     } else {
//         // ������� ���������
//         alert( xhr.responseText ); // responseText -- ����� ������.
//     }
}