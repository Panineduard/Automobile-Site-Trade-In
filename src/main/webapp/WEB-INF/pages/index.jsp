<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="com.modelClass.Car" %>
<%@ page import="java.util.List" %>
<%@ page import="org.springframework.ui.ModelMap" %>
<%@ page import="com.helpers.SearchOptions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Эдуард
  Date: 03.01.16
  Time: 23:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <style></style>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <link rel="stylesheet" type="text/css" href="/res/css/style1.css">
  <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
  <script type="text/javascript" src="/res/js/get_model_by_brand.js"></script>
<script>
  function getSearchOptions(){
    $.get( "/getSearchOptions", { model: e})
            .done(function( data ) {

//                alert(data.length);
//                alert( "Data Loaded: " + data[1] );
              for(var i=0;i<data.length;i++){
                var model=document.getElementById("id_model");

                var manager=document.createElement("OPTION");
                if(i===0){
                  manager.setAttribute("value",'');
                }
                else{
                  manager.setAttribute("value",data[i]);
                }

                manager.innerHTML=data[i];
                model.appendChild(manager);
//                  alert("привет");
//
              }
            });

  }


</script>
  <title> Автомобили с прбегом </title>
</head>
<body>
<header>
  <h1>NAME OF OUR PROJECT</h1>
  <h2>Автомобили с пробегом <br>
    <Small>Только официальные дилеры</Small></h2>
  <!-- <h5>Результаты поиска: </h5><br>  -->
</header>

<ul id="menu">
  <%
    List<Car> cars=null;
    SearchOptions options =(SearchOptions)request.getSession().getAttribute("options");
    boolean optionPresent=false;
    int numberPage=1;
    long countButtons=0L;
    if (session.getAttribute("page")!=null) {
      numberPage = (Integer) session.getAttribute("page");
    }
    if(request.getSession().getAttribute("cars")!=null){
      cars=(List<Car>)request.getSession().getAttribute("cars");
    }
    if(request.getSession().getAttribute("pages")!=null){
      countButtons=(Long)request.getSession().getAttribute("pages");
    }
    if(options!=null){

        optionPresent=true;

    }
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String idDealer = auth.getName();
    if(idDealer!="anonymousUser"){%>
  <li><a href="/myAccount">Мои автомобили</a></li>
  <c:url var="logoutAction" value="/j_spring_security_logout"></c:url>
  <li><a  href= "${logoutAction}">Выход</a></li>
  <%
  }
  else {
  %>
  <li><a  href="/myAccount">Войти</a></li>
  <%
    }
  %>
  <% if(idDealer=="anonymousUser"){%>
  <li><a href="registration" method="get">Регистрация</a></li>
  <%}else{ %>
  <li><a href="/feedback">Обратная связь</a></li>
  <% } %>
  <li><a href="#home">На главную</a></li>
</ul>
<h5>Недавно добавлены: </h5>

 <h5>Сортировка:</h5>
 <a href="/ascending_price">По возрастанию цены</a>
 <a href="/by_prices_descending">По убыванию цены</a>
<%--<h5>Результаты поиска: </h5>--%>
<div id="layout">
  <div id="baner-left">
    <form action="/lookForCars" method="post">
      <div id="search">
        <p>МАРКА<br>
          <select id="id_make1" class="form-control" name="make" onchange="p_delete(this.value);">
            <%if(optionPresent){%>
            <option value="<%=options.getMake()%>" ><%=options.getMake()%></option>
            <%}else {%>
            <option value="" selected="selected">вcе марки</option>
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
</p>
        <p>МОДЕЛЬ<br>
          <select id="id_model" name="model">
            <%if(optionPresent){%>
            <option value="<%=options.getModel()%>" ><%=options.getModel()%></option>
            <%}else {%>
            <option value="" selected="selected">выберите марку</option>
            <%}%>
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
            <%if(optionPresent){%>
            <option value="<%=options.getYear_from()%>"><%=options.getYear_from()%></option>
            <option value="" >все</option>
            <%}else {%>
            <option value="" selected="selected">c</option><%}%>
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
            <%if(optionPresent){%>
            <option value="<%=options.getYear_to()%>"><%=options.getYear_to()%></option>
            <option value="" >все</option>
            <%}else {%>
            <option value="" >по</option>
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

          </select></p>
        <p>ТИП ДВИГАТЕЛЯ</br>
          <select id="id_engine" class="form-control" name="engine">
            <option value="">все</option>
            <option value="Бензин">Бензин</option>
            <option value="disel">Дизель</option>
            <option value="elektro">Электро</option>
            <option value="hybrid">Гибрид</option>
            <option value="gas">Газ/бензин</option>
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

      <%
        if(cars!=null){

            if(cars.size()==0){
            %>
          <h1>По Вашему запросу ничего не найдено</h1>
            <%
              }

          else {
        for (Car car:cars){

          String path;
            if(car.getPhotoPath().size()==0) {
              path="/res/img/notAvailable.png";
            }
            else {
              path = "/getPhoto?pathPhoto="+car.getPhotoPath().get(0)+"&Width=185&Height=120";

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
          } else if (car.getEnginesType().equals("gas")){
            EnginesType = "Газ/бензин";
          }
          if (car.getTransmission().equals("auto")) {
            transmission = "Автомат";
          } else if (car.getTransmission().equals("mechanical")) {
            transmission = "Механическая";
          }
//          String path="/res/img/notAvailable.png";
//          if(car.getPhotoPath().get(0)!=null){
//            path = "/getPhoto?pathPhoto="+car.getPhotoPath().get(0);
//          }
      %>
      <div class="auto">
        <div class="model">
      <a title=<%=car.getBrand()+" "%><%=car.getModel()%> href="/carPage?idCar=<%=car.getIdCar()%>" >
        <%=car.getBrand()+" "%><%=car.getModel()%>
      </a>
        </div>

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
    }
    }%>


  </div>
<%


  int numberFirstPage=1;

    if(numberPage>7)numberFirstPage=numberPage-6;

  request.getSession().setAttribute("parameter",request.getParameterMap());

%>
  <div class="page">
    <ul class="pagination">
      <%if(numberPage>7){%>
      <li><a href="/replacing_the_page_number?page=<%=numberPage-1%>" >«</a></li>
      <%}%>
      <%int maxCount=0;
        for (int i=numberFirstPage;i<=countButtons;i++){
      if(maxCount>=7)break;
      %>
      <li><a
              <%if (i==numberPage){%>class="active"<%}%>
              href="/replacing_the_page_number?page=<%=i%>"><%=i%></a></li>
      <%
          maxCount++;
        }
      if(countButtons>7){%>
      <li><a  href="/replacing_the_page_number?page=<%=numberPage+1%>">»</a></li>
      <%}%>
    </ul>
  </div>

</div>

<footer>Подвал </footer>



</body>
</html>

