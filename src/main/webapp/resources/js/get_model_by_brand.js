
/**
 * Created by volkswagen1 on 17.02.2016.
 */
function p_delete(e,model){
    var models=document.getElementById("id_model");
    while (models.firstChild) {
        models.removeChild(models.firstChild);
    }


    $.get( "/getModelByBrand", { model: e})
        .done(function( data ) {

//                alert(data.length);
//                alert( "Data Loaded: " + data[1] );
            for(var i=0;i<data.length;i++){
                //var model=document.getElementById("id_model");
                if(i==0){
                    //manager.setAttribute("value",'');
                    $('#id_model').append('<option  value="">'+data[i]+' </option>');
                }

                //var manager=document.createElement("OPTION");

                    else{
                    if(model==data[i]){
                    $('#id_model').append('<option selected="selected" value="'+data[i]+'">'+data[i]+' </option>');
                    }
                    else{
                        $('#id_model').append('<option value="'+data[i]+'">'+data[i]+' </option>');
                    }
                    //manager.setAttribute("value",data[i]);
                }
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