<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.modelClass.Dealer" %>
<%@ page import="com.modelClass.Car" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<head>
  <title>Страница авто</title>
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
<form action="/" method="get" >
  <button type="submit" class="btn btn-theme btn-lg">На главную страницу</button>
</form>
<%
  Dealer dealer = (Dealer)request.getAttribute("dealer");
  Car car= (Car) request.getAttribute("car");
%>
<div style="clear:both"></div>
<div class="box_highlight" style="margin-top:40px">


  <h2 style="text-align:center">Диллер номер - <%=dealer.getNameDealer()%>
  </h2>

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

        for (String photo:car.getPhotoPath()) {



      %>
      <p><div><img  width="600" height="500" src="/getPhoto?pathPhoto=<%=photo%> ">;


      <br>

    </div></p>


      <%}%>

    </div>
    <!-- END tab panes -->
    <br clear="all">
    <!-- navigator -->
    <div id="prod_nav">
      <ul>
        <%

          for (String photo1:car.getPhotoPath()) {

        %>

        <li><a href="#1"><img src="/getPhoto?pathPhoto=<%=photo1%>" width="160" alt=""> </a></li>
        <%}%>

      </ul>

    </div>
    <!-- END navigator -->
  </div>
  <!-- END prod wrapper -->
  <div style="clear:both"></div>


  <div style="clear:both; height: 40px"></div>
</div>






</body>
</html>


