<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="com.modelClass.Car" %>
<%@ page import="java.util.List" %>
<%@ page import="org.springframework.ui.ModelMap" %>
<%@ page import="com.helpers.SearchOptions" %>
<%@ page import="com.helpers.EncoderId" %>
<%@ page import="com.setting.Setting" %>
<%@ page import="com.servise.StandartMasege" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: Эдуард
  Date: 03.01.16
  Time: 23:53
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="shortcut icon" href="/res/img/favicon.ico"/>
    <link rel="stylesheet" type="text/css" href="<%=Setting.getPath()%>/res/css/style_index_page.css">
    <link rel="stylesheet" type="text/css" href="<%=Setting.getPath()%>/res/css/modal_window.css">
    <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="<%=Setting.getPath()%>/res/js/modal_window.js"></script>
    <script type="text/javascript" src="<%=Setting.getPath()%>/res/js/get_model_by_brand.js"></script>
    <script type="text/javascript" src="<%=Setting.getPath()%>/res/js/write_parameters_with_search_parameters.js"charset="utf-8"></script>
    <script type="text/javascript" src="<%=Setting.getPath()%>/res/js/stick_menu.js"></script>
    <script type="text/javascript">
        var engine_parameter = ['все', 'Бензин', 'Дизель', 'Электро', 'Гибрид', 'Газ/бензин', 'Другое'];
        var gearbox_parameter = ['все', 'Другое', 'Автоматическая', 'Механическая'];
    </script>

    <title> Автомобили с пробегом </title>
