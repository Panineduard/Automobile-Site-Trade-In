<%@ page import="com.modelClass.Car" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Добавить авто</title>
    <%--<script src="/res/assets/plugins/jQuery.min.js"></script>--%>
    <script src="/res/assets/plugins/jquery-1.10.2.js"></script>
<script>
    function one(){

    }

</script>
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

    <script type="text/javascript" src="/res/js/linkedselect.js"></script>
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
    <select id="id_make1" class="form-control" name="make">
        <%if(presentCar){%>

        <option value="<%=car.getBrand()%>" selected="selected"><%=car.getBrand()%></option>
        <%}
        else {%>
<option value="" selected="selected">выберите марку</option>
        <%}%>
<option value="acura">Acura </option>
<option value="audi"class="cat-top">Audi </option>
<option value="469"class="cat-top">BMW </option>
<option value="583"class="cat-top">Chevrolet (3632)</option>
<option value="1004"class="cat-top">Citroen (1767)</option>
<option value="1639"class="cat-top">Daewoo (4922)</option>
<option value="689"class="cat-top">Fiat </option>
<option value="1723"class="cat-top">Ford </option>
<option value="1697"class="cat-top">Honda </option>
<option value="927"class="cat-top">Hyundai </option>
<option value="297"class="cat-top">Infiniti </option>
<option value="1569"class="cat-top">KIA </option>
<option value="1872"class="cat-top">Mazda (2612)</option>
<option value="1121"class="cat-top">Mercedes (5145)</option>
<option value="1094"class="cat-top">Mitsubishi (3545)</option>
<option value="1522"class="cat-top">Nissan (3801)</option>
<option value="1374"class="cat-top">Opel (5878)</option>
<option value="1032"class="cat-top">Peugeot (2410)</option>
<option value="398">Porsche (224)</option>
<option value="1826"class="cat-top">Renault (4661)</option>
<option value="Seat">Seat </option>
<option value="Skoda"class="cat-top">Skoda </option>
<option value="519"class="cat-top">Subaru </option>
<option value="431"class="cat-top">Suzuki (661)</option>
<option value="1594"class="cat-top">Toyota (3687)</option>
<option value="Volkswagen"class="cat-top">Volkswagen</option>
<option value="1479"class="cat-top">Volvo</option>
<option value="1659"class="cat-top">ВАЗ</option>
<option value="1799"class="cat-top">ГАЗ</option>
<option value="576"class="cat-top">ЗАЗ (3524)</option>
</select>
</div>

<h2>Модель</h2>
<div class="col-sm-6 form-group">
<select id="id_model1" class="form-control" name="model">
<option value="" selected="selected">укажите марку</option>
</select>
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

    <h2>Комплектация: <br>
        <input type="text" size="20" class="form-control"  name="equipment" ></h2>

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
<button type="submit" >Добавить авто</button><br>

</form:form>

        </div>
    </div>
</div>
<footer>Подвал </footer>


<script type="text/javascript">
    // Создаем новый объект связанных списков
    var syncList1 = new syncList;

    // Определяем значения подчиненных списков (2 и 3 селектов)
    syncList1.dataList = {

        /* Определяем элементы второго списка в зависимости
         от выбранного значения в первом списке */

        '': {
            '': 'Вы не выбрали марку',

        },

        'Volkswagen': {
            <%if(presentCar){%>
            '<%=car.getModel()%>':'<%=car.getModel()%>',
            <%}%>
            'Passat': 'Passat',
            'Jeta': 'Jeta',
            'Polo': 'Polo'


        }


    };

    // Включаем синхронизацию связанных списков
    syncList1.sync("id_make1", "id_model1");
</script>







</body>
</html>






