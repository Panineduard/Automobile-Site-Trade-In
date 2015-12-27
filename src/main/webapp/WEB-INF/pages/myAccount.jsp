<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="modelClass.Dealer" %>
<%@ page import="modelClass.Car" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<head>
  <title>Ваш акаунт</title>
  <meta charset="utf-8">
  <!-- Google Fonts -->
  <link href='http://fonts.googleapis.com/css?family=Parisienne' rel='stylesheet' type='text/css'>
  <!-- CSS Files -->
  <link rel="stylesheet" type="text/css" media="screen" href="/res/css/style.css">
  <link rel="stylesheet" type="text/css" media="screen" href="/res/menu/css/simple_menu.css">
  <!-- Contact Form -->
  <link href="/res/contact-form/css/style.css" media="screen" rel="stylesheet" type="text/css">
  <link href="/res/contact-form/css/uniform.css" media="screen" rel="stylesheet" type="text/css">
  <!-- JS Files -->
  <script src="/res/js/jquery.tools.min.js"></script>
  <script>
    $(function () {
      $("#prod_nav ul").tabs("#panes > div", {
        effect: 'fade',
        fadeOutSpeed: 400
      });
    });
  </script>
  <script>
    $(document).ready(function () {
      $(".pane-list li").click(function () {
        window.location = $(this).find("a").attr("href");
        return false;
      });
    });
  </script>
</head>
<body>
<form action="/startPage" method="get" >
  <button type="submit" class="btn btn-theme btn-lg">На главную страницу</button>
</form>
<%
  Dealer dealer = (Dealer)request.getAttribute("dealer");
  List<Car> cars= (List<Car>) request.getAttribute("cars");
%>
<div style="clear:both"></div>
<div class="box_highlight" style="margin-top:40px">


  <h2 style="text-align:center">Диллер номер - <%=dealer.getNameDealer()%>
  </h2>

  <h3 style="text-align:center">Это ваш акаунт где вы можете добавить или убрать авто. Так же просмотреть количество просмотров авто.</h3>

  <h3 style="text-align:center">Контактное лицо</h3>

  <h3 style="text-align:center"><%=dealer.getContact_persons().get(0)%>
  </h3>

  <hr>
</div>
<!-- END header -->
<!-- END header -->
<div id="container">
  <!-- tab panes -->
  <div id="prod_wrapper">
    <div id="panes">
      <%

        for (Car car:cars) {

          String path = car.getPhotoPath().get(0);

      %>
      <p><div><img width="300" height="200" src="/getPhoto?pathPhoto=<%=path%> ">;

      <p style="text-align:right; margin-right: 16px"><a href="#" class="button">Описание</a> <a href="#" class="button">Написать продавцу</a></p>

      <br>

      <p style="text-align:right; margin-right: 16px">
        <a href="/showCarPage.jsp" class="button">More Info</a> <a href="#" class="button">Buy Now</a></p>
    </div></p>
      <%}%>

    </div>
    <!-- END tab panes -->
    <br clear="all">
    <!-- navigator -->
    <div id="prod_nav">
      <ul>
        <%

          for (Car car:cars) {

            String path = car.getPhotoPath().get(0);
        %>

        <li><a href="#1"><img src="/getPhoto?pathPhoto=<%=path%>" width="160" alt=""><strong>Class aptent</strong> $ 199</a></li>
        <%}%>

      </ul>
      <li><a href="/addCar"><img src="/res/img/icon-addons.png" width="160" alt=""><strong>Добавить авто</strong> </a></li>

    </div>
    <!-- END navigator -->
  </div>
  <!-- END prod wrapper -->
  <div style="clear:both"></div>


  <div style="clear:both; height: 40px"></div>
</div>







      <%--<form  >--%>
        <%--<div class="col-lg-4 desc">--%>

          <%--<form action="UploadServlet" method="post"--%>
                <%--enctype="multipart/form-data">--%>
            <%--<input type="file" name="file" size="100" />--%>
            <%--<br />--%>
            <%--<input type="submit" value="Добавить фото" />--%>
          <%--</form>--%>


          <%--<a class="b-from-right b-animate b-delay03"href="787">Изменить</a>--%>

          <%--</p>--%>

        <%--</div>--%>
      <%--</form>--%>


</body>
</html>


