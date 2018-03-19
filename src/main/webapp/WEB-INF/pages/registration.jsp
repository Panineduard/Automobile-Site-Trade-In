<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.setting.Setting" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="com.helpers.EncoderId" %>
<%@ page import="com.models.Car" %>
<%@ page import="com.helpers.SearchOptions" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: Эдуард
  Date: 02.08.15
  Time: 11:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>

    <title> Автомобили с пробегом </title>
    <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
    <%--<link rel="stylesheet" type="text/css" href="<%=Setting.getPath()%>/res/css/style_registration.css">--%>
    <link rel="stylesheet" type="text/css" href="/res/css/style_addCar.css">
    <link rel="stylesheet" type="text/css" href="<%=Setting.getPath()%>/res/css/modal_window.css">

    <link rel="shortcut icon" href="/res/img/favicon.ico"/>
    <script type="text/javascript" src="<%=Setting.getPath()%>/res/js/modal_window.js"></script>

    <script type="text/javascript">
        var form_valid=true;
        $(document).ready(function () {
            $("#captcha_refresher").click(function () {
                $("#captcha_refresh").animate({borderSpacing: 360}, {
                    step: function (now) {
                        $(this).css('transform', 'rotate(' + now + 'deg)');
                    }
                });
                $("#captcha_refresh").animate({borderSpacing: 0}, {
                    step: function (now) {
                        $(this).css('transform', 'rotate(' + now + 'deg)');
                    }
                });

                document.getElementById('captcha_id').src = 'captcha.jpg?' + Math.random();

            });
            $("#id_dealers_number").change(function () {
                $.post("/check_id_dealer", {id: $(this).val()})
                        .done(function (data) {
                            if (data) {
                                $(".text_massage")[0].innerHTML = "Диллер с таким номером уже существует!";
                                form_valid=false;
                                $('#massage_dealers_number').animate({
                                    opacity: 1
                                }, 700, function () {
                                });
                            }
                            else {
                                form_valid=true;
                                $(".text_massage")[0].innerHTML = "";
                                $('#massage_dealers_number').animate({
                                    opacity: 0
                                }, 700, function () {
                                });
                            }
                        });
            })
            $("#form").submit(
                    function () {
                        if (!form_valid) {
                                    alert("Проверте данные!")
                                    return false;
                            }
                    });
        });
    </script>


</head>

