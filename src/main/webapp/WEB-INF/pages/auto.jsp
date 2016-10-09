<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.modelClass.*" %>
<%@ page import="com.setting.Setting" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="java.text.Collator" %>
<%@ page import="java.text.CollationKey" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <link rel="stylesheet" type="text/css" href="<%=Setting.getPath()%>/res/css/modal_window.css">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="shortcut icon" href="/res/img/favicon.ico"/>
    <link rel="stylesheet" type="text/css" href="<%=Setting.getPath()%>/res/css/style_auto.css">
    <link rel="stylesheet" type="text/css" href="<%=Setting.getPath()%>/res/css/style_for_slider.css">


    <title> Автомобили с пробегом </title>
</head>

<body>


<div id="wrapper">
    <header>
        <a class="header" title="На главную" href="/"><img src="/res/img/primary_logo.png" alt=""></a>
        <%
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            String idDealer = auth.getName();
            if (idDealer != "anonymousUser") {
        %>
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
                <li><a title="На главную" href="/">На главную</a></li>
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

    <h5><a title="Вернуться к результатам поиска" href="/">Вернуться к результатам поиска</a></h5>

    <div id="layout">

        <div id="baner-right">

            <a href="https://adclick.g.doubleclick.net/pcs/click%253Fxai%253DAKAOjss2PHZ-OCWm0-j9gUlm-eoK-w1Nzt6AEiHVz7SMN2fA1SVKQRpHNSuzQMRHd4hhQHRHyNfSZCbaLDPTKCW3BuGbSJLi5HJHUcr9sTgMEZzCYsr4PNvR_cjLGvfYkjt_dBX_LNpvH_j6uOsx0PdAJ2HBFci5EpxNGKmgS9wWGaKJLoFOgwyH-X9Y86qDwekc641sIJ-ZIe6G92K-ILU7jEDT_I9uJajYZbCqCtpw5-uxlz5udLd6MS2sNfM%2526sig%253DCg0ArKJSzN53VUBcyITuEAE%2526urlfix%253D1%2526adurl%253Dhttps://ad.doubleclick.net/ddm/trackclk/N4022.1909409MOBILEDE.DE/B10050978.135595613%3Bdc_trk_aid%3D308114197%3Bdc_trk_cid%3D72857594%3Bdc_lat%3D%3Bdc_rdid%3D%3Btag_for_child_directed_treatment%3D"
               id="skyImage6295189607" onclick="window.open(this.href); return false;"><img
                    src="https://tpc.googlesyndication.com/pagead/imgad?id=CICAgKDLlOOSjQEQARgBMgj_7mJtqnRdzA"
                    width="200"
                    height="700" id="sky_content_6295189607" alt="Click me."></a>
        </div>
        <%
            Dealer dealer = (Dealer) request.getAttribute("dealer");
            Car car = (Car) request.getAttribute("car");
            if (car == null || dealer == null) {
                String redirectURL = "/";
                response.sendRedirect(redirectURL);
            } else {
                String path;
                if (car.getPhotoPath().size() == 0) {
                    path = Setting.getPath() + "/res/img/notAvailable.png";
                } else {
                    path = "/getPhoto?pathPhoto=" + car.getMainPhotoUrl() + "&percentage_of_reduction=50";

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

        <div id="result">
            <div class="auto">
                <div class="model">
                    <%=car.getBrand()%>  <%=car.getModel()%>
                </div>

                <div class="main-foto">
                    <div class="big_photo">
                        <a title="<%=car.getBrand()%>  <%=car.getModel()%>" href=# id="slider">
                            <img id='bigimgslide' class="foto-380x250" src='<%=path%>' align="left">
                        </a>
                    </div>
                    <div class="small-foto">
                        <%
                            List<PhotoPath> photoPaths = car.getPhotoPath();
//    Collections.sort(photoPaths, new Comparator<PhotoPath>() {
//      @Override
//      public int compare(PhotoPath o1, PhotoPath o2) {
//        return o1.getIdPhoto().compareTo(o2.getIdPhoto());
//      }
//    });
                            int idPhoto = 0;
                            for (PhotoPath photo : photoPaths) {
                                String paths;

                                paths = "/getPhoto?pathPhoto=" + photo.getPath() + "&percentage_of_reduction=50";

                        %>


                        <a title="<%=car.getBrand()%>  <%=car.getModel()%>" href="#">
                            <img id="<%=idPhoto%>" class="foto-85x56" onclick='setBigImageSlide(<%=idPhoto%>)'
                                 src="<%=paths%>" align="left">
                        </a>


                        <%
                                idPhoto++;
                            }%>
                    </div>
                </div>

                <div class="model-info">
                    Цена: <span class="model-info-data"><%=car.getPrise()%>$</span><br>
                    Год: <span class="model-info-data"><%=car.getYearMade()%></span><br>
                    Пробег: <span class="model-info-data"><%=car.getMileage()%>км</span><br>
                    Двигатель: <span class="model-info-data"><%=car.getEngineCapacity()%></span><br>
                    Топливо: <span class="model-info-data"><%=EnginesType%></span><br>
                    КП: <span class="model-info-data"><%=transmission%></span><br>
                    Комплектация: <span class="model-info-data"><%=car.getEquipment()%></span><br>
                    Дополнительно: <br><span class="model-info-data-coment"><%=car.getDescription()%></span>
                </div>

                <%if (dealer != null) {%>
                <div class="info">
                    <div class="town">Город:<br> <%=dealer.getAddress().getCity()%>
                    </div>
                    <div class="phone-number">Телефон:<br>
                        <%for (Contact_person contact_person : dealer.getContact_persons()) {%>
                        <%=contact_person.getPhone()%> <br>
                        <%}%>
                    </div>
                    <div class="diller">Дилер:<br> <%=dealer.getNameDealer()%>
                    </div>
                </div>
                <div class="send-mail">
                    <button class="btn-send" id="add_contact_person" type="button">Отправить письмо дилеру</button>
                </div>
                <%}%>

            </div>
        </div>
    </div>
</div>


<!-- Модальное окно -->
<div id="modal_form_photo">

    <div id="page-wrap">

        <span id="modal_close_photo"></span>

        <div id="main-photo-slider" style="position: relative;left: 0; width: 1300px; height: 1000px">
            <div data-u="slides"
                 style="cursor: default; position: relative; top: 0px; left: 0px; width: 1300px; height: 1000px; overflow: hidden;">
                <%
                    for (PhotoPath photo : photoPaths) {
                        String paths;
                        String pathSmall;
                        paths = "/getPhoto?pathPhoto=" + photo.getPath();
                        pathSmall = "/getPhoto?pathPhoto=" + photo.getPath() + "&percentage_of_reduction=50";
                %>
                <div data-p="112.50" style="display: none;">
                    <img data-u="image" src="<%=paths%>"/>
                    <img data-u="thumb" src="<%=pathSmall%>"/>
                </div>
                <%}%>

                <%--<a data-u="add" href="http://www.jssor.com" style="display:none">Jssor Slider</a>--%>

            </div>
            <!--Thumbnail Navigator -->
            <div u="thumbnavigator" class="jssort03"
                 style="position:absolute;left:0px;bottom:0px;width:800px;height:100px;" data-autocenter="1">
                <div style="position: absolute; top: 0; left: 0; width: 100%; height:100%; background-color: #000; filter:alpha(opacity=30.0); opacity:0.3;"></div>
                <!-- Thumbnail Item Skin Begin -->
                <div u="slides"
                     style="cursor: default;position: absolute;overflow: hidden;left: 41.5px;top: 24px; width: 517px;height: 50px;z-index: 0;">
                    <div u="prototype" class="p">
                        <!--<div class="w">-->
                        <div u="thumbnailtemplate" class="t"></div>
                        <!--</div>-->
                        <div class="c"></div>

                    </div>
                </div>
                <!-- Thumbnail Item Skin End -->
            </div>
            <!--Arrow Navigator -->
            <span data-u="arrowleft" class="jssora02l" style="top:0px;left:8px;width:55px;height:55px;"
                  data-autocenter="2"></span>
            <span data-u="arrowright" class="jssora02r" style="top:0px;right:8px;width:55px;height:55px;"
                  data-autocenter="2"></span>
        </div>

        <%
            }
        %>
    </div>
</div>
</div>
<footer style="text-align: center">autoport.kh.ua@gmail.com</footer>
<script src="http://code.jquery.com/jquery-1.8.3.js"></script>
<%--<script type="text/javascript" src="<%=Setting.getPath()%>/res/js/jquery-1.2.6.min.js"></script>--%>
<script type="text/javascript" src="<%=Setting.getPath()%>/res/js/jquery-easing-1.3.pack.js"></script>
<script type="text/javascript" src="<%=Setting.getPath()%>/res/js/modal_window.js"></script>
<script type="text/javascript" src="<%=Setting.getPath()%>/res/js/stick_menu.js"></script>
<script type="text/javascript" src="<%=Setting.getPath()%>/res/js/jquery-easing-compatibility.1.2.pack.js"></script>
<script type="text/javascript" src="<%=Setting.getPath()%>/res/js/jssor.slider.mini.js"></script>
<script type="text/javascript">
    function setBigImageSlide(group) {
        function changeSrc() {
            document.getElementById("bigimgslide").src = document.getElementById(group).src;
        };
        $("#bigimgslide").animate({opacity: 0}, 300);
        setTimeout(changeSrc, 300);
        $("#bigimgslide").animate({opacity: 1}, 300);
    }
</script>
<script type="text/javascript">
    $(document).ready(function () { // вся магия после загрузки страницы
        $('a#slider').click(function (event) { // ловим клик по ссылки с id="go"
            event.preventDefault(); // выключаем стандартную роль элемента
            $('#overlay').fadeIn(400, // сначала плавно показываем темную подложку
                    function () { // после выполнения предъидущей анимации
                        var big_photo = $('#big-photo1');
                        if (big_photo.height() > big_photo.width()) {
                            big_photo
                                    .css('position', 'relative')
                                    .css('right', '-25%');
                        }
                        $('#modal_form_photo')

                                .css('display', 'block') // убираем у модального окна display: none;
                                .animate({opacity: 1, top: '20%'}, 200); // плавно прибавляем прозрачность одновременно со съезжанием вниз

                    });
        });
        /* Закрытие модального окна, тут делаем то же самое но в обратном порядке */
        $('#modal_close_photo, #overlay').click(function () { // ловим клик по крестику или подложке
            $('#modal_form_photo')
                    .animate({opacity: 0, top: '45%'}, 200,  // плавно меняем прозрачность на 0 и одновременно двигаем окно вверх
                    function () { // после анимации
                        $(this).css('display', 'none'); // делаем ему display: none;
                        $('#overlay').fadeOut(400); // скрываем подложку
                    }
            );
        });
    });
</script>
<script>
    function msg_validator(msg) {
        if (msg.id.length === 0)return false;
        if (msg.message.length === 0)return false;
        if (msg.client_mail.length === 0)return false;
        else return true;
    }
    $(document).ready(function () {
        $("#send_msg").click(function () {
            var message = new Object();
            message.id = $("#dealer_id").val();
            message.message = $("#dealer_message").val();
            message.client_mail = $("#client_email").val();
            message.tel=$("#client_tel").val();
            if (msg_validator(message)) {
                $.ajax({
                    contentType: 'application/json',
                    dataType: 'json',
                    type: "POST",
                    data: JSON.stringify(message),
                    url: "/send_msg_for_dealer",
                    success: function (data) {
                        if (data) {
                            alert("Сообщение успешно отправленно!");
                            $("#dealer_message").val("");
                        }
                        else {
                            alert("Что то не так попробуйте еще раз")
                        }
                    },
                    statusCode: {
                        404: function () {
                            alert("Сервер не доступен, попробуйте позже!");
                        }
                    }
                });
            }
            else alert("Что то не так попробуйте еще раз");
            $("#modal_close1").click();
        })


    });
    jQuery(document).ready(function ($) {

        var jssor_1_options = {
            $FillMode: 1,
            $DragOrientation: 3,
            $AutoPlay: false,
            $ArrowNavigatorOptions: {
                $Class: $JssorArrowNavigator$
            },
            $ThumbnailNavigatorOptions: {
                $Class: $JssorThumbnailNavigator$,
                $Cols: 8,
                $SpacingX: 5,
                $SpacingY: 3,
                $Align: 260
            }
        };

        var jssor_1_slider = new $JssorSlider$("main-photo-slider", jssor_1_options);

        //responsive code begin
        //you can remove responsive code if you don't want the slider scales while window resizing
        function ScaleSlider() {
            var refSize = jssor_1_slider.$Elmt.parentNode.clientWidth;
            if (refSize) {
                refSize = Math.min(refSize, 1200);
                jssor_1_slider.$ScaleWidth(refSize);
            }
            else {
                window.setTimeout(ScaleSlider, 30);
            }
        }

        ScaleSlider();
        $(window).bind("load", ScaleSlider);
        $(window).bind("resize", ScaleSlider);
        $(window).bind("orientationchange", ScaleSlider);
        //responsive code end
    });
</script>
<!-- Модальное окно -->
<div id="modal_form1">
    <img id="modal_close1" src="../res/img/close.png" style="
    width: 40px;
    height: 40px;
    left: 98%;
    top: -9%;
    "/>
    <%--<form action="/send_msg_for_dealer" method="post">--%>
    <h3>Введите пожалуйста данные</h3>
    <input type="hidden" id="dealer_id" value="<%=dealer.getNumberDealer()%>">

    <p>Электронный адресс<br/>
        <input type="email" id="client_email" size="35"/>
    </p>
    <p>Телефон для связи (Необязательно)<br/>
        <input type="text" id="client_tel" size="35"/>
    </p>

    <p>Сообщение<br/>
                <textarea style="width: 280px;" id="dealer_message" class="message" maxlength="380" required="required"
                          cols="37" rows="8"></textarea>
    </p>

    <p style="text-align: center; padding-bottom: 10px;">
        <input id="send_msg" type="button" value="Отправить"/>
    </p>

    <%--</form>--%>
</div>

<!-- Модальное окно -->
<script>
    var successful = "Спасибо за отзыв, мы постараемся исправить это в ближайщее время.";
    var unsuccessful = "Введите корректный email.";
    var empty_field = "Вы оставили пустые поля!"

</script>
<script type="text/javascript" charset=utf-8" src="<%=Setting.getPath()%>/res/js/feedback-sender.js"></script>
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
</body>

</html>

