<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.modelClass.Dealer" %>
<%@ page import="com.modelClass.Car" %>
<%@ page import="java.util.List" %>
<%@ page import="com.modelClass.Contact_person" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="/res/css/style_my_acount.css">
<!-- <link href='https://fonts.googleapis.com/css?family=Shadows+Into+Light' rel='stylesheet' type='text/css'> -->
<title> Автомобили с пробегом </title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <style type="text/css">
        /* Окно */
        #modal_form {
            width: 300px;
            height: 300px; /* Размеры должны быть фиксированы */
            border-radius: 5px;
            border: 3px #000 solid;
            background: #fff;
            position: fixed; /* чтобы окно было в видимой зоне в любом месте */
            top: 45%; /* отступаем сверху 45%, остальные 5% подвинет скрипт */
            left: 50%; /* половина экрана слева */
            margin-top: -150px;
            margin-left: -150px; /* тут вся магия центровки css, отступаем влево и вверх минус половину ширины и высоты соответственно =) */
            display: none; /* в обычном состоянии окна не должно быть */
            opacity: 0; /* полностью прозрачно для анимирования */
            z-index: 5; /* окно должно быть наиболее большем слое */
            padding: 20px 10px;
        }
        /* Кнопка закрыть для тех кто в танке) */
        #modal_form #modal_close {
            width: 21px;
            height: 21px;
            position: absolute;
            top: 10px;
            right: 10px;
            cursor: pointer;
            display: block;
        }
        /* Подложка */
        #overlay {
            z-index: 3; /* подложка должна быть выше слоев элементов сайта, но ниже слоя модального окна */
            position: fixed; /* всегда перекрывает весь сайт */
            background-color: #000; /* черная */
            opacity: 0.8; /* но немного прозрачна */
            width: 100%;
            height: 100%; /* размером во весь экран */
            top: 0;
            left: 0; /* сверху и слева 0, обязательные свойства! */
            cursor: pointer;
            display: none; /* в обычном состоянии её нет) */
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function() { // вся магия после загрузки страницы
            $('a#go').click( function(event){ // ловим клик по ссылки с id="go"
                event.preventDefault(); // выключаем стандартную роль элемента
                $('#overlay').fadeIn(400, // сначала плавно показываем темную подложку
                        function(){ // после выполнения предъидущей анимации
                            $('#modal_form')
                                    .css('display', 'block') // убираем у модального окна display: none;
                                    .animate({opacity: 1, top: '50%'}, 200); // плавно прибавляем прозрачность одновременно со съезжанием вниз
                        });
            });
            /* Закрытие модального окна, тут делаем то же самое но в обратном порядке */
            $('#modal_close, #overlay').click( function(){ // ловим клик по крестику или подложке
                $('#modal_form')
                        .animate({opacity: 0, top: '45%'}, 200,  // плавно меняем прозрачность на 0 и одновременно двигаем окно вверх
                        function(){ // после анимации
                            $(this).css('display', 'none'); // делаем ему display: none;
                            $('#overlay').fadeOut(400); // скрываем подложку
                        }
                );
            });
        });
    </script>
</head>

<body>
<header>
<h1><a class="header"title="На главную" href="">NAME OF OUR PROJECT</a></h1>
<h2>Автомобили с пробегом <br>
<Small>Только официальные дилеры</Small></h2>
<!-- <h5>Результаты поиска: </h5><br>  -->
</header>
<ul id="menu">
  <li><a title="На главную" href="/">На главную</a></li>
  <li><a title="Мои автомобили" href="">Мои автомобили</a></li>
  <li><a title="Добавить авто" href="/addCar">+ Добавить авто</a></li>
    <c:url var="logoutAction" value="/j_spring_security_logout"></c:url>

    <li><a title="Выход"  href="${logoutAction}">Выход</a></li>
</ul>
<%
    Dealer dealer = (Dealer)request.getAttribute("dealer");
    List<Car> cars= (List<Car>) request.getAttribute("cars");

%>