<body>
<div id="wrapper">
    <header>

        <a class="header" title="На главную" href="/"><img src="/res/img/primary_logo.png" alt=""></a>

        <%
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            String idDealer = auth.getName();
            if (idDealer != "anonymousUser") {%>
        <div class="login">
            <c:url var="logoutAction" value="/j_spring_security_logout"></c:url>
            <form class="form" action="${logoutAction}" method="get">
                <fieldset class="register-group">
                    <p> Номер диллера - <%=idDealer%>
                    </p>
                    <button class="btn-default" style="width: 80px" type="submit">Выход</button>
                </fieldset>
            </form>
        </div>
        <%
        } else {
        %>
        <div class="login">
            <c:url value="/j_spring_security_check" var="loginUrl"/>
            <form class="form" action="${loginUrl}" method="post">

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
                <a href="/lost_password" style="top: -20px; left: 30px; position: relative;" class="repassword">Забыли пароль?</a>
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
                <% if (idDealer != "anonymousUser") {%>
                <li><a title="Мои автомобили" href="<%=Setting.getHost()+"/myAccount"%>">Мои автомобили</a></li>
                <li><a title="Добавить авто" href="/addCar">+ Добавить авто</a></li>
                <li><a title="Обратная связь" href="<%=Setting.getHost()+"/feedback"%>">Обратная связь</a></li>
                <% } %>
                <li><a href="<%=Setting.getHost()+"/about_us"%>">О нас</a></li>
                <li><a href="" id="go">Сообщить об ошибке</a></li>
            </ul>
        </nav>
    </div>
    <div id="layout">
        <div id="result">
            <div class="auto">
                <h2>${msg}</h2>
                <%--/////////////////////////////////////////////////////////////////////////////////////--%>
                <form id="form" action="registration" method="post">
                    <%
                        String numberDealer = request.getParameter("numberDealer");
                        String nameDealer = request.getParameter("nameDealer");
                        String city = request.getParameter("city");
                        String name = request.getParameter("name");
                        String personPhone = request.getParameter("personPhone");
                        String email = request.getParameter("email");
                        if (name == null || nameDealer == null || numberDealer == null || city == null || personPhone == null || email == null) {
                            numberDealer = "";
                            nameDealer = "";
                            city = "";
                            name = "";
                            personPhone = "";
                            email = "";
                        }

                    %>
                    <div class="container">
                        <h3 class="addCar">Заполните данные диллерского центра:</h3>

                        <h2>Название организации <br>
                            <input id="id_name_dealer" type="text" required="required" value="<%=nameDealer%>"
                                   name="nameDealer"></h2>


                        <h2>Номер диллера <br>
                            <input id="id_dealers_number" type="text" required="required" value="<%=numberDealer%>"
                                   name="numberDealer">
                        </h2>
                        <div id="massage_dealers_number" style="position: absolute;opacity: 0; left: 53%; top: 340px;">
                            <p class="text_massage"></p>
                            <img src="/res/img/massage.png">
                        </div>
                        <h2>Местоположение <br>
                            <input type="text" id="id_city" required="required" value="<%=city%>" name="city"></h2>
                        <h3 class="addCar">Данные контактного лица</h3>

                        <h2>Имя <br>
                            <input type="text" id="id_name" required="required" value="<%=name%>" name="name"></h2>
                        <h2>Телефон <br>
                            <input type="text" id="id_phone" required="required" name="personPhone"
                                   value="<%=personPhone%>"></h2>
                        <div id="massage_phone" style="position: absolute;opacity: 0; left: 53%; top: 610px;">
                            <p class="text_massage"></p>
                            <img src="/res/img/massage.png">
                        </div>

                        <h2>Электронный адрес<br>
                            <input type="email" id="id_email" required="required" value="<%=email%>" name="email"></h2>

                        <div id="massage_email" style="position: absolute;opacity: 0; left: 52%; top: 47%;">
                            <p class="text_massage"></p>
                            <img src="/res/img/massage.png">
                        </div>
                        <h3 class="addCar">Введите пароль для полной регистрации</h3>

                        <h2>Пароль<br>
                            <input type="password" id="id_password" required="required" name="pasword"></h2>

                        <div id="massage_password" style="position: absolute;opacity: 0; left: 52%; top: 47%;">
                            <p class="text_massage"></p>
                            <img src="/res/img/massage.png">
                        </div>
                        <h2>Проверка пароля<br>
                            <input type="password" id="id_checkPasword" required="required" name="checkPasword"></h2>

                        <div id="massage_checkPasword" style="position: absolute;opacity: 0; left: 52%; top: 47%;">
                            <p class="text_massage"></p>
                            <img src="/res/img/massage.png">
                        </div>

                        <td>
                            <div>
                                <img id="captcha_id" name="imgCaptcha" src="captcha.jpg">
                                <a id="captcha_refresher" href="javascript:;"
                                   title="change captcha text"
                                   onclick="">
                                    <img id="captcha_refresh" src="res/img/refresh.png" width="30" height="30"/>
                                </a>
                            </div>
                        </td>
                        <h2>Текст с картинки<br>
                            <input type="text" name="captcha"></h2>
                        <button class="button-main" type="submit">Зарегистрироваться</button>
                    </div>

                </form>

            </div>
        </div>


    </div>

    <footer style="text-align: center">autoport.kh.ua@gmail.com</footer>
    <script>
        var successful = "Спасибо за отзыв, мы постараемся исправить это в ближайщее время.";
        var unsuccessful = "Введите корректный email.";
        var empty_field = "Вы оставили пустые поля!"
    </script>
    <script type="text/javascript" charset=utf-8" src="<%=Setting.getPath()%>/res/js/feedback-sender.js"></script>
    <!-- Модальное окно -->
    <div id="modal_form">
        <img id="modal_close" src="..<%=Setting.getPath()%>/res/img/close.png" style="
    width: 40px;
    height: 40px;
    left: 91%;
    top: -9%;"/>
        <%--<span id="modal_close">X</span>--%>
        <%--action="/save_message" method="post"--%>
        <form id="feedback">
            <h3>Введите пожалуйста данные</h3>
            <%--<input type="hidden" name="id" value="">--%>
            <p>Электронный адресс<br/>
                <input style="width: 280px;" type="email" class="email" required="required" size="40"/>
            </p>

            <p>Сообщение<br/>
                <textarea style="resize: inherit" name="message" class="message" maxlength="380" required="required"
                          cols="37" rows="8"></textarea>
            </p>

            <p style="text-align: center; padding-bottom: 10px;">
                <input id="send_feedback" type="button" value="Отправить"/>
            </p>

        </form>
    </div>
    <div id="overlay"></div>


</div>

</body>
</html>