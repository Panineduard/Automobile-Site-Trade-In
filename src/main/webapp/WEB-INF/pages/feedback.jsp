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


        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#home">Домой</a></li>
                <li><a href="#about">Описание</a></li>
                <li><a href="#feedback">Обратная связь</a></li>
                <li><a href="#registration">Контакты</a></li>
            </ul>
        </div>

    </div>
</div>


<!--HOME SECTION-->
<div class="container" id="home">
    <div class="row text-center ">
        <div class="col-md-12">
            <span class="head-main">Поиск твоего автомобиля </span>

            <h3 align="center" class="head-last">Автомобили программы Volkswagen TRADE-IN по Украине</h3>



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
