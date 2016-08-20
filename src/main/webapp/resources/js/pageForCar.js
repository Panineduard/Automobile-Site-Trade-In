function showProgressLoad(percent,index){
    $('#percent'+index).html(percent+'%');
    var degrees=percent*3.6;
    var per=$('#pinkcircle'+index);
    per.css("display", "block");
    if(percent<=50){
        $('#percent_rotation'+index).css({
            '-webkit-transform' : 'rotate('+degrees+'deg) ',
            '-moz-transform'    : 'rotate('+degrees+'deg) ',
            '-ms-transform'     : 'rotate('+degrees+'deg) ',
            '-o-transform'      : 'rotate('+degrees+'deg) ',
            'transform'         : 'rotate('+degrees+'deg) '
        });
        $('#pinkcircle'+index).removeClass('gt50');
    }
    if(percent>50){

//            setTimeout(function(){
        per.addClass('gt50');
//            },450);

        $('#percent_rotation'+index).css({
            '-webkit-transform' : 'rotate('+degrees+'deg) ',
            '-moz-transform'    : 'rotate('+degrees+'deg) ',
            '-ms-transform'     : 'rotate('+degrees+'deg) ',
            '-o-transform'      : 'rotate('+degrees+'deg) ',
            'transform'         : 'rotate('+degrees+'deg) '
        });
    }
    if(percent==100){
        setTimeout(function(){per.css("display", "none");},500);
    }

}
//Читаем ввод изображения
function readURL(input,index) {
    index=index+1;
    if(!/(\.jpg|\.jpeg)$/i.test(input.value))
    {
        alert('Не допустимый формат изображения');
        $('input#image_p'+index).value='';return false;
    }
    else {
        if (input.files && input.files[0]) {

//                    $("#image_p"+index).remove();
//                    $('#file'+index).append('<input accept="image/jpeg" id="image_p'+index+'" name="files['+index+']"  onchange="readURL(this,'+index+');" type="file" />');
            var reader = new FileReader();
            reader.onload = function (e) {
                $('img#car_photo'+index)
                    .attr("src",e.target.result)
                    .attr("onclick","");
            };
            var container= $('div#class_with_photo'+index);
            container.attr("data-parameter",index);
            container.append("<div  id='"+index+"'  class='photoCarDel' >  </div>");
            //var file=$('#image_p'+index);
            var file=input.files[0];
            var form_data = new FormData();                  // Creating object of FormData class
            form_data.append("file", file);// Appending parameter named file with properties of file_field to form_data
            form_data.append("position",(index-1));
            form_data.append("type", file.name);
            var progressBar = $('#pinkcircle'+index);
            $.ajax({
                url: "/putPhoto",
                dataType: 'json',
                //enctype: 'multipart/form-data',
                cache: false,
                contentType: false,
                processData: false,

                xhr: function(){
                    var xhr = $.ajaxSettings.xhr(); // получаем объект XMLHttpRequest
                    xhr.upload.addEventListener('progress', function(evt){ // добавляем обработчик события progress (onprogress)
                        if(evt.lengthComputable) { // если известно количество байт
                            // высчитываем процент загруженного
                            var percentComplete = Math.ceil(evt.loaded / evt.total * 100);
                            showProgressLoad(percentComplete,index);
                            // устанавливаем значение в атрибут value тега <progress>
                            // и это же значение альтернативным текстом для браузеров, не поддерживающих <progress>
                            //progressBar.attr("data-percent", percentComplete);
                            formCantBeSend=false;
                        }
                    }, false);
                    return xhr;
                },
                data: form_data,                         // Setting the data attribute of ajax with file_data
                type: 'post',
                success:function(jsondata){
                    var place=$('#file'+index);
                    //alert(jsondata);
                    place.empty();
                    place.append('<input id="idPh'+index+'" name="photo'+index+'" type="hidden" value="'+jsondata+'">');
                    formCantBeSend=true;
                }
            })

            return reader.readAsDataURL(input.files[0]);

        }

    }
};
function add_file(id){
    $('input#image_p'+id).click();

} ;