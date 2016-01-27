<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.modelClass.Dealer" %>
<%@ page import="com.modelClass.Car" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <%--<script src="/res/js/jquery.tools.min.js"></script>--%>
  <script>
    $(function () {
      $("#prod_nav ul").tabs("#panes > div", {
        effect: 'fade',
        fadeOutSpeed: 400
      });
    });
  </script>

  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <link rel="stylesheet" type="text/css" href="/res/css/style_auto.css">
  <!-- <link href='https://fonts.googleapis.com/css?family=Shadows+Into+Light' rel='stylesheet' type='text/css'> -->
  <title> Автомобили с пробегом </title>
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
  <li><a title="К результатам" href="">Вернуться к результатам поиска</a></li>
  <li><a title="Выход"  href="">Выход</a></li>
</ul>
<div id="layout">
  <div id="baner-left">
    jgjj kjkjkjb kbkjbkjb
  </div>
  <div id="baner-right">
    some baner rightiygvbbuuuuuuuu uuuuuuuuuuuu uuuuuu uuuuuuuuuuu uuuuu uuuuuuu7 777777777777 77777 77777777 77777777 7777777 7777777
  </div>
    <%
    Dealer dealer = (Dealer)request.getAttribute("dealer");
    Car car= (Car) request.getAttribute("car");


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

  <div id="result">
    <div class="auto">
  <div class= "model" >
    <%=car.getBrand()%>  <%=car.getModel()%>
  </div>
  <hr>

    <div id="panes" class ="main-foto">
      <%
        for (String photo:car.getPhotoPath()) {
      %>
      <div><img  class="foto-380x250" align="left" src="/getPhoto?pathPhoto=<%=photo%> ">
    </div>
      <%}%>
    </div>
    <!-- END tab panes -->
    <br clear="all">
    <!-- navigator -->
    <div id="prod_nav" class="small-foto">
      <ul>
        <%
          for (String photo1:car.getPhotoPath()) {
        %>
        <li><a title="Vokswagen Passat B8"  href="#1"><img  class="foto-85x56" src="/getPhoto?pathPhoto=<%=photo1%>" align="left" alt=""> </a></li>
        <%}%>

      </ul>

    </div>

</div>
  </div>
</body>
</html>


