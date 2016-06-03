<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.modelClass.Dealer" %>
<%@ page import="com.modelClass.Car" %>
<%@ page import="java.util.List" %>
<%@ page import="com.modelClass.Contact_person" %>
<%@ page import="com.helpers.EncoderId" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.Instant" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="com.helpers.SearchOptions" %>
<%@ page import="com.setting.Setting" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="/res/css/style_my_acount.css">
<link rel="stylesheet" type="text/css" href="/res/css/modal_window.css">
    <link rel="shortcut icon" href="/res/img/favicon.ico"/>

<title> Автомобили с пробегом </title>
    <script>
        var engine_parameter=['все','Бензин','Дизель','Электро','Гибрид','Газ/бензин','Другое'];
        var gearbox_parameter=['все','Другое','Автоматическая','Механическая'];
    </script>
    <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="/res/js/get_model_by_brand.js"></script>
    <script type="text/javascript" src="/res/js/write_parameters_with_search_parameters.js" charset="utf-8"></script>
    <script type="text/javascript" src="/res/js/modal_window.js"></script>

</head>

<body>
<header>
<h1><a class="header"title="На главную" href=""><%=Setting.getProjectName()%></a></h1>
<h2>Автомобили с пробегом <br>
<Small>Только официальные дилеры</Small></h2>
    <h2>${msg}</h2>
<!-- <h5>Результаты поиска: </h5><br>  -->
</header>
<ul id="menu">
  <li><a title="На главную" href="/">На главную</a></li>

    <li><a href="/feedback">Обратная связь</a></li>
    <li><a href="/about_us" >О нас</a></li>
  <%--<li><a title="Мои автомобили" href="">Мои автомобили</a></li>--%>
  <li><a title="Добавить авто" href="/addCar">Добавить авто</a></li>
    <c:url var="logoutAction" value="/j_spring_security_logout"></c:url>

    <li><a title="Выход"  href="${logoutAction}">Выход</a></li>
</ul>
<%
    SearchOptions options =(SearchOptions)request.getSession().getAttribute("options");
    boolean optionPresent=false;
    Dealer dealer = (Dealer)request.getAttribute("dealer");
    List<Car> cars= (List<Car>) request.getAttribute("cars");
    if(options!=null){
        optionPresent=true;
    }
%>

<div id="layout">
<div id="baner-left">
    <form action="/lookForCars" method="post">
        <div id="search">
            <p>МАРКА<br>
                <select id="id_make" class="form-control" name="make" onchange="p_delete(this.value,' ');">
                    <option value = "" >вcе марки</option>
                </select>
            </p>
            <p>МОДЕЛЬ<br>
                <select id="id_model" name="model">
                    <option value="" selected="selected">выберите марку</option>
                </select></p>
            <p>ЦЕНА<br>
                <%if(optionPresent){%>
                <input id="id_price_from" type="text" placeholder="от" value="<%=options.getPrice_from()%>" class="form-control" name="price_from" />
                <input id="id_price_to" type="text" placeholder="до" value="<%=options.getPrice_to()%>" class="form-control" name="price_to" />
                <%}
                else {%>
                <input id="id_price_from" type="text" placeholder="от" class="form-control" name="price_from" />
                <input id="id_price_to" type="text" placeholder="до" class="form-control" name="price_to" />
                <%}%>

            </p>
            <p>ГОД ВЫПУСКА<br>
                <select id="id_year_from" class="form-control" name="year_from">
                    <option value="" >c</option>
                </select>
                <select id="id_year_to" class="form-control" name="year_to">
                    <option value="" >по</option>
                </select></p>
            <p>ТИП ДВИГАТЕЛЯ<br>
                <select id="id_engine" class="form-control" name="engine"></select>
            </p>
            <p>ТИП КПП<br>
            <select id="id_gearbox" class="form-control" name="gearbox"></select>
            </p>
            <p>РЕГИОН<br>
                <select id="id_region"  class="form-control" name="region">
                    <option value = "" >вcе регионы</option>
                </select>
            </p>
            <button type="submit" class="btn btn-primary btn-lg ">Подобрать авто</button>
            <a href="/resetSearchOptions"><button type="button" class="btn btn-primary btn-lg">Сбросить</button></a>
        </div>
    </form></div>
<%--<div id="baner-right">--%>
<%--some baner rightiygvbbuuuuuuuu uuuuuuuuuuuu uuuuuu uuuuuuuuuuu uuuuu uuuuuuu7 777777777777 77777 77777777 77777777 7777777 7777777--%>
<%--</div>--%>

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
        EncoderId encoderId=new EncoderId();
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
    <a  href="/myAccount/delete_contact_person?count=<%=encoderId.encodId(count.toString())%>" class="more" title="Удалить" >Удалить</a>
    <%}
            count++;
        }%>

</div>
<br/>

<br/>
<ul id="menu-diller">
  <li><a href="/addCar">Добавить авто</a></li>
  <li><a href="" id="go">Добавить контактное лицо</a></li>
</ul>
</div>
<h3>Мои автомобили:</h3>

    <% if(cars!=null){
        for (Car car:cars){
        String path;
        if(car.getPhotoPath().size()==0) {
            path="/res/img/notAvailable.png";
        }
        else {
            path = "/getPhoto?pathPhoto="+car.getPhotoPath().get(0)+"&percentage_of_reduction=30";
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
    <a title=<%=car.getBrand()+" "%><%=car.getModel()%> href="/carPage?idCar=<%=encoderId.encodId(car.getIdCar().toString())%>" >
        <%=car.getBrand()+" "%><%=car.getModel()%>
    </a></div>

<div class= "foto-185x120">
    <a title= <%=car.getBrand()+" "%><%=car.getModel()%> href="/carPage?idCar=<%=encoderId.encodId(car.getIdCar().toString())%>" class= "foto-185x120" >
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
        Просмотры: <span class="model-info-data"><%=car.getViews()%></span><br>
    </div>
<br/>
    <a id="car_change_button" href="/myAccount/change_car?car=<%=encoderId.encodId(car.getIdCar().toString())%>" class="more" title="Изменить" >Изменить</a>
    <a id="car_delete_button" href="/myAccount/delete_car?car=<%=encoderId.encodId(car.getIdCar().toString())%>" class="more" title="Удалить" >Удалить</a>
    <%if(LocalDateTime.ofInstant(Instant.ofEpochMilli(car.getDateProvide().getTime()), ZoneId.systemDefault())
            .isBefore(LocalDateTime.now().minusMonths(1))){
    %>
    <a id="car_change_button" href="/myAccount/update_car?car=<%=encoderId.encodId(car.getIdCar().toString())%>" class="more" title="Обновить" >Обновить</a>
    <%}%>
    <a title="Подробнее" href="/carPage?idCar=<%=encoderId.encodId(car.getIdCar().toString())%>" class="more">
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
