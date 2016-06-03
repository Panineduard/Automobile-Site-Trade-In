<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="com.modelClass.Car" %>
<%@ page import="java.util.List" %>
<%@ page import="org.springframework.ui.ModelMap" %>
<%@ page import="com.helpers.SearchOptions" %>
<%@ page import="com.helpers.EncoderId" %>
<%@ page import="com.setting.Setting" %>
<%@ page import="com.servise.StandartMasege" %>
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
  <link rel="stylesheet" type="text/css" href="<%=Setting.getPath()%>/res/css/style1.css">
  <link rel="stylesheet" type="text/css" href="<%=Setting.getPath()%>/res/css/modal_window.css">
  <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
  <script type="text/javascript" src="<%=Setting.getPath()%>/res/js/modal_window.js"></script>

  <link rel="shortcut icon" href="/res/img/favicon.ico"/>
  <script type="text/javascript">
    $(document).ready(function(){
      $('#result').animate({opacity: 1},1000);
    });
  </script>
  <script>
    var engine_parameter=['все','Бензин','Дизель','Электро','Гибрид','Газ/бензин','Другое'];
    var gearbox_parameter=['все','Другое','Автоматическая','Механическая'];
  </script>
  <script type="text/javascript" src="<%=Setting.getPath()%>/res/js/get_model_by_brand.js"></script>
  <script type="text/javascript" src="<%=Setting.getPath()%>/res/js/write_parameters_with_search_parameters.js" charset="utf-8"></script>

  <title> Автомобили с прбегом </title>
</head>
<body style="background-image: url('res/img/background1.jpg'); background-size: cover;">
<header>
  <%--<h2 align="center">--%>
    <%--<Small>Только официальные дилеры</Small></h2>--%>


  <p align="center"><a  href="/about_us"><img style="border-radius: 8px" width="70%" src="/res/img/top_pleas.jpg"alt="logo">
  </a></p>
  <%--<h1 style="color: #4E10AA; font-family: 'Courier New'" align="center"><%=Setting.getProjectName()%></h1>--%>

    <ul id="menu">
      <%
        EncoderId encoderId = new EncoderId();
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
      <li><a href="<%=Setting.getHost()+"/myAccount"%>">Мои автомобили</a></li>
      <c:url var="logoutAction" value="/j_spring_security_logout"></c:url>
      <li><a  href= "${logoutAction}">Выход</a></li>
      <%
      }
      else {
      %>
      <li><a  href="<%=Setting.getHost()+"/myAccount"%>">Войти</a></li>
      <%
        }
      %>
      <% if(idDealer=="anonymousUser"){%>
      <li><a href="registration" method="get">Регистрация</a></li>
      <%}else{ %>
      <li><a href="<%=Setting.getHost()+"/feedback"%>">Обратная связь</a></li>
      <% } %>
      <li><a href="" id="go">Сообщить об ошибке</a></li>
      <li><a href="<%=Setting.getHost()+"/about_us"%>" >О нас</a></li>
      <%--<li><a href="#home">На главную</a></li>--%>
    </ul>

  <%--<!-- <h5>Результаты поиска: </h5><br>  -->--%>
</header>


<%--<h5>Недавно добавлены: </h5>--%>
<ul id="menu2">
  <%--<h5>Сортировка:</h5>--%>

  <li><a href="<%=Setting.getPath()%>/ascending_price">По возрастанию цены</a></li>
  <li><a href="<%=Setting.getPath()%>/by_prices_descending">По убыванию цены</a></li>
