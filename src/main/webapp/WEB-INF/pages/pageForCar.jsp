<%@ page import="com.modelClass.Car" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Добавить авто</title>
    <script src="http://code.jquery.com/jquery-1.8.3.js"></script>

    <script type="text/javascript" src="/res/js/get_model_by_brand.js"></script>
    <script src="/res/assets/plugins/jquery-1.10.2.js"></script>

    <script>
        $(document).ready(function() {
            //add more file components if Add is clicked
            $('#addFile').click(function() {
                var fileIndex = $('#fileTable tr').children().length ;
                if(fileIndex<7) {
                    $('#fileTable').append(
                            '<tr><td>' +
                            '   <input id="img_p' + fileIndex + '"  accept="image/jpeg" type="file" name="files[' + fileIndex + ']" onchange="readURL(this,' + fileIndex + ');" />' +
                            '   <img id="img_prev' + fileIndex + '" class="image_block"  alt="" />' +
                            '</td></tr>');
                }
            });

        });
    </script>
    <script>
        function readURL(input,index) {
            if(!/(\.jpg|\.jpeg)$/i.test(input.value))
            {
            alert('Не допустимый формат изображения');
            document.getElementById('image_p'+index).value='';return false;
            }
            else {
//            for (var i = 0; i<= index; i++ )
//            {
                if (input.files && input.files[0]) {
//
                    var reader = new FileReader();
//
                    reader.onload = function (e) {
//
                        $('#img_prev'+index)

                                .attr('src', e.target.result)

                                .width(150);

                    };
//
                    return reader.readAsDataURL(input.files[0]);
//
                }
//            }
        }
        }

    </script>
    <script>
        function delete_image_funct(count ){

            var cars_data=document.getElementById("form_cars_data");
            var cars_path=document.createElement("input");
            cars_path.setAttribute("type","hidden");
            cars_path.setAttribute("value",count);
            cars_path.setAttribute("name","photo".concat(count));
            cars_data.appendChild(cars_path);
            cars_data.removeChild(document.getElementById("car_photo".concat(count)));
            cars_data.removeChild(document.getElementById("car_delete_button".concat(count)));
        }

    </script>

    <%--<script type="text/javascript" src="/res/js/linkedselect.js"></script>--%>
    <link rel="stylesheet" type="text/css" href="/res/css/style_addCar.css">
</head>

<body>
<header>
    <h1><a class="header"title="На главную" href="">NAME OF OUR PROJECT</a></h1>
    <h2>Автомобили с пробегом <br>
        <Small>Только официальные дилеры</Small></h2>
</header>
<ul id="menu">
    <li><a title="На главную" href="/">На главную</a></li>
    <li><a title="Мои автомобили" href="">Мои автомобили</a></li>
    <li><a title="Добавить авто" href="">+ Добавить авто</a></li>
    <li><a title="Выход"  href="">Выход</a></li>
</ul>
<h1>${msg}</h1>
<% Car car= (Car) request.getAttribute("car");
    boolean presentCar=false;
    String EnginesType = "нет данных";
    String transmission = "нет данных";
    if(car!=null) {
        presentCar = true;

        String path;
        if (car.getPhotoPath().get(0).equals("null")) {
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
    <input type="hidden"value="<%=car.getIdCar()%>" name="id_car" >
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
    <input type="text" size="20" class="form-control" value="<%=car.getMileage()%>" required="required" name="mileage" pattern="^[ 0-9]+$"></h2>
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
<option value="elektro">Электро</option>
<option value="hybrid">Гибрид</option>
<option value="other">Другое</option>
</select>
<h2>Обьем двигателя, л <br>
    <%if(presentCar){%>
    <input type="text" value="<%=car.getEngineCapacity()%>" size="20" class="form-control" required="required" name="engine_capacity" pattern="^[ 0-9]+$"></h2>
    <%}
    else {%>
    <input type="text" size="20" class="form-control" required="required" name="engine_capacity" pattern="^[ 0-9]+$"></h2>
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
        <input type="text" size="20" class="form-control"  name="equipment" value="<%=car.getEquipment()%>"></h2>
        <%}
        else {%>
        <input type="text" size="20" class="form-control"  name="equipment" ></h2>
        <%}%>

    <h2>Описание</h2><br>
    <%if(presentCar){%>
    <textarea name="comment"  class="form-control" required="required" cols="40" rows="7"><%=car.getDescription()%></textarea></h2>
    <%}
    else {%>
    <textarea name="comment" class="form-control" required="required" cols="40" rows="7"></textarea></h2>
    <%}%>


    <table id="fileTable">
        <tr>
            <td>

                <br>
                <div id="form_cars_data" >
                <%
                    if(presentCar){
                  int countCarsPhoto=0;

                        for (String path:car.getPhotoPath()){%>

                <img id="car_photo<%=countCarsPhoto%>" src="<%="/getPhoto?pathPhoto="+path%>" class="image_block" alt=""/>

                <a id="car_delete_button<%=countCarsPhoto%>" href="#" onclick="delete_image_funct('<%=countCarsPhoto%>')" class="more" title="Удалить" >Удалить</a>
                <%
                            countCarsPhoto++;
                        }
                    }%>
                </div>
                <br>
                <input accept="image/jpeg" id="image_p" name="files[0]" type="file"  onchange="readURL(this,'0');" />
                <img id="img_prev0" class="image_block"  alt="" />
            </td>

        </tr>

    </table>
    <br>
    <img id="addFile" type="image" src="/res/img/icon-addons.png" width="50" alt="Еще фото" />
    <h6>Добавить больше фото</h6>
    <br>
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






