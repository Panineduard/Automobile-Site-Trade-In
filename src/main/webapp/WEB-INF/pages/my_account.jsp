<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.modelClass.Dealer" %>
<%@ page import="com.modelClass.Car" %>
<%@ page import="java.util.List" %>
<%@ page import="com.modelClass.Contact_person" %>
<%@ page import="com.helpers.EncoderId" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.Instant" %>
<%@ page import="java.time.ZoneId" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="/res/css/style_my_acount.css">
<link rel="stylesheet" type="text/css" href="/res/css/modal_window.css">


<title> Автомобили с пробегом </title>
    <%--<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>--%>
    <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="/res/js/get_model_by_brand.js"></script>
    <script type="text/javascript" src="/res/js/modal_window.js"></script>


</head>

<body>
<header>
<h1><a class="header"title="На главную" href="">NAME OF OUR PROJECT</a></h1>
<h2>Автомобили с пробегом <br>
<Small>Только официальные дилеры</Small></h2>
    <h2>${msg}</h2>
<!-- <h5>Результаты поиска: </h5><br>  -->
</header>
<ul id="menu">
  <li><a title="На главную" href="/">На главную</a></li>
    <li><a href="/feedback">Обратная связь</a></li>
  <%--<li><a title="Мои автомобили" href="">Мои автомобили</a></li>--%>
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
                <select id="id_make1" class="form-control" name="make" onchange="p_delete(this.value);">
                    <option value="" selected="selected">вcе марки</option>
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
            </p>
            <p>МОДЕЛЬ<br>
                <select id="id_model" name="model">
                    <option value="" selected="selected">выберите марку</option>
                </select></p>
            <p>ЦЕНА<br>
                <input id="id_price_from" type="text" placeholder="от" class="form-control" name="price_from" />
                <input id="id_price_to" type="text" placeholder="до" class="form-control" name="price_to" />
            </p>
            <p>ГОД ВЫПУСКА<br>
                <select id="id_year_from" class="form-control" name="year_from">
                    <option value="" selected="selected">c</option>
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

                </select>

                <select id="id_year_to" class="form-control" name="year_to">
                    <option value="" selected="selected">по</option>
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

                </select></p>
            <p>ТИП ДВИГАТЕЛЯ</br>
                <select id="id_engine" class="form-control" name="engine">
                    <option value="">все</option>
                    <option value="gasoline">Бензин</option>
                    <option value="disel">Дизель</option>
                    <option value="elektro">Электро</option>
                    <option value="hybrid">Гибрид</option>
                    <option value="other">Другое</option>
                </select></p>
            ТИП КПП<br>
            <select id="id_gearbox" class="form-control" name="gearbox">
                <option value="">все</option>
                <option value="another" >Другое</option>
                <option value="auto">Автоматическая</option>
                <option value="mechanical">Механическая</option>
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
    </form></div>
<div id="baner-right">
some baner rightiygvbbuuuuuuuu uuuuuuuuuuuu uuuuuu uuuuuuuuuuu uuuuu uuuuuuu7 777777777777 77777 77777777 77777777 7777777 7777777
</div>

<div id="result">
<h3>Мое меню:</h3>
<div class="auto">

    <script type="text/javascript">
                $(document).ready(function() {

                    $('a#address_button').click( function(event){
                        var address=document.getElementById("address");
                        var dealer_data=document.getElementById("dealer_data");
                        dealer_data.removeChild(address);
                        var form=document.createElement("form");
                        form.setAttribute("action","/myAccount/changeAddress");
                        form.setAttribute("method","post");

                        var city=document.createElement("span");
                        <%if(!dealer.getAddress().getCity().isEmpty()){%>
                        var node = document.createTextNode("<%=dealer.getAddress().getCity() %>");
                        city.appendChild(node);
                        <%}%>


                        var field_for_index=document.createElement("input");
                        field_for_index.setAttribute("type","text");
                        field_for_index.setAttribute("placeholder","Индекс");
                        field_for_index.setAttribute("name","index");
                        <%if(dealer.getAddress().getIndex()!=null){%>
                        field_for_index.setAttribute("value","<%=dealer.getAddress().getIndex() %>");
                        <%}%>
                        var field_for_street=document.createElement("input");
                        field_for_street.setAttribute("type","text");
                        field_for_street.setAttribute("placeholder","Улица");
                        field_for_street.setAttribute("name","street");
                        <%if(dealer.getAddress().getStreet()!=null){%>
                        field_for_street.setAttribute("value","<%=dealer.getAddress().getStreet()%>");
                        <%}%>
                        var field_for_numberHouse=document.createElement("input");
                        field_for_numberHouse.setAttribute("type","text");
                        field_for_numberHouse.setAttribute("placeholder","Номер дома");
                        field_for_numberHouse.setAttribute("name","house_number");
                        <%if(dealer.getAddress().getNumberHouse()!=null){%>
                        field_for_numberHouse.setAttribute("value","<%=dealer.getAddress().getNumberHouse()%>");
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

                    });
                });


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
    <a id="address_button" href="#" class="more" title="Изменить" >Изменить</a>
    </div>
    <h4>Контактные лица</h4>
    <%
        Integer count=0;
        for (Contact_person contact_person:dealer.getContact_persons()){%>
    <form action="/myAccount/change_contact_person" method="post">
    <div id="contact_persons_data<%=count%>">
             <input type="hidden" name="id" value="<%=count%>">
    Менеджер:<span id="manager<%=count%>" class="diller-info-data"><%=contact_person.getName()%></span><br>
    Телефон: <span id="phone<%=count%>" class="diller-info-data"><%=contact_person.getPhone()%></span><br>
    Email:   <span id="email<%=count%>" class="diller-info-data"><%=contact_person.getEmail()%></span><br>

    </div>
    </form>
    <a id="contact_persons_button" class="more" href="#" title="Изменить" onclick="changeContactPersonsData(<%=count%>)">Изменить</a>
    <%if(count>0){%>
    <a  href="/myAccount/delete_contact_person?count=<%=EncoderId.encodId(count.toString())%>" class="more" title="Удалить" >Удалить</a>
    <%}
            count++;
        }%>

</div>
<br/>

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
    <a id="car_change_button" href="/myAccount/change_car?car=<%=EncoderId.encodId(car.getIdCar().toString())%>" class="more" title="Изменить" >Изменить</a>
    <a id="car_delete_button" href="/myAccount/delete_car?car=<%=EncoderId.encodId(car.getIdCar().toString())%>" class="more" title="Удалить" >Удалить</a>
    <%if(LocalDateTime.ofInstant(Instant.ofEpochMilli(car.getDateProvide().getTime()), ZoneId.systemDefault())
            .isBefore(LocalDateTime.now().minusMonths(1))){
    %>
    <a id="car_change_button" href="/myAccount/update_car?car=<%=EncoderId.encodId(car.getIdCar().toString())%>" class="more" title="Обновить" >Обновить</a>
    <%}%>
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
    <form action="/myAccount/change_contact_person" method="post">
        <h3>Введите пожалуйста данные</h3>
         <input type="hidden" name="id" value="">
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
