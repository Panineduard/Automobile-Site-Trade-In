function showProgressLoad(percent, index) {
    $('#percent' + index).html(percent + '%');
    var degrees = percent * 3.6;
    var per = $('#pinkcircle' + index);
    per.css("display", "block");
    if (percent <= 50) {
        $('#percent_rotation' + index).css({
            '-webkit-transform': 'rotate(' + degrees + 'deg) ',
            '-moz-transform': 'rotate(' + degrees + 'deg) ',
            '-ms-transform': 'rotate(' + degrees + 'deg) ',
            '-o-transform': 'rotate(' + degrees + 'deg) ',
            'transform': 'rotate(' + degrees + 'deg) '
        });
        $('#pinkcircle' + index).removeClass('gt50');
    }
    if (percent > 50) {

//            setTimeout(function(){
        per.addClass('gt50');
//            },450);

        $('#percent_rotation' + index).css({
            '-webkit-transform': 'rotate(' + degrees + 'deg) ',
            '-moz-transform': 'rotate(' + degrees + 'deg) ',
            '-ms-transform': 'rotate(' + degrees + 'deg) ',
            '-o-transform': 'rotate(' + degrees + 'deg) ',
            'transform': 'rotate(' + degrees + 'deg) '
        });
    }
    if (percent == 100) {
        setTimeout(function () {
            per.css("display", "none");
        }, 500);
    }

}
//Читаем ввод изображения
function readURL(input, index) {
    index = index + 1;
    if (!/(\.jpg|\.jpeg)$/i.test(input.value)) {
        alert('Не допустимый формат изображения');
        $('input#image_p' + index).value = '';
        return false;
    }
    else {
        if (input.files && input.files[0]) {

//                    $("#image_p"+index).remove();
//                    $('#file'+index).append('<input accept="image/jpeg" id="image_p'+index+'" name="files['+index+']"  onchange="readURL(this,'+index+');" type="file" />');
            var reader = new FileReader();
            reader.onload = function (e) {
                var image = $('img#car_photo' + index);
                image
                    .attr("src", e.target.result)
                    .attr("onclick", "");
                var img = new Image;
                img.onload = function () {
                    if (img.width < img.height) {
                        image.attr("style", "left: 25%;position: relative;")
                    }

                };
                img.src = reader.result;
            };
            var container = $('div#class_with_photo' + index);
            container.attr("data-parameter", index);
            container.append("<div  id='" + index + "'  class='photoCarDel' >  </div>");
            //var file=$('#image_p'+index);
            var file = input.files[0];
            var form_data = new FormData();                  // Creating object of FormData class
            form_data.append("file", file);// Appending parameter named file with properties of file_field to form_data
            form_data.append("position", (index - 1));
            form_data.append("type", file.name);
            var progressBar = $('#pinkcircle' + index);
            formCantBeSend[index - 1] = false;
            $.ajax({
                url: "/putPhoto",
                dataType: 'json',
                //enctype: 'multipart/form-data',
                cache: false,
                contentType: false,
                processData: false,

                xhr: function () {
                    var xhr = $.ajaxSettings.xhr(); // получаем объект XMLHttpRequest
                    xhr.upload.addEventListener('progress', function (evt) { // добавляем обработчик события progress (onprogress)
                        if (evt.lengthComputable) { // если известно количество байт
                            // высчитываем процент загруженного
                            var percentComplete = Math.ceil(evt.loaded / evt.total * 100);
                            showProgressLoad(percentComplete, index);
                            // устанавливаем значение в атрибут value тега <progress>
                            // и это же значение альтернативным текстом для браузеров, не поддерживающих <progress>
                            //progressBar.attr("data-percent", percentComplete);
                        }
                    }, false);
                    return xhr;
                },
                data: form_data,                         // Setting the data attribute of ajax with file_data
                type: 'post',
                success: function (jsondata) {
                    var place = $('#file' + index);
                    //alert(jsondata);
                    place.empty();
                    place.append('<input id="idPh' + index + '" name="photo' + index + '" type="hidden" value="' + jsondata + '">');
                    formCantBeSend[index - 1] = true;
                }
            });
            return reader.readAsDataURL(input.files[0]);
        }
    }
}
function add_file(id) {
    $('input#image_p' + id).click();
}
var Service = {
    focus_massege: function (data, opaciti) {
        $('#massage_' + data).animate({
            opacity: opaciti
        }, 700, function () {
            // Animation complete.
        });
    },
    check_valid: function (data, validator) {
        var result;

        var input = $(this);
        if (validator) {
            result = false;
            $('#massage_' + data).animate({
                opacity: 1
            }, 700, function () {
                // Animation complete.
            });
        }
        else {
            result = true;
            $('#massage_' + data).animate({
                opacity: 0
            }, 700, function () {
                // Animation complete.
            });
        }
        return result;
    }
};
$(document).ready(function () {

    //отображаем крестик в углу
    $('div.photoCar').hover(function () {
            var id = this.getAttribute("data-parameter");
            if (id == '0')return;
            $('div#' + id).append('<img class="delete" onclick="delete_image_funct(' + id + ')" style="  width: 35px;height:35px;" src="../res/img/close.png">');
        }
        , function () {
            $('div.photoCarDel').children().remove();
        });
});
function change_img_atribute(count) {
    //меняем фто  на изображение
    var img_field = $('div#class_with_photo' + count);
    img_field.attr("data-parameter", "0");
    var image = $('img#car_photo' + count);
    if (count == +1) {
        image.attr("src", "../res/img/add_photo_main.png");
    }
    else {
        image.attr("src", "../res/img/add_photo.png");
    }
    image.attr("data-parameter", count);
    image.attr("onclick", "add_file(" + count + ")");
    image.attr("style", "");
    $('#image_p' + count).val(null);
    $('div#' + count).remove();
}

function change_field_on_input_img(count, index_img) {
//            alert(count);
    count = count + 1;
    var id_photo = $('#idPh' + count).val();
    var place = $('#file' + count);
//            alert(id_photo);
    place.empty();
    var id = count - 1;
    place.append('<input accept="image/jpeg" id="image_p' + count + '" name="files[' + id + ']"  onchange="readURL(this,' + id + ');" type="file" multiple/>');
}