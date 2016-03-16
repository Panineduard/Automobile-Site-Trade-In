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
            return reader.readAsDataURL(input.files[0]);
        }

    }
};
function add_file(id){
    $('input#image_p'+id).click();

} ;