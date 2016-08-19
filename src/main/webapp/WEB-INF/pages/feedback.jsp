<%@ page import="com.modelClass.Login" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="com.setting.Setting" %>
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

    <link rel="stylesheet" type="text/css" href="<%=Setting.getPath()%>/res/css/modal_window.css">
    <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="<%=Setting.getPath()%>/res/js/modal_window.js"></script>
    <link rel="shortcut icon" href="/res/img/favicon.ico"/>
    <link href="/res/css/style_feedback.css" rel="stylesheet"/>

    <title> Автомобили с пробегом !</title>
</head>

<body>
<div id="wrapper">
    <header>

        <a class="header" title="На главную" href="/about_us"><img src="/res/img/primary_logo.png" alt=""></a>
        <% Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String idDealer = auth.getName();
        if(idDealer!="anonymousUser"){%>
        <div class="login">
            <c:url var="logoutAction" value="/j_spring_security_logout"></c:url>
            <form class="form" action="${logoutAction}" method="get">
                <fieldset class="register-group">
                    <p> Номер диллера - <%=idDealer%></p>
                    <button class="btn-default" style="width: 80px" type="submit">Выход</button>
                </fieldset>
            </form>
        </div>
        <%
            }
            else {
        %>
        <div class="login">
            <c:url value="/j_spring_security_check" var="loginUrl" />
            <form class="form" action="${loginUrl}"  method="post">

                <fieldset class="register-group">
                    <div class="label-group">

                        <label>
                            <input type="text" placeholder="Номер диллера" name="j_username">
                        </label>

                        <label>
                            <input type="password" placeholder="Пароль" name="j_password">
                        </label>
                    </div>
                    <button class="btn-default" type="submit">Войти</button>
                </fieldset>
                <!-- <button class="btn-default" type="submit">Войти</button> -->
            </form>
            <div class="registration-password">
                <a href="registration" class="">Регистрация /</a>
                <a href="/lost_password" class="repassword">Забыли пароль?</a>
            </div>
        </div>
        <%
            }
        %>

    </header>
    <div id="help_div"></div>
    <div id="stick_menu">
        <nav>
            <ul class="menu">
                <% if(idDealer!="anonymousUser"){%>
                <li><a title="Мои автомобили" href="<%=Setting.getHost()+"/myAccount"%>">Мои автомобили</a></li>
                <li><a title="Добавить авто" href="/addCar">+ Добавить авто</a></li>
                <% } %>
                <li><a href="<%=Setting.getHost()+"/about_us"%>" >О нас</a></li>
                <li><a href="" id="go">Сообщить об ошибке</a></li>
            </ul>
        </nav>
    </div>

    <!--<div id="baner-right">-->
    <!--<a href="https://adclick.g.doubleclick.net/pcs/click%253Fxai%253DAKAOjss2PHZ-OCWm0-j9gUlm-eoK-w1Nzt6AEiHVz7SMN2fA1SVKQRpHNSuzQMRHd4hhQHRHyNfSZCbaLDPTKCW3BuGbSJLi5HJHUcr9sTgMEZzCYsr4PNvR_cjLGvfYkjt_dBX_LNpvH_j6uOsx0PdAJ2HBFci5EpxNGKmgS9wWGaKJLoFOgwyH-X9Y86qDwekc641sIJ-ZIe6G92K-ILU7jEDT_I9uJajYZbCqCtpw5-uxlz5udLd6MS2sNfM%2526sig%253DCg0ArKJSzN53VUBcyITuEAE%2526urlfix%253D1%2526adurl%253Dhttps://ad.doubleclick.net/ddm/trackclk/N4022.1909409MOBILEDE.DE/B10050978.135595613%3Bdc_trk_aid%3D308114197%3Bdc_trk_cid%3D72857594%3Bdc_lat%3D%3Bdc_rdid%3D%3Btag_for_child_directed_treatment%3D" id="skyImage6295189607" onclick="window.open(this.href); return false;"><img src="https://tpc.googlesyndication.com/pagead/imgad?id=CICAgKDLlOOSjQEQARgBMgj_7mJtqnRdzA" width="200" height="700" id="sky_content_6295189607" alt="Click me."></a>-->
    <!--</div>-->
    <div id="result">
        <div  class="auto">

            <form  align="center"  action="/sendMessage" method="post">

                <div>
                    <input  type="text" name="senderName" class="field" required="required"  placeholder="Имя" rec>
                </div>
                <div>
                    <input type="email" name="senderEmail"  class="field" required="required"
                           placeholder="Email электронный адресс">
                </div>
                <div>
                    <textarea class="field" name="message" id="message" required="required" class="form-control" style="min-height:200px;" placeholder="Текст письма"></textarea>
                </div>




                <button type="submit" class="btn btn-primary btn-lg">Отправить</button>



            </form>
        </div>
    </div>
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
    left: 98%;
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
