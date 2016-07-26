
<%@ page import="com.modelClass.Car" %>
<%@ page import="com.helpers.EncoderId" %>
<%@ page import="com.setting.Setting" %>
<%@ page import="com.modelClass.PhotoPath" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Comparator" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Добавить авто</title>
    <%--<script src="http://code.jquery.com/jquery-1.8.3.js"></script>--%>
    <script src="http://code.jquery.com/jquery-1.10.2.js"></script>
    <script>
        var engine_parameter=['Бензин','Дизель','Электро','Гибрид','Газ/бензин','Другое'];
        var gearbox_parameter=['Другое','Автоматическая','Механическая'];
    </script>
    <script type="text/javascript" src="/res/js/get_model_by_brand.js"></script>
    <script type="text/javascript" src="/res/js/write_parameters.js"></script>
    <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <script type="text/javascript" src="/res/js/pageForCar.js"></script>
    <link rel="shortcut icon" href="/res/img/favicon.ico"/>
    <link rel="stylesheet" type="text/css" href="/res/css/style_addCar.css">
    <link rel="stylesheet" type="text/css" href="/res/css/modal_windows_page_for_car.css">

    <% EncoderId encoderId=new EncoderId();
        Car car= (Car) session.getAttribute("chCar");
        boolean presentCar=false;
        if(car!=null) {
            presentCar = true;
            String path;
            if (car.getPhotoPath().size()==0) {
                path = "/res/img/notAvailable.png";
            } else {
                path = "/getPhoto?pathPhoto=" + car.getPhotoPath().get(0);
            }

        }
    %>


    <script>
        //отображаем крестик в углу
        $(document).ready(function() {
        $('div.photoCar').hover( function(){
                    var id=this.getAttribute("data-parameter");
                    if(id=='0')return;
                    $('div#'+id).append('<img class="delete" onclick="delete_image_funct('+id+')" style="  width: 35px;height:35px;" src="../res/img/close.png">');

                }
                , function(){ $('div.photoCarDel').children().remove(); }
        );
    });


        function change_img_atribute(count){
            //меняем фто  на изображение
            var img_field=$('div#class_with_photo'+count);
            img_field.attr("data-parameter","0");
            var image=$('img#car_photo'+count);
            image.attr("src","../res/img/add_photo.png");
            image.attr("data-parameter",count);
            image.attr("onclick","add_file("+count+")");
            $('#image_p'+count).val(null);
            $('div#'+count).remove();
        };

        function change_field_on_input_img(count,index_img){
//            alert(count);
            count=count+1;
            var id_photo=$('#idPh'+count).val();
            var place=$('#file'+count);
//            alert(id_photo);
            place.empty();
            var id=count-1;
            place.append('<input accept="image/jpeg" id="image_p'+count+'" name="files['+id+']"  onchange="readURL(this,'+id+');" type="file" multiple/>');
        }
        function delete_image_funct(count ){
            $('#modal_form'+count)
                    .css('display', 'block') // убираем у модального окна display: none;
                    .animate({opacity: 1, top: '50%'}, 200); // плавно прибавляем прозрачность одновременно со съезжанием вниз

            $('.modal_close').click( function(){ // ловим клик по крестику или подложке
                $('#modal_form'+count)
                        .animate({opacity: 0, top: '45%'}, 200,  // плавно меняем прозрачность на 0 и одновременно двигаем окно вверх
                        function(){ // после анимации
                            $(this).css('display', 'none'); // делаем ему display: none;
                        }
                );
                count=0;
                return;
            });
            $('#modal_del_ok'+count).click(function(){
                        if(count==0){return};
                        //убираем модальное окно
                        $('#modal_form'+count)
                                .animate({opacity: 0, top: '45%'}, 200,  // плавно меняем прозрачность на 0 и одновременно двигаем окно вверх
                                function(){ // после анимации
                                    $(this).css('display', 'none'); // делаем ему display: none;
                                }
                        );
                        change_field_on_input_img(count-1,0);
                        //меняем фто  на изображение
                       change_img_atribute(count);
                       //Шлем запрос на сервер
                        <%if (presentCar){%>
                        var present_photo=$('#present_photo'+count);
                        if(present_photo.val()=='true') {
                            var idPhoto=$("#idPhoto"+count).val();

//                            $('#class_with_photo' + count).append('<input id="present_photo' + count + '" type="hidden" value="false"  >')

                            $.get("/delete_photo", {count_of_photo: idPhoto, id_car:<%=car.getIdCar()%>})
                                    .done(function (data) {
                                    });
                            $('#present_photo'+count).val(false);
                        }

                        <%}%>
                        count=0;
                    }
            );
        }

    </script>