</ul>
<%--<h5>Результаты поиска: </h5>--%>
<div id="layout">

  <div id="baner-left">
    <form action="<%=Setting.getHost()+"/lookForCars"%>" method="post">
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

        <p>ТИП ДВИГАТЕЛЯ</br>
          <select id="id_engine" class="form-control" name="engine">

          </select></p>
        ТИП КПП<br>
        <select id="id_gearbox" class="form-control" name="gearbox">

        </select>

        <p>РЕГИОН<br>
          <select id="id_region"  class="form-control" name="region">
            <option value = "" >вcе регионы</option>
          </select>
        </p>
        <button type="submit" class="btn btn-primary btn-lg ">Подобрать авто</button>
        <a href="<%=Setting.getHost()+"/resetSearchOptions"%>"><button type="button" class="btn btn-primary btn-lg">Сбросить</button></a>
      </div>
    </form>
  </div>


  <div id="result">

      <%
        int countOfCar=0;
        if(cars!=null){

            if(cars.size()==0){
            %>
          <h1>По Вашему запросу ничего не найдено</h1>
            <%
              }

          else {

        for (Car car:cars){

          String path;
            if(car.getMainPhotoUrl()==null) {
              path=Setting.getHost()+"/res/img/notAvailable.png";
            }
            else {
              path = Setting.getHost()+"/getPhoto?pathPhoto="+car.getMainPhotoUrl()+"&percentage_of_reduction=30";
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
      %>
      <div class="auto">
        <a title=<%=car.getBrand()+" "%><%=car.getModel()%> href="<%=Setting.getHost()%>/carPage?idCar=<%=encoderId.encodId(car.getIdCar().toString())%>">
        <div class="model" >
        <%=car.getBrand()+" "%><%=car.getModel()%>
        </div>
        </a>
        <div class= "foto-185x120">
      <a title= <%=car.getBrand()+" "%><%=car.getModel()%> href="<%=Setting.getHost()%>/carPage?idCar=<%=encoderId.encodId(car.getIdCar().toString())%>" class= "foto-185x120" >
        <img class="car_photo" id="<%="car"+countOfCar%>" src="<%=path%>" align="left">
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

        <a title="Подробнее" href="<%=Setting.getHost()%>/carPage?idCar=<%=encoderId.encodId(car.getIdCar().toString())%>" class="more">
          Подробнее...
        </a>
    </div>

    <%countOfCar++;
          }
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
      <li><a href="<%=Setting.getHost()%>/replacing_the_page_number?page=<%=numberPage-1%>" >«</a></li>
      <%}%>
      <%int maxCount=0;
        for (int i=numberFirstPage;i<=countButtons;i++){
      if(maxCount>=7)break;
      %>
      <li><a
              <%if (i==numberPage){%>class="active"<%}%>
              href="<%=Setting.getHost()%>/replacing_the_page_number?page=<%=i%>"><%=i%></a></li>
      <%
          maxCount++;
        }
      if(countButtons>7){%>
      <li><a  href="<%=Setting.getHost()%>/replacing_the_page_number?page=<%=numberPage+1%>">»</a></li>
      <%}%>
    </ul>
  </div>
  <%--<div id="baner-right">--%>
    <%--Здесь находятся автомобили официальных диллеров. Любой официальный диллер любой марки может зрегестрироватся.--%>
  <%--</div>--%>
</div>

<footer style="text-align: center" >autoport.kh.ua@gmail.com </footer>
<script>
  var successful="Спасибо за отзыв, мы постараемся исправить это в ближайщее время.";
  var unsuccessful="Введите корректный email.";
  var empty_field ="Вы оставили пустые поля!"

</script>
<script type="text/javascript" charset=utf-8" src="<%=Setting.getPath()%>/res/js/feedback-sender.js"></script>
<!-- Модальное окно -->
<div id="modal_form">
  <img id="modal_close" src="../res/img/close.png" style="
    width: 40px;
    height: 40px;
    left: 91%;
    top: -9%;
    "/>
  <%--<span id="modal_close">X</span>--%>
  <%--action="/save_message" method="post"--%>
  <form id="feedback" >
    <h3>Введите пожалуйста данные</h3>
    <%--<input type="hidden" name="id" value="">--%>
    <p>Электронный адресс<br />
      <input style="width: 280px;" type="email" class="email"  size="40" />
    </p>
    <p>Сообщение<br />
      <textarea style="width: 280px;" name="message" class="message" maxlength="380" required="required" cols="37" rows="8"></textarea>
    </p>

    <p style="text-align: center; padding-bottom: 10px;">
      <input id="send_feedback" type="button" value="Отправить" />
    </p>

  </form>
</div>
<div id="overlay"></div>

</body>
</html>