</head>
<body>
<div id="wrapper">
    <header>

        <a class="header" title="На главную" href="/about_us"><img src="/res/img/primary_logo.png" alt=""></a>

        <%
            EncoderId encoderId = new EncoderId();
            List<Car> cars = null;
            SearchOptions options = (SearchOptions) request.getSession().getAttribute("options");
            boolean optionPresent = false;
            int numberPage = 1;
            long countButtons = 0L;
            if (session.getAttribute("page") != null) {
                numberPage = (Integer) session.getAttribute("page");
            }
            if (request.getSession().getAttribute("cars") != null) {
                cars = (List<Car>) request.getSession().getAttribute("cars");
            }
            if (request.getSession().getAttribute("pages") != null) {
                countButtons = (Long) request.getSession().getAttribute("pages");
            }
            if (options != null) {
                optionPresent = true;
            }
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

    <%--<h5>Недавно добавлены: </h5>--%>
    <ul id="menu2">
        <h5>Сортировка:</h5>

        <li><a href="<%=Setting.getPath()%>/ascending_price">По возрастанию цены</a></li>
        <li><a href="<%=Setting.getPath()%>/by_prices_descending">По убыванию цены</a></li>
    </ul>

    <h5>Недавно добавлены: </h5>

    <div id="layout">
        <div id="search_car">
            <aside>
                <form action="<%=Setting.getHost()+"/lookForCars"%>" method="post">
                    <div id="search">
                        <p>МАРКА<br>
                            <select id="id_make" class="form-control" name="make" onchange="p_delete(this.value,' ');">
                                <option value="">вcе марки</option>
                            </select>
                        </p>
                        <p>МОДЕЛЬ<br>
                            <select id="id_model" name="model">
                                <option value="" selected="selected">выберите марку</option>
                            </select></p>
                        <p>ЦЕНА<br>
                            <%if (optionPresent) {%>
                            <input id="id_price_from" type="text" placeholder="от" value="<%=options.getPrice_from()%>"
                                   class="form-control" name="price_from"/>
                            <input id="id_price_to" type="text" placeholder="до" value="<%=options.getPrice_to()%>"
                                   class="form-control" name="price_to"/>
                            <%} else {%>
                            <input id="id_price_from" type="text" placeholder="от" class="form-control"
                                   name="price_from"/>
                            <input id="id_price_to" type="text" placeholder="до" class="form-control" name="price_to"/>
                            <%}%>

                        </p>

                        <p>ГОД ВЫПУСКА<br>
                            <select id="id_year_from" class="form-control" name="year_from">
                                <option value="">c</option>
                            </select>

                            <select id="id_year_to" class="form-control" name="year_to">
                                <option value="">по</option>
                            </select></p>

                        <p>ТИП ДВИГАТЕЛЯ</br>
                            <select id="id_engine" class="form-control" name="engine">

                            </select></p>
                        ТИП КПП<br>
                        <select id="id_gearbox" class="form-control" name="gearbox">

                        </select>

                        <p>РЕГИОН<br>
                            <select id="id_region" class="form-control" name="region">
                                <option value="">вcе регионы</option>
                            </select>
                        </p>
                        <p>
                            <button type="submit" class="btn btn-primary btn-lg ">Подобрать авто</button>
                        </p>
                        <p><a href="<%=Setting.getHost()+"/resetSearchOptions"%>">
                            <button type="button" class="btn btn-primary btn-lg">Сбросить</button>
                        </a></p>
                    </div>
                </form>
            </aside>
        </div>
        <div id="baner-right">
            <a href="https://adclick.g.doubleclick.net/pcs/click%253Fxai%253DAKAOjss2PHZ-OCWm0-j9gUlm-eoK-w1Nzt6AEiHVz7SMN2fA1SVKQRpHNSuzQMRHd4hhQHRHyNfSZCbaLDPTKCW3BuGbSJLi5HJHUcr9sTgMEZzCYsr4PNvR_cjLGvfYkjt_dBX_LNpvH_j6uOsx0PdAJ2HBFci5EpxNGKmgS9wWGaKJLoFOgwyH-X9Y86qDwekc641sIJ-ZIe6G92K-ILU7jEDT_I9uJajYZbCqCtpw5-uxlz5udLd6MS2sNfM%2526sig%253DCg0ArKJSzN53VUBcyITuEAE%2526urlfix%253D1%2526adurl%253Dhttps://ad.doubleclick.net/ddm/trackclk/N4022.1909409MOBILEDE.DE/B10050978.135595613%3Bdc_trk_aid%3D308114197%3Bdc_trk_cid%3D72857594%3Bdc_lat%3D%3Bdc_rdid%3D%3Btag_for_child_directed_treatment%3D"
               id="skyImage6295189607" onclick="window.open(this.href); return false;"><img class="banner"
                                                                                            src="https://tpc.googlesyndication.com/pagead/imgad?id=CICAgKDLlOOSjQEQARgBMgj_7mJtqnRdzA"
                                                                                            width="200" height="700"
                                                                                            id="sky_content_6295189607"
                                                                                            alt="Click me."></a>
        </div>
        <div id="result">

            <%
                int countOfCar = 0;
                if (cars != null) {

                    if (cars.size() == 0) {
            %>
            <h1>По Вашему запросу ничего не найдено</h1>
            <%
            } else {

                for (Car car : cars) {

                    String path;
                    if (car.getMainPhotoUrl() == null) {
                        path = Setting.getHost() + "/res/img/notAvailable.png";
                    } else {
                        path = Setting.getHost() + "/getPhoto?pathPhoto=" + car.getMainPhotoUrl() + "&percentage_of_reduction=30";
                    }

                    String EnginesType = "нет данных";
                    String transmission = "нет данных";
                    if (car.getEnginesType().equals("gasoline")) {
                        EnginesType = "Бензин";
                    } else if (car.getEnginesType().equals("disel")) {
                        EnginesType = "Дизель";
                    } else if (car.getEnginesType().equals("elektro")) {
                        EnginesType = "Электро";
                    } else if (car.getEnginesType().equals("hybrid")) {
                        EnginesType = "Гибрид";
                    } else if (car.getEnginesType().equals("gas")) {
                        EnginesType = "Газ/бензин";
                    }
                    if (car.getTransmission().equals("auto")) {
                        transmission = "Автомат";
                    } else if (car.getTransmission().equals("mechanical")) {
                        transmission = "Механическая";
                    }
            %>
            <div class="auto">
                <a title=<%=car.getBrand()+" "%>
                    <%=car.getModel()%> href="<%=Setting.getHost()%>/carPage?idCar=<%=encoderId.encodId(car.getIdCar().toString())%>">
                    <div class="model">
                        <%=car.getBrand() + " "%><%=car.getModel()%>
                    </div>
                </a>

                <div class="foto-185x120">
                    <a title=<%=car.getBrand()+" "%>
                        <%=car.getModel()%> href="<%=Setting.getHost()%>/carPage?idCar=<%=encoderId.encodId(car.getIdCar().toString())%>"
                       class="foto-185x120">
                        <img class="car_photo" id="<%="car"+countOfCar%>" src="<%=path%>" align="left">
                    </a>
                </div>

                <div class="model-info">
                    Цена: <span class="model-info-data"><%=car.getPrise()%>$</span><br>
                    Год: <span class="model-info-data"><%=car.getYearMade()%></span><br>
                    Пробег: <span class="model-info-data"><%=car.getMileage()%>км</span><br>
                    Двигатель: <span class="model-info-data"><%=car.getEngineCapacity()%></span><br>
                    Топливо: <span class="model-info-data"><%=EnginesType%></span><br>
                    КП: <span class="model-info-data"><%=transmission%></span><br>
                </div>
                <br/>

                <a title="Подробнее"
                   href="<%=Setting.getHost()%>/carPage?idCar=<%=encoderId.encodId(car.getIdCar().toString())%>"
                   class="more">
                    Подробнее...
                </a>
            </div>

            <%
                            countOfCar++;
                        }
                    }
                }
            %>


        </div>
        <%


            int numberFirstPage = 1;

            if (numberPage > 7) numberFirstPage = numberPage - 6;

            request.getSession().setAttribute("parameter", request.getParameterMap());

        %>
        <div class="page">
            <ul class="pagination">
                <%if (numberPage > 7) {%>
                <li><a href="<%=Setting.getHost()%>/replacing_the_page_number?page=<%=numberPage-1%>">«</a></li>
                <%}%>
                <%
                    int maxCount = 0;
                    for (int i = numberFirstPage; i <= countButtons; i++) {
                        if (maxCount >= 7) break;
                %>
                <li><a
                            <%if (i==numberPage){%>class="active"<%}%>
                            href="<%=Setting.getHost()%>/replacing_the_page_number?page=<%=i%>"><%=i%>
                </a></li>
                <%
                        maxCount++;
                    }
                    if (countButtons > 7) {%>
                <li><a href="<%=Setting.getHost()%>/replacing_the_page_number?page=<%=numberPage+1%>">»</a></li>
                <%}%>
            </ul>
        </div>
        <%--<div id="baner-right">--%>
        <%--Здесь находятся автомобили официальных диллеров. Любой официальный диллер любой марки может зрегестрироватся.--%>
        <%--</div>--%>
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

