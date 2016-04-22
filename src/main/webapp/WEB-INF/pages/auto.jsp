<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.modelClass.*" %>
<%@ page import="com.setting.Setting" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <script type="text/javascript" src="/res/js/jquery-1.2.6.min.js"></script>
  <script type="text/javascript" src="/res/js/jquery-easing-1.3.pack.js"></script>
  <script type="text/javascript" src="/res/js/jquery-easing-compatibility.1.2.pack.js"></script>
  <script type="text/javascript" src="/res/js/coda-slider.1.1.1.pack.js"></script>

  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <link rel="stylesheet" type="text/css" href="/res/css/style_auto.css">
  <link rel="stylesheet" type="text/css" href="/res/css/style_for_slider.css">

  <script type="text/javascript">
    function setBigImageSlide(group) {
      var images = document.getElementById(group).src;
      var image = document.getElementById("bigimgslide").src=images;
    }
  </script>

  <script type="text/javascript">

    $(document).ready(function() { // вся магия после загрузки страницы


      $('a#go').click( function(event){ // ловим клик по ссылки с id="go"

        event.preventDefault(); // выключаем стандартную роль элемента
        $('#overlay').fadeIn(400, // сначала плавно показываем темную подложку
                function(){ // после выполнения предъидущей анимации
                  var big_photo=$('#big-photo1');
                  if(big_photo.height()>big_photo.width()){
                    big_photo
                            .css('position','relative')
                            .css('right','-25%');
                  }
                  $('#modal_form')

                          .css('display', 'block') // убираем у модального окна display: none;
                          .animate({opacity: 1, top: '20%'}, 200); // плавно прибавляем прозрачность одновременно со съезжанием вниз

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
  <script type="text/javascript">
    var theInt = null;
    var $crosslink, $navthumb;
    var curclicked = 0;
    $(function(){

      $("#main-photo-slider").codaSlider();


      $navthumb = $(".nav-thumb");

      $navthumb
              .click(function() {

                var photo=$(this);
                var $this = $(this);
                var big_photo=$('#big-photo1');
                big_photo
                        .css('position','relative')
                        .css('right','0%');
                if(photo.width()<photo.height()){
                  $('.panel')
                          .css('position','relative')
//                          .css('right','-3%');
                          .animate({right: '-4%'}, 500);
                }
                else{
                  $('.panel')
                          .css('position','relative')
                          .animate({right: '0%'}, 500);
//                .css('right','0%');
                }
              });

    });

  </script>



  <!-- <link href='https://fonts.googleapis.com/css?family=Shadows+Into+Light' rel='stylesheet' type='text/css'> -->
<title> Автомобили с пробегом </title>
</head>

<body>
<header>
<h1><a class="header"title="На главную" href="/"><%=Setting.getProjectName()%></a></h1>
<h2>Автомобили с пробегом <br>
<Small>Только официальные дилеры</Small></h2>
<!-- <h5>Результаты поиска: </h5><br>  -->
</header>
<ul id="menu">
  <li><a title="На главную" href="/">На главную</a></li>
  <li><a title="К результатам" href="/">Вернуться к результатам поиска</a></li>
  <li><a href="/about_us" >О нас</a></li>
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


  <%
    Dealer dealer = (Dealer)request.getAttribute("dealer");
    Car car= (Car) request.getAttribute("car");
    if(car==null||dealer==null){
    String redirectURL = "/";
    response.sendRedirect(redirectURL);
    }else {
    String path;
    if(car.getPhotoPath().size()==0) {
      path="/res/img/notAvailable.png";
    }
    else {
      path = "/getPhoto?pathPhoto="+car.getPhotoPath().get(0).getPath()+"&percentage_of_reduction=50";

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
<div id="result">
<div class="auto">


<div class= "model" >
<%=car.getBrand()%>  <%=car.getModel()%>
</div>


<div class ="main-foto">


  <div id="panes">
  <a title="<%=car.getBrand()%>  <%=car.getModel()%>" href="#" id="go" >
  <img  id='bigimgslide' class="foto-380x250" src="<%=path%>" align="left">
  </a>
  </div>
  <div class="small-photo">
  <%
    int idPhoto=0;
    for (PhotoPath photo:car.getPhotoPath()) {
      String paths;

        paths = "/getPhoto?pathPhoto="+photo.getPath()+"&percentage_of_reduction=50";

  %>
<div class="small-foto">

<a title="<%=car.getBrand()%>  <%=car.getModel()%>" href="#" >
<img  id=<%=idPhoto%>  class="foto-85x56" onclick='setBigImageSlide(<%=idPhoto%>)'  src="<%=paths%>" alt="">
</a>

</div>
  <%
      idPhoto++;
    }%>
  </div>
</div>




<div class="model-info">
Цена: <span class="model-info-data"><%=car.getPrise()%>$</span><br>
Год: <span class="model-info-data"><%=car.getYearMade()%></span><br>
Пробег: <span class="model-info-data"><%=car.getMileage()%>км</span><br>
Двигатель: <span class="model-info-data"><%=car.getEngineCapacity()%></span><br>
Топливо: <span class="model-info-data"><%=EnginesType%></span><br>
КП: <span class="model-info-data"><%=transmission%></span><br>
Комплектация: <span class="model-info-data"><%=car.getEquipment()%></span><br>
Дополнительно: <br><span class="model-info-data-coment">
<%=car.getDescription()%>
</span>
</div>


<%if(dealer!=null){%>
<div class="info">
<div class="town"><u>Город:</u><br> <span class="info-data"><%=dealer.getAddress().getCity()%></span></div>
<div class="phone-number"><u>Телефон:</u><br> <span class="info-data">
  <%for (Contact_person contact_person:dealer.getContact_persons()){%>
<%=contact_person.getPhone()%> <br>
<%}%>
</span></div>
<div class="diller"><u>Дилер:</u><br> <a title="Диллер" href="  "><span class="info-data"><%=dealer.getNameDealer()%></span></a></div>

</div>
<%}%>
<!-- <a title="Подробнее"href="http" class="more">
Подробнее
</a> -->
</div>
</div>

</div>





<%--<p><a href="#" id="go">Ссылка с окном</a></p>--%>




<!-- Модальное окно -->
<div id="modal_form">
  <span id="modal_close"></span>
  <div id="page-wrap">

    <div class="slider-wrap">
      <div id="main-photo-slider" class="csw">
        <div class="panelContainer">
          <%
            int i=1;
            for (PhotoPath photo:car.getPhotoPath()) {
            String paths;
              paths = "/getPhoto?pathPhoto="+photo.getPath();
          %>
          <div  class="panel" title="фото номер <%=i%>">
            <div class="wrapper">
              <img id="big-photo<%=i%>" src="<%=paths%>"  style="height: 600px" alt="temp" />
            </div>
          </div>
          <%i++;
          }%>

        </div>
      </div>


      <div id="movers-row">
        <%
          int j=1;
          for (PhotoPath photo:car.getPhotoPath()) {
            String paths;
            paths = "/getPhoto?pathPhoto="+photo;
            %>
        <%----%>
        <div><a class="cross-link" href="#<%=j%>" > <img src="<%=paths%>"  height="50" class="nav-thumb" alt="temp-thumb" /></a></div>
<%j++;
}
}%>
    </div>

  </div>
</div>
</div>
<div id="overlay"></div>



<footer>Подвал </footer>

</body>
</html>

