<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.setting.Setting" %>
<%@ page import="com.helpers.EncoderId" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="keywords" content="предлагает авто с пробегом,б/у автомобили, автомобили с пробегом, продажа б/у автомобилей, официальные дилерские автомобили, пробегом, с историей ,проверенные у дилеров ">
    <meta name="description" content=" Здесь расположены автомобили от официальных дилеров Украины. Вы можете просмотреть автомобили находящиеся на площадках дилера.">
    <title> Автомобили с пробегом </title>
    <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
        ga('create', 'UA-78730416-1', 'auto');
        ga('send', 'pageview');
    </script>
    <script type="text/javascript">
        $(document).ready(function(){
            $('.diller-info').animate({opacity: 1},1000);
        });
    </script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="shortcut icon" href="/res/img/favicon.ico"/>
    <link rel="stylesheet" type="text/css" href="<%=Setting.getPath()%>/res/css/modal_window.css">
    <link rel="stylesheet" type="text/css" href="<%=Setting.getPath()%>/res/css/styleAboutUs.css">
    <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="<%=Setting.getPath()%>/res/js/modal_window.js"></script>
    <script type="text/javascript" src="<%=Setting.getPath()%>/res/js/stick_menu.js"></script>
</head>

<body>
<div id="wrapper">

    <header>

        <a class="header" title="На главную" href="/"><img src="/res/img/primary_logo.png" alt=""></a>

        <%
            EncoderId encoderId = new EncoderId();
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
                <a href="registration" class="">Регистрация </a>
                <a href="/lost_password" class="repassword">/Забыли пароль?</a>
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
                <li><a title="На главную" href="/">На главную</a></li>
                <% if (idDealer != "anonymousUser") {%>
                <li><a title="Мои автомобили" href="<%=Setting.getHost()+"/myAccount"%>">Мои автомобили</a></li>
                <li><a title="Добавить авто" href="/addCar">+ Добавить авто</a></li>
                <li><a title="Обратная связь" href="<%=Setting.getHost()+"/feedback"%>">Обратная связь</a></li>
                <% } %>
                <li><a href="" id="go">Сообщить об ошибке</a></li>

            </ul>
        </nav>
    </div>


    <div id="layout">
        <div class="content">

            <h3> Приветствуем Вас на страницах проекта Autoport.website</h3>

            <h5> Тут очень кратко мы ответим на следующие вопросы:</h5>

            <p>
            <ul><li>Что такое Autoport.website?</li>
                <li>Кто и зачем придумал Autoport.website, создал, и будет развивать?</li>
                <li>Каковы цели и задачи Autoport.website?</li>
                <li>Какой план развития?</li>
            </ul>
            </p>

            <p> И так,
                Мы группа энтузиастов, которые любят автомобили, web разработку, программирование. Работая в одном из официальных дилеров по продаже автомобилей, мы каждый день сталкиваемся с запросами от наших покупателей по поиску автомобилей с пробегом. Уверены, что каждый дилер имеет какое то количество автомобилей с пробегом для продажи. Решив, что будет очень удобно объединить данную информацию в одном месте мы создали Autoport.website.
                Это некоммерческий проект, который создан в первую очередь для официальных авто дилеров. Это своего рода электронная площадка, на которой официальные дилеры могут размещать автомобили с пробегом!
            </p>

            <h5>Чем Мы отличаемся от других?</h5>

            <p>
            <ul>
                <li> Зарегистрированные пользователи это исключительно официальные дилеры</li>
                <li> Использование данного ресурса абсолютно бесплатно</li>
            </ul>
            </p>

            <h5>Почему это интересно для дилеров:</h5>
            <p>
            <ul>
                <li>В одном месте будут собраны все автомобили дилеров, уже не нужно будет контактировать с каждым, достаточно просто зайти на сайт</li>
                <li>Один дилер всегда найдет общий язык с другим дилером по всем вопросам</li>
                <li>Понятная история, состояние, пробег автомобиля</li>

            </ul>
            </p>

            <h5>Почему это интересно для потенциальных покупателей:</h5>

            <p>
            <ul>
                <li> Это безопасно в плане покупки</li>
                <li> Это безопасно в плане технического состояния автомобиля</li>
                <li> Гарантия того, что вы можете получить полную, а самое главное честную информацию об автомобиле</li>
            </ul>
            </p>

            <p> Одним словом, наша цель облегчить поиск автомобиля с пробегом для дилеров и для покупателей,
                отсекая перекупщиков, сомнительные площадки и т.д.
            </p>

            <h5>Какой план развития?</h5>

            <p>
            <ol>
                <li>Запуск проекта в сети Volkswagen</li>
                <li>Запуск проекта во всех дилерских сетях на Украине</li>
                <li>Продвижение и раскрутка среди потенциальных покупателей</li>
            </ol>
            </p>

            <h5>P/S/ Непосредственно о самом сайте.</h5>
            <p>Как уже было сказано выше, сайт создан на голом энтузиазме. По нашему мнению
                он полностью функционален, удобен и красив. Но никто не застрахован от ошибок. Мы будем очень признательны Вам за обратную связь, за Ваши замечания и пожелания, которые можно оставить в форме обратной связи или отправить на эектронный адрес <a href="mailto:autoport.kh.ua@gmail.com">autoport.kh.ua@gmail.com</a> , Указанные вами ошибки будут исправлены в кратчайшие сроки. <br>
                Спасибо.
            </p>
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
        <img id="modal_close" src="../res/img/close.png" style="
    width: 40px;
    height: 40px;
    left: 98%;
    top: -9%;
    "/>
        <%--<span id="modal_close">X</span>--%>
        <%--action="/save_message" method="post"--%>
        <form id="feedback">
            <h3>Введите пожалуйста данные</h3>
            <%--<input type="hidden" name="id" value="">--%>
            <p>Электронный адресс<br/>
                <input style="width: 280px;" type="email" class="email" size="40"/>
            </p>

            <p>Сообщение<br/>
                <textarea style="width: 280px;" name="message" class="message" maxlength="380" required="required"
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
