<%@ page import="com.setting.Setting" %>
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

    <title>Регистрация</title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/res/css/style_registration.css">


<script type="text/javascript">
    $(document).ready(function() {
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
    });
</script>


</head>

<body>
<header>
    <h1><a class="header"title="На главную" href=""><%=Setting.getProjectName()%></a></h1>
    <h2>Автомобили с пробегом <br>
        <Small>Только официальные дилеры</Small></h2>
    <!-- <h5>Результаты поиска: </h5><br>  -->
</header>
<ul id="menu">
    <li><a title="На главную" href="/">На главную</a></li>
    <li><a title="Мои автомобили" id="go" href="">Сообщить об ошибке</a></li>
    <li><a href="/about_us" >О нас</a></li>

</ul>
<div id="layout">
    <!-- <div id="baner-left">
    пваыпвпаырвпы вяиваиваи випаваиви вапваипваи
    </div>
    <div id="baner-right">
    some baner rightiygvbbuuuuuuuu uuuuuuuuuuuu uuuuuu uuuuuuuuuuu uuuuu uuuuuuu7 777777777777 77777 77777777 77777777 7777777 7777777
    </div> -->

    <div id="result">
        <div class="auto">



            <FORM name="user_form" action="registration" method="post" onsubmit="return validate_form ( );">
                <div class="login">
                    <%

                        String    numberDealer=request.getParameter("numberDealer");
                        String    nameDealer=request.getParameter("nameDealer");
                        String    city=request.getParameter("city");
                        String    name=request.getParameter("name");
                        String    personPhone=request.getParameter("personPhone");
                        String    email=request.getParameter("email");
                        if(name==null||nameDealer==null||numberDealer==null||city==null||personPhone==null||email==null){
                            numberDealer="";
                            nameDealer="";
                            city="";
                            name="";
                            personPhone="";
                            email="";
                        }

                    %>
                    <h2>Заполните данные диллерского центра</h2>

                    <input type="text" placeholder="Название организации" value="<%=nameDealer%>" name="nameDealer"><br>
                    <input type="text" placeholder="Номер диллера" value="<%=numberDealer%>" name="numberDealer"><br>
                    <input type="text" placeholder="Местоположение" value="<%=city%>" name="city"><br>
                    <%--<input type="text" placeholder="Телефон" name="phone"><br>--%>
                    <h2>Данные контактного лица</h2>
                    <input type="text" placeholder="Имя" value="<%=name%>" name="name"><br>
                    <%--<input type="text" placeholder="Фамилия" name="lastname"><br>--%>
                    <%--<input type="text" placeholder="Отчество" name="firsname"><br>--%>
                    <input type="text" placeholder="Телефон" value="<%=personPhone%>" name="personPhone"><br>
                    <input type="email" placeholder="Электронный адрес" value="<%=email%>" name="email"><br>
                    <h2>Введите пароль для полной регистрации. </h2>
                    <input type="password" placeholder="Пароль" name="pasword"><br>
                    <input type="password" placeholder="Проверка пароля" name="checkPasword"><br>
                    <td>
                        <div>
                            <img id="captcha_id" name="imgCaptcha" src="captcha.jpg">
                            <a id="captcha_refresher" href="javascript:;"
                               title="change captcha text"
                               onclick="">
                                <img id="captcha_refresh" src="res/img/refresh.png" width="30"  height="30" />
                            </a>
                        </div>
                    </td>
                    <br>
                    <input type="text" placeholder="Текст с картинки" name="captcha"><br>
                    <input type="submit" value="Зарегистрироваться">
                    <%--<h1> <%= session.getAttribute("my2")%>!!</h1>--%>
                </div>
            </FORM>
        </div>

    </div>


</div>

<footer>Подвал </footer>
<link rel="stylesheet" type="text/css" href="/res/css/modal_window.css">
<script src="http://code.jquery.com/jquery-1.8.3.js"></script>
<script type="text/javascript" src="/res/js/modal_window.js"></script>
<script>
    var successful="Спасибо за отзыв, мы постараемся исправить это в ближайщее время.";
    var unsuccessful="Введите корректный email.";
</script>
<script type="text/javascript" charset=utf-8" src="/res/js/feedback-sender.js"></script>
<!-- Модальное окно -->
<div id="modal_form">
    <img id="modal_close" src="../res/img/close.png" style="
    width: 40px;
    height: 40px;
    left: 91%;
    top: -9%;"/>
    <%--<span id="modal_close">X</span>--%>
    <%--action="/save_message" method="post"--%>
    <form id="feedback" >
        <h3>Введите пожалуйста данные</h3>
        <%--<input type="hidden" name="id" value="">--%>
        <p>Электронный адресс<br />
            <input  type="email" class="email"  size="40" />
        </p>
        <p>Сообщение<br />
            <textarea name="message" class="message" maxlength="380" required="required" cols="40" rows="7"></textarea>
        </p>

        <p style="text-align: center; padding-bottom: 10px;">
            <input id="send_feedback" type="button" value="Отправить" />
        </p>

    </form>
</div>
<div id="overlay"></div>

</body>

<script type="text/javascript">

    function validate_form() {
        valid = true;

        if (document.user_form.nameDealer.value == "") {
            alert("Пожалуйста заполните поле 'Название организации'.");
            return false;
        }

        if (document.user_form.numberDealer.value == "") {
            alert("Пожалуйста заполните поле 'Номер диллера'.");
            return false;
        }

        if (document.user_form.personPhone.value == "") {
            alert("Пожалуйста заполните поле 'Телефон'.");
            return false;
        }


        if (document.user_form.name.value == "") {
            alert("Пожалуйста заполните поле 'Имя'.");
            return false;
        }


        if (document.user_form.email.value == "") {
            alert("Пожалуйста заполните поле 'Электронный адрес'.");
            return false;
        }
        if (document.user_form.pasword.value == "") {
            alert("Пожалуйста заполните поле 'Пароль'.");
            return false;
        }

        if (document.user_form.checkPasword.value == "") {
            alert("Пожалуйста заполните поле 'Проверка пароля'.");
            return false;
        }
        if (document.user_form.pasword.value != document.user_form.checkPasword.value) {
            alert("Проверьте правильность ввода пароля.");
            return false;

        }

    }

</script>