<div id="layout">
<div id="baner-left">
<form action="/lookForCars" method="post">
<div id="search">
<p>МАРКА<br>
<select id="id_make1" class="form-control" name="make1">
                  <option value="" selected="selected">выберите марку</option>
                  <option value="" selected="selected">все</option>
                  <option value="131">Acura </option>
                  <%--<option value="722">Alfa Romeo </option>--%>
                  <%--<option value="273">Aston Martin </option>--%>
                  <option value="1408"class="cat-top">Audi </option>
                  <%--<option value="266">Bentley </option>--%>
                  <option value="469"class="cat-top">BMW </option>

                  <%--<option value="1780">Bugatti </option>--%>
                  <%--<option value="565">Buick </option>--%>
                  <%--<option value="21">BYD </option>--%>
                  <%--<option value="990">Cadillac </option>--%>
                  <%----%>
                  <%--<option value="77">Chery </option>--%>
                  <option value="583"class="cat-top">Chevrolet</option>
                  <%--<option value="957">Chrysler </option>--%>
                  <option value="1004"class="cat-top">Citroen</option>
                  <%--<option value="344">Dacia </option>--%>

                  <option value="1639"class="cat-top">Daewoo</option>
                  <%--<option value="417">Daihatsu (70)</option>--%>
                  <%----%>
                  <%--<option value="546">Dodge </option>--%>
                  <%----%>
                  <%--<option value="263">Ferrari </option>--%>
                  <option value="689"class="cat-top">Fiat </option>

                  <option value="1723"class="cat-top">Ford </option>

                  <%--<option value="48">Geely </option>--%>
                  <%--<option value="224">GMC </option>--%>

                  <%--<option value="96">Great Wall </option>--%>

                  <option value="1697"class="cat-top">Honda </option>

                  <%--<option value="288">Hummer (27)</option>--%>
                  <option value="927"class="cat-top">Hyundai </option>
                  <option value="297"class="cat-top">Infiniti </option>

                  <%--<option value="914">Isuzu </option>--%>
                  <%--<option value="18">JAC </option>--%>
                  <%--<option value="331">Jaguar </option>--%>
                  <%--<option value="1072">Jeep </option>--%>

                  <option value="1569"class="cat-top">KIA </option>

                  <%--<option value="258">Lamborghini </option>--%>
                  <%--<option value="1858">Lancia </option>--%>
                  <%--<option value="986"class="cat-top">Land Rover </option>--%>

                  <%--<option value="310"class="cat-top">Lexus </option>--%>
                  <%--<option value="29">Lifan (55)</option>--%>
                  <%--<option value="375">Lincoln (31)</option>--%>
                  <%--<option value="252">Maserati (13)</option>--%>
                  <%--<option value="1797">Maybach (15)</option>--%>
                  <option value="1872"class="cat-top">Mazda</option>
                  <option value="1121"class="cat-top">Mercedes</option>
                  <%--<option value="2977">MG (73)</option>--%>
                  <%--<option value="148">MINI (56)</option>--%>
                  <option value="1094"class="cat-top">Mitsubishi</option>
                  <option value="1522"class="cat-top">Nissan</option>
                  <option value="1374"class="cat-top">Opel</option>
                  <option value="1032"class="cat-top">Peugeot</option>
                  <option value="398">Porsche (224)</option>
                  <option value="1826"class="cat-top">Renault</option>
                  <%--<option value="243">Rolls Royce (16)</option>--%>
                  <%--<option value="447">Rover (97)</option>--%>
                  <%--<option value="980">Saab (51)</option>--%>
                  <%--<option value="43">Samand (62)</option>--%>
                  <%--<option value="138">Samsung (8)</option>--%>
                  <option value="1058">Seat (458)</option>
                  <option value="1081"class="cat-top">Skoda </option>
                  <%--<option value="3000">SMA (11)</option>--%>
                  <%--<option value="2974">Smart (312)</option>--%>
                  <%--<option value="680"class="cat-top">SsangYong (734)</option>--%>
                  <option value="519"class="cat-top">Subaru </option>
                  <option value="431"class="cat-top">Suzuki </option>

                  <%--<option value="2001">Tesla (7)</option>--%>
                  <option value="1594"class="cat-top">Toyota</option>

                  <option value="volkswagen"class="cat-top">Volkswagen</option>
                  <option value="1479"class="cat-top">Volvo</option>

                  <%--<option value="180">Богдан (102)</option>--%>
                  <option value="1659"class="cat-top">ВАЗ </option>
                  <option value="1799"class="cat-top">ГАЗ </option>
                  <option value="576"class="cat-top">ЗАЗ </option>

                  <%--<option value="634"class="cat-top">Москвич (843)</option>--%>
                  <%--<option value="7183">СМЗ (7)</option>--%>
                  <%--<option value="1782">УАЗ (411)</option>--%>
                </select></p>
<p>МОДЕЛЬ<br>
<select id="id_model1" class="form-control" name="model1">
                  <option value="" selected="selected">укажите марку</option>
                </select></p>
<p>ЦЕНА<br>
<input id="id_price_from" type="text" placeholder="от" class="form-control" name="price_from" />
<input id="id_price_to" type="text" placeholder="до" class="form-control" name="price_to" />
</p>
<p>ГОД ВЫПУСКА<br>
<select id="id_year_from" class="form-control" name="year_from">
                    <option value="" selected="selected">c</option>
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
                    <!-- <option value="1979">1979</option>
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
 -->                  </select>
 <select id="id_year_to" class="form-control" name="year_to">
                    <option value="" selected="selected">по</option>
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
                    <!-- <option value="1979">1979</option>
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
                    <option value="1921">1921</option> -->
                  </select></p>