</head>

<body>
<header>
    <h1><a class="header"title="На главную" href=""><%=Setting.getProjectName()%></a></h1>
    <h2>Автомобили с пробегом <br>
        <Small>Только официальные дилеры</Small></h2>
</header>
<c:url var="logoutAction" value="/j_spring_security_logout"></c:url>

<ul id="menu">
    <li><a title="На главную" href="/">На главную</a></li>
    <li><a title="Мои автомобили" href="/myAccount">Мои автомобили</a></li>
    <li><a title="Выход"  href="${logoutAction}">Выход</a></li>
</ul>
<h1>${msg}</h1>


<div id="layout">
    <div id="baner-left">
    </div>
    <%--<div id="baner-right">--%>
        <%--some baner rightiygvbbuuuuuuuu uuuuuuuuuuuu uuuuuu uuuuuuuuuuu uuuuu uuuuuuu7 777777777777 77777 77777777 77777777 7777777 7777777--%>
    <%--</div>--%>
    <div id="result">
        <h3>Мое меню:</h3>
        <div class="auto">

            <%--///////////////////////////////////////////////////////////////////////////////////////////////--%>

                <link rel="stylesheet" href="/res/css/percircle.css">

                <style>

                    .small{
                        position: absolute;
                        font-size: 80px;
                        left: 50px;
                        top: 25px;
                    }


                </style>



            <%--/////////////////////////////////////////////////////////////////////////////////////--%>
            <form action="addCarWithPhoto" method="post">
                <%if (presentCar){%>
                <input type="hidden" id="id_car" value="<%= encoderId.encodId(car.getIdCar().toString())%>" name="id_car">
                <%}%>
                <input type="hidden" name="count_of_photo" value="8">
                <div class="col-sm-6 form-group">
                    <h2>Марка</h2>
                    <select id="id_make" class="form-control" onchange="p_delete(this.value,'');" name="make">
                    </select>
                </div>

                <h2>Модель</h2>
                <div class="col-sm-6 form-group">
                    <select id="id_model" name="model">
                        <option value="" selected="selected">выберите марку</option>
                    </select></p>
                </div>

                <h2>Цена, $ <br>
                    <%if(presentCar){%>
                    <input type="text" size="20" class="form-control" value="<%=car.getPrise()%>" required="required" name="prise" pattern="^[ 0-9]+$"></h2>
                <%}
                else {%>
                <input type="text" size="20" class="form-control" required="required" name="prise" pattern="^[ 0-9]+$"></h2>
                <%}%>

                <h2>Пробег, км <br>
                    <%if(presentCar){%>
                    <input type="text" size="20" class="form-control" value="<%=car.getMileage().replaceAll("[\\s]{1,}", "").trim()%>" required="required" name="mileage"
                           pattern="^[ 0-9]+$"></h2>
                <%}
                else {%>
                <input type="text" size="20" class="form-control" required="required" name="mileage" pattern="^[ 0-9]+$"></h2>
                <%}%>


                <h2>Год выпуска</h2>

                <select id="id_year_from" class="form-control" name="year_prov">

                </select>



                <h2>Тип двигателя</h2>
                <select id="id_engine" class="form-control" name="engine">

                </select>
                <h2 >Обьем двигателя, л (В формате 2.0)<br>
                    <%if(presentCar){%>
                    <input type="text" value="<%=car.getEngineCapacity()%>" size="3" class="form-control" required="required" name="engine_capacity" pattern="\d+(,\d{1})?+\d+(\.\d{1})?"></h2>
                <%}
                else {%>
                <input type="text" size="20" class="form-control" required="required" name="engine_capacity" pattern="\d+(,\d{1})?+\d+(\.\d{1})?"></h2>
                <%}%>

                <h2>Тип КПП</h2>

                <select id="id_gearbox" class="form-control" name="gearbox">

                </select>
                <p>РЕГИОН<br>
                    <select id="id_region" class="form-control" name="region">

                    </select></p>
                <h2>Комплектация: <br>
                    <%if(presentCar){%>
                    <input type="text" size="20" class="form-control" maxlength="20" name="equipment" value="<%=car.getEquipment()%>"></h2>
                <%}
                else {%>
                <input type="text" size="20" class="form-control"  maxlength="20" name="equipment" ></h2>
                <%}%>

                <h2>Описание</h2><br>
                <%if(presentCar){%>
                <textarea name="comment"  class="form-control" maxlength="380" required="required" cols="40" rows="7"><%=car.getDescription()%></textarea></h2>
                <%}
                else {%>
                <textarea name="comment" class="form-control" maxlength="380" required="required" cols="40" rows="7"></textarea></h2>
                <%}%>


                <table id="fileTable">
                    <tr>
                        <td>

                            <br>
                            <div id="form_cars_data" >
                                <div class="photo">
                                    <%


                                        for (int i=0;i<8;i++){
                                        boolean presentPhoto=false;
                                        Long idPhotoCar=0L;
                                        String path="../res/img/add_photo.png";
                                        if(presentCar){
                                            List<PhotoPath> photoPaths=car.getPhotoPath();
//                                            Collections.sort(photoPaths, new Comparator<PhotoPath>() {
//                                                @Override
//                                                public int compare(PhotoPath o1, PhotoPath o2) {
//                                                    return o1.getIdPhoto().compareTo(o2.getIdPhoto());
//                                                }
//                                            });
                                            if(i<car.getPhotoPath().size()){

                                                presentPhoto=true;
                                                idPhotoCar=photoPaths.get(i).getIdPhoto();
                                                path="/getPhoto?pathPhoto="+photoPaths.get(i)+"&Width=200&Height=200";
                                            }
                                        }%>

                                    <div class="photoCar" id="class_with_photo<%=i+1%>" data-parameter="<%=i+1%>" >
                                        <div class="modal_form" id="modal_form<%=i+1%>">
                                            <p style="position: absolute; top: -15%">
                                                <h8>Вы действительно хотите удалить фото?</h8><br>
                                                <button  class="modal_close"  type="button" style="position:absolute; right: 0%"  >Отменить</button>
                                                <button data-parameter="<%=presentPhoto%>" id="modal_del_ok<%=i+1%>" style="position:absolute; right: 78%"  type="button" >Удалить</button>
                                            </p>
                                        </div>
                                        <input id="present_photo<%=i+1%>" type="hidden"  value="<%=presentPhoto%>"  >
                                        <input id="idPhoto<%=i+1%>" type="hidden" value="<%=idPhotoCar%>">

                                        <a hidden id="file<%=i+1%>" ><input accept="image/jpeg" id="image_p<%=i+1%>" name="files[<%=i%>]"  onchange="readURL(this,<%=i%>);" type="file" multiple/></a>
                                        <img  id="car_photo<%=i+1%>"  src="<%=path%>" class="image_block" alt=""/>

                                        <%--                          Progress bar                             --%>
                                        <div id="pinkcircle<%=i+1%>"  style="display: none"  class="small  pink percircle animate ">
                                            <span id="percent<%=i+1%>">0%</span>
                                            <!--gt50-->
                                            <div class="slice">
                                                <div class="bar" id="percent_rotation<%=i+1%>" style="transform: rotate(0deg);"></div>
                                                    <div class="fill" id="percent_rot1"></div>
                                            </div>
                                        </div>

                                        <%--<progress class="progressbar" id="progressbar<%=i+1%>" value="0" max="100"></progress>--%>

                                        <div  id="<%=i+1%>"  class="photoCarDel" >  </div>
                                    </div>
                                    <%if(!presentPhoto){%>
                                    <script>
                                        change_img_atribute('<%=i+1%>');
                                    </script>
                                    <%}}%>
                                </div>
                            </div>

                         </td>

                    </tr>

                </table>

                <br>
                <%if(presentCar){%>
                <button type="submit" >Изменить</button><br>
                <%}else {%>
                <button type="submit" >Добавить авто</button><br>
                <%}

                %>
            </form>

        </div>
    </div>
</div>
<footer>Подвал </footer>









</body>
</html>

