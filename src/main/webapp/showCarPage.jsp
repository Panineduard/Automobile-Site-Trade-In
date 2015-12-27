<%--
  Created by IntelliJ IDEA.
  User: Эдуард
  Date: 09.10.15
  Time: 13:42
  To change this template use File | Settings | File Templates.
--%>

<%--
  Created by IntelliJ IDEA.
  User: Эдуард
  Date: 02.10.15
  Time: 1:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>

  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="assets/ico/favicon.png">

  <title>Ваш акаунт</title>

  <link href="assets/css/hover_pack.css" rel="stylesheet">

  <!-- Bootstrap core CSS -->
  <link href="assetsForPersonalAcount/css/bootstrap.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="assetsForPersonalAcount/css/main.css" rel="stylesheet">
  <link href="assetsForPersonalAcount/css/colors/color-74c9be.css" rel="stylesheet">
  <link href="assetsForPersonalAcount/css/animations.css" rel="stylesheet">
  <link href="assetsForPersonalAcount/css/font-awesome.min.css" rel="stylesheet">


  <!-- JavaScripts needed at the beginning
  ================================================== -->
  <script type="text/javascript" src="http://alvarez.is/demo/marco/assetsForPersonalAcount/js/twitterFetcher_v10_min.js"></script>




  <!-- Main Jquery & Hover Effects. Should load first -->
  <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
  <script src="assetsForPersonalAcount/js/hover_pack.js"></script>


  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
  <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
  <![endif]-->
</head>

<body>




<! ========== PORTFOLIO SECTION =============================================================================================
=============================================================================================================================>
<div class="container">
  <div class="row mt centered ">
    <div class="col-lg-4 col-lg-offset-4">
      <h3>Это ваш акаунт где вы можете добавить или убрать авто. Так же просмотреть количество просмотров авто.</h3>
      <hr>
    </div>
  </div><!-- /row -->

  <div class="row mt">
    <div class="row mt centered">
      <%
        Long idFoundDealer =0L; ;
        if(session.getAttribute("login")!=null){
          idFoundDealer= ((Login)session.getAttribute("login")).getidDealer();
        }

        CarDAO carDAO = new CarDAO();
        List<Car> cars;
        if(idFoundDealer!=0L) {
          cars = carDAO.getCarByIdDealer(idFoundDealer);
          int i = 0;
          for (Car car:cars){
            String path="/images?id="+i+">";
            String idCars = "/chengeDataOfCar?idCar="+car.getIdCar();
            String viewCar="/viewCar?idCar="+car.getIdCar();
      %>
      <form  >
        <div class="col-lg-4 desc">

          <a class="b-link-fade b-animate-go" href=<%=viewCar%>> <img width="350" height="250" src=<%=path%>/>

            <div class="b-wrapper">
              </b>
              <h4 class="b-from-left b-animate b-delay03"><%=car.getBrand()+" "%></h4>
              <a class="b-from-right b-animate b-delay03"href=<%=idCars%>>Изменить</a>

            </div>
          </a>

        </div>
      </form>
      <%
            i++;
          }
        }%>
    </div>
  </div><!-- /row -->
</div><!-- /container -->



</body>
</html>


<%--<form action="UploadServlet" method="post"--%>
<%--enctype="multipart/form-data">--%>
<%--<input type="file" name="file" size="100" />--%>
<%--<br />--%>
<%--<input type="submit" value="Загрузить" />--%>
<%--</form>--%>
