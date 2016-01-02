<%@ page import="com.modelClass.Login" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%--
  Created by IntelliJ IDEA.
  User: ������
  Date: 28.07.15
  Time: 20:38
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html>
  <head>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>

    <script type="text/javascript" src="/res/js/linkedselect.js"></script>
    <!-- BOOTSTRAP CORE STYLE CSS -->
    <link href="/res/assets/css/bootstrap.css" rel="stylesheet"/>
    <%--<!-- FONTAWESOME STYLE CSS -->--%>
    <link href="/res/assets/css/font-awesome.min.css" rel="stylesheet"/>
    <%--<!-- VEGAS STYLE CSS -->--%>
    <link href="/res/assets/plugins/vegas/jquery.vegas.min.css" rel="stylesheet"/>
    <%--<!-- CUSTOM STYLE CSS -->--%>
    <link href="/res/assets/css/style.css" rel="stylesheet"/>

    <!--<script src="res/assets/js/respond.min.js"></script>-->
    <%--<script src="res/assets/js/html5shiv.js"></script>--%>
    <%--<![endif]-->--%>

    <title>Автомобили программы Volkswagen TRADE-IN по Украине</title>

  </head>
  <body>


  <div class="navbar navbar-inverse navbar-fixed-top scrollclass" >
    <div class="container">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <%
          Authentication auth = SecurityContextHolder.getContext().getAuthentication();
          String idDealer = auth.getName();
          if(idDealer!="anonymousUser"){%>
        <a class="navbar-brand"  href="/myAccount">Войти</a>
        <c:url var="logoutAction" value="/j_spring_security_logout"></c:url>
        <a class="navbar-brand" href= "${logoutAction}">Выход</a>
        <%
          }
        else {
          %>
        <a class="navbar-brand" href="/myAccount">Войти</a>
        <%
        }
        %>

      </div>
      <div class="navbar-collapse collapse">
        <ul class="nav navbar-nav navbar-right">
          <li><a href="#home">Домой</a></li>
          <li><a href="#about">Описание</a></li>
          <% if(idDealer=="anonymousUser"){%>
          <li><a href="registration" method="get">Регистрация</a></li>
<%}else{ %>
          <li><a href="#feedback">Обратная связь</a></li>
          <% } %>
          <li><a href="#registration">Контакты</a></li>


        </ul>
      </div>

    </div>
  </div>

  <section class="for-full-back color-bg-one" id="clinSess">
    <%request.getSession().setAttribute("login",null);%>
  </section>

  <!--HOME SECTION-->
  <div class="container" id="home">
    <div class="row text-center ">
      <div class="col-md-12">
        <span class="head-main">Поиск твоего автомобиля </span>

        <h3 align="center" class="head-last">Автомобили программы Volkswagen TRADE-IN по Украине</h3>

         <form action="/poisk/avto/" method="get">

            <div class="row">
              <div class="col-sm-6 form-group">
                <h2>Марка</h2>
                <select id="id_make1" class="form-control" name="make1">
                  <option value="" selected="selected">выберите марку</option>
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
                  <option value="583"class="cat-top">Chevrolet (3632)</option>
                  <%--<option value="957">Chrysler </option>--%>
                  <option value="1004"class="cat-top">Citroen (1767)</option>
                  <%--<option value="344">Dacia </option>--%>

                  <option value="1639"class="cat-top">Daewoo (4922)</option>
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
                  <option value="1872"class="cat-top">Mazda (2612)</option>
                  <option value="1121"class="cat-top">Mercedes (5145)</option>
                  <%--<option value="2977">MG (73)</option>--%>
                  <%--<option value="148">MINI (56)</option>--%>
                  <option value="1094"class="cat-top">Mitsubishi (3545)</option>
                  <option value="1522"class="cat-top">Nissan (3801)</option>
                  <option value="1374"class="cat-top">Opel (5878)</option>
                  <option value="1032"class="cat-top">Peugeot (2410)</option>
                  <option value="398">Porsche (224)</option>
                  <option value="1826"class="cat-top">Renault (4661)</option>
                  <%--<option value="243">Rolls Royce (16)</option>--%>
                  <%--<option value="447">Rover (97)</option>--%>
                  <%--<option value="980">Saab (51)</option>--%>
                  <%--<option value="43">Samand (62)</option>--%>
                  <%--<option value="138">Samsung (8)</option>--%>
                  <option value="1058">Seat (458)</option>
                  <option value="1081"class="cat-top">Skoda (3687)</option>
                  <%--<option value="3000">SMA (11)</option>--%>
                  <%--<option value="2974">Smart (312)</option>--%>
                  <%--<option value="680"class="cat-top">SsangYong (734)</option>--%>
                  <option value="519"class="cat-top">Subaru (958)</option>
                  <option value="431"class="cat-top">Suzuki (661)</option>

                  <%--<option value="2001">Tesla (7)</option>--%>
                  <option value="1594"class="cat-top">Toyota (3687)</option>

                  <option value="volkswagen"class="cat-top">Volkswagen (8918)</option>
                  <option value="1479"class="cat-top">Volvo (650)</option>

                  <%--<option value="180">Богдан (102)</option>--%>
                  <option value="1659"class="cat-top">ВАЗ (18402)</option>
                  <option value="1799"class="cat-top">ГАЗ (1416)</option>
                  <option value="576"class="cat-top">ЗАЗ (3524)</option>

                  <%--<option value="634"class="cat-top">Москвич (843)</option>--%>
                  <%--<option value="7183">СМЗ (7)</option>--%>
                  <%--<option value="1782">УАЗ (411)</option>--%>
                </select>
              </div>
              <div class="col-sm-6 form-group">
                <h2>Модель</h2>
                <select id="id_model1" class="form-control" name="model1">
                  <option value="" selected="selected">укажите марку</option>
                </select>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-6 form-group">
                Цена, $
                <div class="row">
                  <div class="col-sm-6"><input id="id_price_from" type="text" placeholder="от" class="form-control" name="price_from" /></div>
                  <div class="col-sm-6"><input id="id_price_to" type="text" placeholder="до" class="form-control" name="price_to" /></div>
                </div>
              </div>
              <div class="col-sm-6 form-group">
                Год выпуска
                <div class="row">
                  <div class="col-sm-6"><select id="id_year_from" class="form-control" name="year_from">
                    <option value="" selected="selected">c</option>
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
                    <option value="1979">1979</option>
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
                  </select></div>
                  <div class="col-sm-6"><select id="id_year_to" class="form-control" name="year_to">
                    <option value="" selected="selected">по</option>
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
                    <option value="1979">1979</option>
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
                  </select></div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-6 form-group">
                <div class="row">
                  <div class="col-sm-6 form-group">
                    Тип двигателя
                    <select id="id_engine" class="form-control" name="engine">
                      <option value="" selected="selected">все</option>
                      <option value="1948">Бензин</option>
                      <option value="1987">Дизель</option>
                      <option value="2022">Электро</option>
                      <option value="1988">Гибрид</option>
                    </select>
                  </div>
                  <div class="col-sm-6 form-group">
                    Тип КПП
                    <select id="id_gearbox" class="form-control" name="gearbox">
                      <option value="" selected="selected">все</option>
                      <option value="2009">Автоматическая</option>
                      <option value="2008">Механическая</option>
                    </select>
                  </div>
                </div>
              </div>



            <div class="row row-last">
              <div class="col-sm-6">
                <button type="submit" class="btn btn-primary btn-lg ">Подобрать авто</button>
              </div>
              <div class="col-sm-6 popover-wrapp">
                <div class="count-popover popover fade right in">
                  <div class="arrow"></div>
                  <div class="popover-content"><i class="fa fa-spinner fa-spin"></i></div>
                </div>
              </div>
              <div class="col-sm-6 extended-search-container clearfix">
                <div class="text-center">
                  <span class="ab ab-settings"></span>
                </div>
              </div>
            </div>
            </div>
          </form>


      </div>
    </div>
  </div>
  <!--END HOME SECTION-->

  <!--ABOUT SECTION-->
  <section class="for-full-back color-bg-one" id="about">
    <div class="container">
      <div class="row text-center">
        <div class="col-md-8 col-md-offset-2 ">
          <h1>Об этом сайте</h1>
        </div>
        <div class="row text-center">
          <div class="col-md-8 col-md-offset-2 ">
            <h5>
              Сайт написан без комерческой основы. Регистрация на сайте только для диллеров Volkswagen.


            </h5>
          </div>
        </div>
      </div>
    </div>
  </section>
  <section class="for-full-back color-white" id="about-team">
    <div class="container">
      <div class="row text-center g-pad-bottom">
        <div class="col-md-8 col-md-offset-2 ">
          <h3>ПОЖЕЛАНИЯ</h3>
          <h5>Мы всегда рады проработать все пожелания для улучьшения нажего сайта.
          </h5>
        </div>

      </div>
      <div class="row text-center g-pad-bottom">

        <div class="col-md-3 col-sm-3 col-xs-6">
          <div class="alert alert-danger">
            Основатель идеи данного сайта, и процесса реализации
          </div>
          <div class="team-member">
            <img src="/res/assets/img/team/Agrizkov.jpg" class="img-circle" alt="">
            <h3><strong>АРТ ДИРЕКТОР</strong></h3>
          </div>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-6">
          <div class="alert alert-success">
            Начинающий разработчик ПО на Java
          </div>
          <div class="team-member">
            <img src="/res/assets/img/team/Panin.jpg" class="img-circle" alt="">
            <h3><strong>РАЗРАБОТЧИК</strong></h3>
          </div>


        </div>

        </div>


      </div>


    </div>
  </section>
  <!--END ABOUT SECTION-->

  <!--CLIENT TESTIMONIALS SECTION-->
  <section id="clients-testimonial">
    <div class="container">
      <div class="row text-center">
        <div class="col-md-12 ">
          <h1>Clients Testimonials</h1>
          <div id="carousel-example" class="carousel slide" data-ride="carousel">

            <ol class="carousel-indicators">
              <li data-target="#carousel-example" data-slide-to="0" class="active"></li>
              <li data-target="#carousel-example" data-slide-to="1"></li>
              <li data-target="#carousel-example" data-slide-to="2"></li>
            </ol>

            <div class="carousel-inner">
              <div class="item active">
                <div class="container center">
                  <div class="col-md-6 col-md-offset-3 slide-custom">

                    <h4><i class="fa fa-quote-left"></i> Lorem ipsum dolor sit amet, consectetur adipiscing elit onec molestie non sem vel condimentum. <i class="fa fa-quote-right"></i></h4>
                    <div class="user-img pull-right">
                      <img src="/res/assets/img/user.gif" alt="" class="img-u image-responsive"/>
                    </div>
                    <h5 class="pull-right"><strong class="c-black">Lorem Dolor</strong></h5>
                  </div>
                </div>
              </div>
              <div class="item">
                <div class="container center">
                  <div class="col-md-6 col-md-offset-3 slide-custom">
                    <h4> <i class="fa fa-quote-left"></i> Aenean faucibus luctus enim. Duis quis sem risu suspend lacinia elementum nunc. <i class="fa fa-quote-right"></i></h4>
                    <div class="user-img pull-right">
                      <img src="res/assets/img/user2.png" alt="" class="img-u image-responsive"/>
                    </div>
                    <h5 class="pull-right"><strong class="c-black">Faucibus luctus</strong></h5>
                  </div>
                </div>
              </div>
              <div class="item">
                <div class="container center">
                  <div class="col-md-6 col-md-offset-3 slide-custom">
                    <h4><i class="fa fa-quote-left"></i>Sed ultricies, libero ut adipiscing fringilla, ante elit luctus lorem, a egestas dui metus a arcu condimentum. <i class="fa fa-quote-right"></i></h4>
                    <div class="user-img pull-right">
                      <img src="/res/assets/img/user.gif" alt="" class="img-u image-responsive"/>
                    </div>
                    <h5 class="pull-right"><strong class="c-black">Sed ultricies</strong></h5>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>



  <!--CONTACT SECTION-->
  <section class="for-full-back color-bg-one" id="feedback">
    <div class="container">
      <div class="row text-center">
        <div class="col-md-8 col-md-offset-2 ">
          <h1>Контакты</h1>
        </div>
        <div class="row text-center">
          <div class="col-md-8 col-md-offset-2 ">
            <h5>
              Всегда готовы учесть ваши пожелания

            </h5>
          </div>
        </div>
      </div>
    </div>
  </section>
  <section class="for-full-back color-white text-center" id="contact-inner">
    <div class="container">