<p>ТИП ДВИГАТЕЛЯ</br>
<select id="id_engine" class="form-control" name="engine">
                      <option value="" selected="selected">все</option>
                      <option value="1948">Бензин</option>
                      <option value="1987">Дизель</option>
                      <option value="2022">Электро</option>
                      <option value="1988">Гибрид</option>
                    </select></p>
ТИП КПП<br>
<select id="id_gearbox" class="form-control" name="gearbox">
                      <option value="" selected="selected">все</option>
                      <option value="2009">Автоматическая</option>
                      <option value="2008">Механическая</option>
                    </select>

<p>РЕГИОН<br>
<select id="id_region" class="form-control" name="region">
                      <option value="" selected="selected">все</option>
                      <!---<select class="e-form" id="regionCenters" name="state[0]">-->
                        <option value="0">Любой</option>
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
					  <button type="submit" class="btn btn-primary btn-lg ">Подобрать авто</button>
</div>
					  </form>
</div>
<div id="baner-right">
some baner rightiygvbbuuuuuuuu uuuuuuuuuuuu uuuuuu uuuuuuuuuuu uuuuu uuuuuuu7 777777777777 77777 77777777 77777777 7777777 7777777
</div>

<div id="result">
<h3>Мое меню:</h3>
<div class="auto">

    <script>

        function changeAddress(){
            var address=document.getElementById("address");
            var dealer_data=document.getElementById("dealer_data");
            dealer_data.removeChild(address);
            var form=document.createElement("form");
            form.setAttribute("action","/changeAddress");
            form.setAttribute("method","post")

            var city=document.createElement("span");
            <%if(!dealer.getAddress().getCity().isEmpty()){%>
            var node = document.createTextNode(<%=dealer.getAddress().getCity() %>);
            <%}%>
            city.appendChild(node);

            var field_for_index=document.createElement("input");
            field_for_index.setAttribute("type","text");
            field_for_index.setAttribute("placeholder","Индекс");
            <%if(!dealer.getAddress().getIndex().isEmpty()){%>
            field_for_index.setAttribute("value",<%=dealer.getAddress().getIndex() %>);
<%}%>
            var field_for_street=document.createElement("input");
            field_for_street.setAttribute("type","text");
            field_for_street.setAttribute("placeholder","Улица");
            <%if(!dealer.getAddress().getStreet().isEmpty()){%>
            field_for_street.setAttribute("value",<%=dealer.getAddress().getStreet()+" "%>);
<%}%>
            var field_for_numberHouse=document.createElement("input");
            field_for_numberHouse.setAttribute("type","text");
            field_for_numberHouse.setAttribute("placeholder","Номер дома");
            <%if(!dealer.getAddress().getNumberHouse().isEmpty()){%>
            field_for_numberHouse.setAttribute("value",<%=dealer.getAddress().getNumberHouse()%>);
            <%}%>

            var submit_button=document.createElement("button");
            submit_button.setAttribute("type","submit");
            var button_text = document.createTextNode("Сохранить");
            submit_button.appendChild(button_text);
            form.appendChild(city);
            form.appendChild(document.createElement("br"));
            form.appendChild(field_for_index);
            form.appendChild(document.createElement("br"));
            form.appendChild(field_for_street);
            form.appendChild(document.createElement("br"));
            form.appendChild(field_for_numberHouse);
            form.appendChild(document.createElement("br"));
            form.appendChild(submit_button);
            dealer_data.appendChild(form);
            dealer_data.removeChild(document.getElementById("address_button"));
        }
        function changeContactPersonsData(id){
            var contact_person_data=document.getElementById("contact_persons_data".concat(id));
            var old_manager=document.getElementById("manager".concat(id));
            var old_phone=document.getElementById("phone".concat(id));
            var old_email=document.getElementById("email".concat(id));

            var manager=document.createElement("input");
            manager.setAttribute("type","text");
            manager.setAttribute("placeholder","Имя менеджера");
            manager.setAttribute("value",old_manager.innerHTML);
            manager.setAttribute("name","manager");



            var phone=document.createElement("input");
            phone.setAttribute("type","text");
            phone.setAttribute("placeholder","телефон");
            phone.setAttribute("value",old_phone.innerHTML);
            phone.setAttribute("name","phone");

            var email=document.createElement("input");
            email.setAttribute("type","email");
            email.setAttribute("placeholder","Электронный адресс");
            email.setAttribute("value",old_email.innerHTML);
            email.setAttribute("name","email");


            var submit_button=document.createElement("button");
            submit_button.setAttribute("type","submit");
            var button_text = document.createTextNode("Сохранить");
            submit_button.appendChild(button_text);

            contact_person_data.replaceChild(manager,old_manager);
            contact_person_data.replaceChild(phone,old_phone);
            contact_person_data.replaceChild(email,old_email);
            contact_person_data.appendChild(submit_button);
        }
    </script>

