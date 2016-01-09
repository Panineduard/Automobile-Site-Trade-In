<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="com.modelClass.Car" %>
<%@ page import="java.util.List" %>
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
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <link rel="stylesheet" type="text/css" href="/res/css/style1.css">
  <script type="text/javascript" src="/res/js/linkedselect.js"></script>

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

<h5>Результаты поиска: </h5>
<div id="layout">
  <div id="baner-left">
    <form action="/lookForCars" method="post">
      <div id="search">
        <p>МАРКА<br>
          <select id="id_make1" class="form-control" name="make">
            <option value="" selected="selected">вcе марки</option>
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

            <option value="1639"class="cat-top">Daewoo </option>
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
            <option value="1872"class="cat-top">Mazda </option>
            <option value="1121"class="cat-top">Mercedes</option>
            <%--<option value="2977">MG (73)</option>--%>
            <%--<option value="148">MINI (56)</option>--%>
            <option value="1094"class="cat-top">Mitsubishi </option>
            <option value="1522"class="cat-top">Nissan </option>
            <option value="1374"class="cat-top">Opel </option>
            <option value="1032"class="cat-top">Peugeot</option>
            <option value="398">Porsche</option>
            <option value="1826"class="cat-top">Renault</option>
            <%--<option value="243">Rolls Royce (16)</option>--%>
            <%--<option value="447">Rover (97)</option>--%>
            <%--<option value="980">Saab (51)</option>--%>
            <%--<option value="43">Samand (62)</option>--%>
            <%--<option value="138">Samsung (8)</option>--%>
            <option value="1058">Seat (458)</option>
            <option value="1081"class="cat-top">Skoda</option>
            <%--<option value="3000">SMA (11)</option>--%>
            <%--<option value="2974">Smart (312)</option>--%>
            <%--<option value="680"class="cat-top">SsangYong (734)</option>--%>
            <option value="519"class="cat-top">Subaru</option>
            <option value="431"class="cat-top">Suzuki</option>

            <%--<option value="2001">Tesla (7)</option>--%>
            <option value="1594"class="cat-top">Toyota</option>

            <option value="volkswagen"class="cat-top">Volkswagen </option>
            <option value="1479"class="cat-top">Volvo </option>

            <%--<option value="180">Богдан (102)</option>--%>
            <option value="1659"class="cat-top">ВАЗ </option>
            <option value="1799"class="cat-top">ГАЗ </option>
            <option value="576"class="cat-top">ЗАЗ </option>

            <%--<option value="634"class="cat-top">Москвич (843)</option>--%>
            <%--<option value="7183">СМЗ (7)</option>--%>
            <%--<option value="1782">УАЗ (411)</option>--%>
          </select>
</p>
        <p>МОДЕЛЬ<br>
          <select id="id_model1" class="form-control" name="model">
            <option value="" selected="selected">укажите марку</option>
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
    </form>
  </div>
  <div id="baner-right">
    some baner rightiygvbbuuuuuuuu uuuuuuuuuuuu uuuuuu uuuuuuuuuuu uuuuu uuuuuuu7 777777777777 77777 77777777 77777777 7777777 7777777
  </div>

  <div id="result">

      <%
        if(request.getAttribute("cars")!=null){
        List<Car> cars= (List<Car>) request.getAttribute("cars");
        for (Car car:cars){
          String path=car.getPhotoPath().get(0);
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

      <a title="Vokswagen Passat B8"href="http" class= "model" >
        <%=car.getBrand()+" "%><%=car.getModel()%>
      </a>
      <!--<a title="Подробнее"href="http" class="more">
      Подробнее
      </a> --->
    <div id="auto">

      <a title="Vokswagen Passat B8" href="/carPage?idCar=<%=car.getIdCar()%>" class= "foto-185x120" >
        <img src="/getPhoto?pathPhoto=<%=path%>" align="left">
      </a>

      <br>
      <div class="model-info">
        Цена: <%=car.getPrise()%>$<br>
        Год: <%=car.getYearMade()%> <br>
        Пробег: <%=car.getMileage()%>км<br>
        Двигатель: <%=car.getEngineCapacity()%><br>
        Топливо: <%=EnginesType%><br>
        КП: <%=transmission%>
      </div>
      <br/>

      <div class="info">
        <div class="town">Город:<br> < src="/getDealer"></src> </div>
        <div class="phone-number">Телефон:<br> +38 057 705 20 25</div>
        <div class="diller">Дилер:<br> ТОВ "Автодом Харків"</div>

      </div>
      <br/>
      <a title="Подробнее"href="http" class="more">
        Подробнее
      </a>
    </div>

    <%}
    }%>


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
      '': 'Вы не выбрали марку'

    },

    'volkswagen': {
      '':'Все модели',
      'passat': 'Passat',
      'jeta': 'Jeta'

    }


  };

  // Включаем синхронизацию связанных списков
  syncList1.sync("id_make1", "id_model1");
</script>


</body>
</html>