<%if(idDealer!="anonymousUser"){%>
      <h1>Оставте отзыв</h1>

      <form action="/sendMessage" method="post">
        <div class="row">
          <div class="col-md-12">
            <div class="form-group">
              <input type="text" name="senderName" class="form-control" required="required"  placeholder="Имя" rec>
            </div>
          </div>
          <div class="col-md-12">
            <div class="form-group">
              <input type="email" name="senderEmail" class="form-control" required="required"
                     placeholder="Email электронный адресс">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 col-sm-12">
            <div class="form-group">
              <textarea name="message" id="message" required="required" class="form-control" style="min-height:200px;" placeholder="Текст письма"></textarea>
            </div>
            <div class="form-group">
              <button type="submit" class="btn btn-primary btn-lg">Отправить</button>
            </div>
          </div>
        </div>
      </form>
      <%}%>
      <div id="add">
        <br />
        Kharkov City, UA
        <br />

        E-mail: panin.eduard.a@gmail.com
      </div>

    </div>
  </section>
  <!--END CONTACT SECTION-->


  <%--<!--FOOTER SECTION -->--%>
  <%--<div class="for-full-back" id="footer">--%>
    <%--2015  by: <a href="http://binarytheme.com" target="_blank" style="color:#fff" ></a>--%>

  <%--</div>--%>
  <%--<!-- END FOOTER SECTION -->--%>

  <!-- JAVASCRIPT FILES PLACED AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
  <!-- CORE JQUERY  -->
  <script src="/res/assets/plugins/jquery-1.10.2.js"></script>
  <!-- BOOTSTRAP CORE SCRIPT   -->
  <script src="/res/assets/plugins/bootstrap.js"></script>
  <!-- VEGAS SLIDESHOW SCRIPTS -->
  <script src="/res/assets/plugins/vegas/jquery.vegas.min.js"></script>
  <!-- SCROLL SCRIPTS -->
  <script src="/res/assets/plugins/jquery.easing.min.js"></script>
  <!-- CUSTOM SCRIPTS -->
  <script src="/res/assets/js/custom.js"></script>


  <script type="text/javascript">
    // Создаем новый объект связанных списков
    var syncList1 = new syncList;

    // Определяем значения подчиненных списков (2 и 3 селектов)
    syncList1.dataList = {

      /* Определяем элементы второго списка в зависимости
       от выбранного значения в первом списке */

      '': {
        '': 'Вы не выбрали марку',

      },

      'volkswagen': {
        'passat': 'Passat',
        'jeta': 'Jeta'

      }


    };

    // Включаем синхронизацию связанных списков
    syncList1.sync("id_make1", "id_model1");
  </script>




  </body>
</html>