<div class="diller-info" >
Диллер: <span class="diller-info-data"><%=dealer.getNameDealer()%> </span><br>
    <div id="dealer_data">
Адресс: <span id ="address" class="diller-info-data"><%=dealer.getAddress().getIndex()+" "%>  <%=dealer.getAddress().getCity()%>
        , ул.

    <%=dealer.getAddress().getStreet()+" "%> <%=dealer.getAddress().getNumberHouse()%></span>
    <a id="address_button" href="#" class="more" title="Изменить" onclick="changeAddress()">Изменить</a>
    </div>
    <h4>Контактные лица</h4>
    <%
        int count=0;
        for (Contact_person contact_person:dealer.getContact_persons()){%>
    <form action="/change_contact_person" method="post">
    <div id="contact_persons_data<%=count%>">
             <input type="hidden" name="id" value="<%=count%>">
    Менеджер:<span id="manager<%=count%>" class="diller-info-data"><%=contact_person.getName()%></span><br>
    Телефон: <span id="phone<%=count%>" class="diller-info-data"><%=contact_person.getPhone()%></span><br>
    Email:   <span id="email<%=count%>" class="diller-info-data"><%=contact_person.getEmail()%></span><br>

    </div>
    </form>
    <a id="contact_persons_button" class="more" href="#" title="Изменить" onclick="changeContactPersonsData(<%=count%>)">Изменить</a>
    <%if(count>0){%>
    <a  href="/delete_contact_person?count=<%=count%>" class="more" title="Удалить" >Удалить</a>
    <%}
            count++;
        }%>

</div>
<br/>
<!-- <div class="info">
<div class="town">Город:<br> Харьков</div>
<div class="phone-number">Телефон:<br> +38 057 705 20 25</div>
<div class="diller">Дилер:<br> ТОВ "Автодом Харків"</div> 

</div> -->
<br/>
<ul id="menu-diller">
  <li><a href="">Изменить инфо</a></li>
  <li><a href="/addCar">Добавить авто</a></li>
  <li><a href="#" id="go">Добавить контактное лицо</a></li>
  <li><a href="">какая нибуть ссылка</a></li>
</ul>  
</div>
<h3>Мои автомобили:</h3>

    <% if(cars!=null){
        for (Car car:cars){
        String path;
        if(car.getPhotoPath().get(0).equals("null")) {
            path="/res/img/notAvailable.png";
        }
        else {
            path = "/getPhoto?pathPhoto="+car.getPhotoPath().get(0)+"&Width=200&Height=200";

        }
        String EnginesType="нет данных";
        String transmission ="нет данных";
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

    %>
<div class="auto">
<div class="model">
    <a title=<%=car.getBrand()+" "%><%=car.getModel()%> href="/carPage?idCar=<%=car.getIdCar()%>" >
        <%=car.getBrand()+" "%><%=car.getModel()%>
    </a></div>

<div class= "foto-185x120">
    <a title= <%=car.getBrand()+" "%><%=car.getModel()%> href="/carPage?idCar=<%=car.getIdCar()%>" class= "foto-185x120" >
        <img src="<%=path%>" align="left">
    </a>
</div>


    <div class="model-info">
        Цена: <span class="model-info-data"><%=car.getPrise()%>$</span><br>
        Год: <span class="model-info-data"><%=car.getYearMade()%></span><br>
        Пробег: <span class="model-info-data"><%=car.getMileage()%>км</span><br>
        Двигатель: <span class="model-info-data"><%=car.getEngineCapacity()%></span><br>
        Топливо: <span class="model-info-data"><%=EnginesType%></span><br>
        КП: <span class="model-info-data"><%=transmission%></span><br>
    </div>
<br/>

    <a title="Подробнее" href="/carPage?idCar=<%=car.getIdCar()%>" class="more">
        Подробнее...
    </a>
</div>
    <%}
        }%>

</div>


</div>

<footer>Подвал </footer>


<!-- Модальное окно -->
<div id="modal_form">
    <span id="modal_close">X</span>
    <form action="/add_contact_person" method="post">
        <h3>Введите пожалуйста данные</h3>
        <p>Имя менеджера<br />
            <input  type="text" name="manager" value="" size="40" />
        </p>
        <p>Телефон<br />
            <input type="text" name="phone" value="" size="40" />
        </p>
        <p>Электронный адресс<br />
            <input type="email" name="email" size="40" />
        </p>
        <p style="text-align: center; padding-bottom: 10px;">
            <input type="submit" value="Записать" />
        </p>

    </form>
</div>
<div id="overlay"></div>



</body>
</html>
