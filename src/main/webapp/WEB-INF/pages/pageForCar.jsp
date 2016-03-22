
<%@ page import="com.modelClass.Car" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Добавить авто</title>
    <script src="http://code.jquery.com/jquery-1.8.3.js"></script>

    <script type="text/javascript" src="/res/js/get_model_by_brand.js"></script>
    <script src="/res/assets/plugins/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="/res/js/pageForCar.js"></script>
    <link rel="stylesheet" type="text/css" href="/res/css/style_addCar.css">
    <link rel="stylesheet" type="text/css" href="/res/css/modal_windows_page_for_car.css">

    <% Car car= (Car) request.getAttribute("car");
        boolean presentCar=false;
        String EnginesType = "нет данных";
        String transmission = "нет данных";
        if(car!=null) {
            presentCar = true;
            String path;
            if (car.getPhotoPath().size()==0) {
                path = "/res/img/notAvailable.png";
            } else {
                path = "/getPhoto?pathPhoto=" + car.getPhotoPath().get(0);
            }
            if (car.getEnginesType().equals("gasoline")) {
                EnginesType = "Бензин";
            } else if (car.getEnginesType().equals("disel")) {
                EnginesType = "Дизель";
            } else if (car.getEnginesType().equals("elektro")) {
                EnginesType = "Электро";
            } else if (car.getEnginesType().equals("hybrid")) {
                EnginesType = "Гибрид";
            }
            if (car.getTransmission().equals("auto")) {
                transmission = "Автомат";
            } else if (car.getTransmission().equals("mechanical")) {
                transmission = "Механическая";
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
    <h1><a class="header"title="На главную" href="">NAME OF OUR PROJECT</a></h1>
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
    <div id="baner-right">
        some baner rightiygvbbuuuuuuuu uuuuuuuuuuuu uuuuuu uuuuuuuuuuu uuuuu uuuuuuu7 777777777777 77777 77777777 77777777 7777777 7777777
    </div>
    <div id="result">
        <h3>Мое меню:</h3>
        <div class="auto">


            <form:form  action="addCarWithPhoto" method="post"
                        modelAttribute="uploadForm" enctype="multipart/form-data" >
                <%if (presentCar){%>
                <input type="hidden" value="<%=car.getIdCar()%>" name="id_car">
                <%}%>
                <div class="col-sm-6 form-group">
                    <h2>Марка</h2>
                    <select id="id_make1" class="form-control" onchange="p_delete(this.value);" name="make">
                        <%if(presentCar){%>
                        <option value="<%=car.getBrand()%>" selected="selected"><%=car.getBrand()%></option>
                        <%}
                        else {%>
                        <option value="" selected="selected">выберите марку</option>
                        <%}%>
                        <option value="Acura">Acura </option>
                        <option value="Alfa_Romeo">Alfa Romeo </option>
                        <option value="Audi"class="cat-top">Audi </option>
                        <option value="BMW"class="cat-top">BMW </option>
                        <option value="Chevrolet"class="cat-top">Chevrolet</option>
                        <option value="Citroen"class="cat-top">Citroen</option>
                        <option value="Daewoo"class="cat-top">Daewoo</option>
                        <option value="Fiat"class="cat-top">Fiat </option>
                        <option value="Ford"class="cat-top">Ford </option>
                        <option value="Honda"class="cat-top">Honda </option>
                        <option value="Hyundai"class="cat-top">Hyundai </option>
                        <option value="Infiniti"class="cat-top">Infiniti </option>
                        <option value="KIA"class="cat-top">KIA </option>
                        <option value="Mazda"class="cat-top">Mazda</option>
                        <option value="Mercedes"class="cat-top">Mercedes</option>
                        <option value="Mitsubishi"class="cat-top">Mitsubishi</option>
                        <option value="Nissan"class="cat-top">Nissan</option>
                        <option value="Opel"class="cat-top">Opel</option>
                        <option value="Peugeot"class="cat-top">Peugeot</option>
                        <option value="Porsche">Porsche </option>
                        <option value="Renault"class="cat-top">Renault</option>
                        <option value="Seat">Seat </option>
                        <option value="Skoda"class="cat-top">Skoda </option>
                        <option value="Subaru"class="cat-top">Subaru </option>
                        <option value="Suzuki"class="cat-top">Suzuki </option>
                        <option value="Toyota"class="cat-top">Toyota</option>
                        <option value="Volkswagen"class="cat-top">Volkswagen</option>
                        <option value="Volvo"class="cat-top">Volvo</option>
                        <option value="ВАЗ"class="cat-top">ВАЗ </option>
                        <option value="ГАЗ"class="cat-top">ГАЗ </option>
                        <option value="ЗАЗ"class="cat-top">ЗАЗ </option>
                    </select>
                </div>

                <h2>Модель</h2>
                <div class="col-sm-6 form-group">
                    <select id="id_model" name="model">
                        <%if(presentCar){%>
                        <option value="<%=car.getModel()%>" selected="selected"><%=car.getModel()%></option>
                        <%}
                        else {%>
                        <option value="" selected="selected">выберите марку</option>
                        <%}%>
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
                    <input type="text" size="20" class="form-control" value="<%=car.getMileage()%>" required="required" name="mileage"
                           pattern="^[ 0-9]+$"></h2>
                <%}
                else {%>
                <input type="text" size="20" class="form-control" required="required" name="mileage" pattern="^[ 0-9]+$"></h2>
                <%}%>


                <h2>Год выпуска</h2>

                <select id="id_year_from" class="form-control" name="year_prov">
                <%if(presentCar){%>
                    <option value="<%=car.getYearMade()%>" selected="selected"><%=car.getYearMade()%></option>
                    <%}
                    else {%>
                    <option value="" selected="selected"></option>
                    <%}%>
                    <option value="2016">2016</option>
                    <option value="2015">2015</option>
                    <option value="2014">2014</option>
                    <option value="2013">2013</option>
                    <option value="2012">2012</option>
                    <option value="2011">2011</option>
                    <option value="2010">2010</option>
                    <option value="2009">2009</option>
                    <option value="2008">2008</option>
                    <option value="2007">2007</option>
                    <option value="2006">2006</option>
                    <option value="2005">2005</option>
                    <option value="2004">2004</option>
                    <option value="2003">2003</option>
                    <option value="2002">2002</option>
                    <option value="2001">2001</option>
                    <option value="2000">2000</option>
                    <option value="1999">1999</option>
                    <option value="1998">1998</option>
                    <option value="1997">1997</option>
                    <option value="1996">1996</option>
                    <option value="1995">1995</option>
                    <option value="1994">1994</option>
                    <option value="1993">1993</option>
                    <option value="1992">1992</option>
                    <option value="1991">1991</option>
                    <option value="1990">1990</option>
                    <option value="1989">1989</option>
                    <option value="1988">1988</option>
                    <option value="1987">1987</option>
                    <option value="1986">1986</option>
                    <option value="1985">1985</option>
                    <option value="1984">1984</option>
                    <option value="1983">1983</option>
                    <option value="1982">1982</option>
                    <option value="1981">1981</option>
                    <option value="1980">1980</option>
                    <option value="1979">1979</option>
                    <option value="1978">1978</option>
                    <option value="1977">1977</option>
                    <option value="1976">1976</option>
                    <option value="1975">1975</option>
                    <option value="1974">1974</option>
                    <option value="1973">1973</option>
                    <option value="1972">1972</option>
                    <option value="1971">1971</option>
                    <option value="1970">1970</option>
                    <option value="1969">1969</option>
                    <option value="1968">1968</option>
                    <option value="1967">1967</option>
                    <option value="1966">1966</option>
                    <option value="1965">1965</option>
                    <option value="1964">1964</option>
                    <option value="1963">1963</option>
                    <option value="1962">1962</option>
                    <option value="1961">1961</option>
                    <option value="1960">1960</option>
                    <option value="1959">1959</option>
                    <option value="1958">1958</option>
                    <option value="1957">1957</option>
                    <option value="1956">1956</option>
                    <option value="1955">1955</option>
                    <option value="1954">1954</option>
                    <option value="1953">1953</option>
                    <option value="1952">1952</option>
                    <option value="1951">1951</option>
                    <option value="1950">1950</option>
                    <option value="1949">1949</option>
                    <option value="1948">1948</option>
                    <option value="1947">1947</option>
                    <option value="1946">1946</option>
                    <option value="1945">1945</option>
                    <option value="1944">1944</option>
                    <option value="1943">1943</option>
                    <option value="1942">1942</option>
                    <option value="1941">1941</option>
                    <option value="1940">1940</option>
                    <option value="1939">1939</option>
                    <option value="1938">1938</option>
                    <option value="1937">1937</option>
                    <option value="1936">1936</option>
                    <option value="1935">1935</option>
                    <option value="1934">1934</option>
                    <option value="1933">1933</option>
                    <option value="1932">1932</option>
                    <option value="1931">1931</option>
                    <option value="1930">1930</option>
                    <option value="1929">1929</option>
                    <option value="1928">1928</option>
                    <option value="1927">1927</option>
                    <option value="1926">1926</option>
                    <option value="1925">1925</option>
                    <option value="1924">1924</option>
                    <option value="1923">1923</option>
                    <option value="1922">1922</option>
                    <option value="1921">1921</option>
                </select>



                <h2>Тип двигателя</h2>
                <select id="id_engine" class="form-control" name="engine">
                    <%if(presentCar){%>
                    <option value="<%=car.getEnginesType()%>" selected="selected"><%=EnginesType%></option>
                    <%}
                    else {%>
                    <option value="" selected="selected"></option>
                    <%}%>
                    <option value="gasoline">Бензин</option>
                    <option value="disel">Дизель</option>
                    <option value="gas">Газ\бензин</option>
                    <option value="elektro">Электро</option>
                    <option value="hybrid">Гибрид</option>
                    <option value="other">Другое</option>
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
                    <%if(presentCar){%>
                    <option value="<%=car.getTransmission()%>" ><%=transmission%></option>
                    <%}%>
                    <option value="another" >Другое</option>
                    <option value="auto">Автоматическая</option>
                    <option value="mechanical">Механическая</option>
                </select>
                <p>РЕГИОН<br>
                    <select id="id_region" class="form-control" name="region">
                        <option value="0">Не определено</option>
                        <option value="1">Винница</option>
                        <option value="11">Днепропетровск</option>
                        <option value="13">Донецк</option>
                        <option value="2">Житомир</option>
                        <option value="14">Запорожье</option>
                        <option value="15">Ивано-Франковск</option>
                        <option value="10">Киев</option>
                        <option value="16">Кировоград</option>
                        <option value="17">Луганск</option>
                        <option value="18">Луцк</option>
                        <option value="5">Львов</option>
                        <option value="19">Николаев</option>
                        <option value="12">Одесса</option>
                        <option value="20">Полтава</option>
                        <option value="9">Ровно</option>
                        <option value="21">Симферополь</option>
                        <option value="8">Сумы</option>
                        <option value="3">Тернополь</option>
                        <option value="22">Ужгород</option>
                        <option value="7">Харьков</option>
                        <option value="23">Херсон</option>
                        <option value="4">Хмельницкий</option>
                        <option value="24">Черкассы</option>
                        <option value="6">Чернигов</option>
                        <option value="25">Черновцы</option>
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


                                    <%for (int i=0;i<8;i++){
                                        boolean presentPhoto=false;
                                        Long idPhotoCar=0L;
                                        String path="../res/img/add_photo.png";
                                        if(presentCar){
                                            if(i<car.getPhotoPath().size()){
                                                presentPhoto=true;
                                                idPhotoCar=car.getPhotoPath().get(i).getIdPhoto();
                                                path="/getPhoto?pathPhoto="+car.getPhotoPath().get(i)+"&Width=200&Height=200";
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

                                        <a hidden id="file<%=i+1%>" ><input accept="image/jpeg" id="image_p<%=i+1%>" name="files[<%=i%>]"  onchange="readURL(this,<%=i%>);" type="file" /></a>
                                        <img  id="car_photo<%=i+1%>"  src="<%=path%>" class="image_block" alt=""/>
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
                <%}%>
            </form:form>

        </div>
    </div>
</div>
<footer>Подвал </footer>









</body>
</html>

