<%@ page import="com.setting.Setting" %>
<%--
  Created by IntelliJ IDEA.
  User: Эдуард
  Date: 07.11.15
  Time: 23:55
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <link rel="shortcut icon" href="/res/img/favicon.ico"/>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <link rel="stylesheet" type="text/css" href="/res/css/style_my_acount.css">
  <!-- <link href='https://fonts.googleapis.com/css?family=Shadows+Into+Light' rel='stylesheet' type='text/css'> -->
  <title> Автомобили с пробегом </title>
</head>

<body>
<header>
  <h1><a class="header"title="На главную" href=""><%=Setting.getProjectName()%></a></h1>
  <h2>Автомобили с пробегом <br>
    <Small>Только официальные дилеры</Small></h2>
  <!-- <h5>Результаты поиска: </h5><br>  -->
</header>
<ul id="menu">
  <li><a title="На главную" href="/">На главную</a></li>
  <li><a href="/about_us" >О нас</a></li>
  <!-- <li><a title="Мои автомобили" href="">Мои автомобили</a></li> -->
  <!-- <li><a title="Добавить авто" href="">+ Добавить авто</a></li> -->
  <li><a title="Выход"  href="registration" method="get">Регистация</a></li>
</ul>


<div id="layout">

  <div id="result">
    <div class="auto">



      <div class="diller-info">
        <p><h1>${msg}</h1>
        <%--${file}--%>
        </p>
      </div>

    </div>
  </div>
</div>


</body>
</html>

