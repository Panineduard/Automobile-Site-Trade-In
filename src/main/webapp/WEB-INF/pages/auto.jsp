<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.modelClass.Car" %>
<%@ page import="com.modelClass.Dealer" %>
<%@ page import="com.modelClass.Contact_person" %>
<%@ page import="com.modelClass.ListRole" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

  <script language = "JavaScript">
    function setBigImageSlide(group) {
      var images = document.getElementById(group).src;
      var image = document.getElementById("bigimgslide").src=images;
    }
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
  <li><a title="К результатам" href="/">Вернуться к результатам поиска</a></li>
  <%if (request.isUserInRole("ROLE_USER")){%>
  <li><a title="Мои автомобили" href="/myAccount">Мои автомобили</a></li>
  <c:url var="logoutAction" value="/j_spring_security_logout"></c:url>
  <li><a title="Выход" href= "${logoutAction}">Выход</a></li>
  <li><a title="Обратная связь" href="/feedback">Обратная связь</a></li>
  <%}%>
</ul>  
<div id="layout">
<div id="baner-left">
jgjj kjkjkjb kbkjbkjb
</div>
<div id="baner-right">
some baner rightiygvbbuuuuuuuu uuuuuuuuuuuu uuuuuu uuuuuuuuuuu uuuuu uuuuuuu7 777777777777 77777 77777777 77777777 7777777 7777777
</div>
<!-- <div id="baner-right">
some baner rightiygvbbuuuuuuuu uuuuuuuuuuuu uuuuuu uuuuuuuuuuu uuuuu uuuuuuu7 777777777777 77777 77777777 77777777 7777777 7777777
</div> -->

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


<div class ="main-foto">


  <div id="panes">
  <a title="Vokswagen Passat B8"href="http"  >
<img  id='bigimgslide' class="foto-380x250" src="/getPhoto?pathPhoto=<%=car.getPhotoPath().get(0)%>" align="left">
  </a>
  </div>
  <%
    int idPhoto=0;
    for (String photo:car.getPhotoPath()) {
  %>
<div class="small-foto">

  <a title="Vokswagen Passat B8"  >
<img  id=<%=idPhoto%>  class="foto-85x56" onclick='setBigImageSlide(<%=idPhoto%>)'  src="/getPhoto?pathPhoto=<%=photo%>" align="left" alt="">
</a>

</div>
  <%
      idPhoto++;
    }%>

</div>




<div class="model-info">
Цена: <span class="model-info-data"><%=car.getPrise()%>$</span><br>
Год: <span class="model-info-data"><%=car.getYearMade()%></span><br>
Пробег: <span class="model-info-data"><%=car.getMileage()%>км</span><br>
Двигатель: <span class="model-info-data"><%=car.getEngineCapacity()%></span><br>
Топливо: <span class="model-info-data"><%=EnginesType%></span><br>
КП: <span class="model-info-data"><%=transmission%></span><br>
Комплектация: <span class="model-info-data">Comfortline</span><br>
Дополнительно: <br><span class="model-info-data-coment">
<%=car.getDescription()%>
</span>
</div>



<div class="info">
<div class="town"><u>Город:</u><br> <span class="info-data"><%=dealer.getDateRegistration()%></span></div>
<div class="phone-number"><u>Телефон:</u><br> <span class="info-data">
  <%for (Contact_person contact_person:dealer.getContact_persons()){%>
<%=contact_person.getPhone()%> <br>
<%}%>
</span></div>
<div class="diller"><u>Дилер:</u><br> <a title="Диллер" href="  "><span class="info-data"><%=dealer.getNameDealer()%></span></a></div>

</div>

<!-- <a title="Подробнее"href="http" class="more"> 
Подробнее 
</a> -->
</div>
</div>



</div>

<footer>Подвал </footer>
</body>
</html>

