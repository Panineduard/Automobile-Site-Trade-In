<%@ page import="com.modelClass.Car" %>
<%@ page import="com.helpers.EncoderId" %>
<%@ page import="com.setting.Setting" %>
<%@ page import="com.modelClass.PhotoPath" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta name="keywords"
          content="предлагает авто с пробегом,б/у автомобили, автомобили с пробегом, продажа б/у автомобилей, официальные дилерские автомобили, пробегом, с историей ,проверенные у дилеров ">
    <meta name="description"
          content=" Здесь расположены автомобили от официальных дилеров Украины. Вы можете просмотреть автомобили находящиеся на площадках дилера.">
    <title> Автомобили с пробегом </title>
    <script>
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r;
            i[r] = i[r] || function () {
                        (i[r].q = i[r].q || []).push(arguments)
                    }, i[r].l = 1 * new Date();
            a = s.createElement(o),
                    m = s.getElementsByTagName(o)[0];
            a.async = 1;
            a.src = g;
            m.parentNode.insertBefore(a, m)
        })(window, document, 'script', 'https://www.google-analytics.com/analytics.js', 'ga');
        ga('create', 'UA-78730416-1', 'auto');
        ga('send', 'pageview');
    </script>
    <script src="http://code.jquery.com/jquery-1.10.2.js"></script>
    <script>
        var engine_parameter = ['Бензин', 'Дизель', 'Электро', 'Гибрид', 'Газ/бензин', 'Другое'];
        var gearbox_parameter = ['Другое', 'Автоматическая', 'Механическая'];
        var formCantBeSend = [];
        var firstValueInBrand = '';
    </script>
    <script type="text/javascript" src="/res/js/get_model_by_brand.js"></script>
    <script type="text/javascript" src="/res/js/write_parameters.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=Setting.getPath()%>/res/css/modal_window.css">
    <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <script type="text/javascript" src="/res/js/pageForCar.js"></script>
    <link rel="shortcut icon" href="/res/img/favicon.ico"/>
    <link rel="stylesheet" type="text/css" href="/res/css/style_addCar.css">
    <link rel="stylesheet" type="text/css" href="/res/css/modal_windows_page_for_car.css">
    <script type="text/javascript" src="<%=Setting.getPath()%>/res/js/stick_menu.js"></script>
    <link rel="stylesheet" href="/res/css/percircle.css">
    <script type="text/javascript" src="<%=Setting.getPath()%>/res/js/modal_window.js"></script>

    <% EncoderId encoderId = new EncoderId();
        Car car = (Car) session.getAttribute("chCar");
        boolean presentCar = false;
        if (car != null) {
            presentCar = true;
            String path;
            if (car.getPhotoPath().size() == 0) {
                path = "/res/img/notAvailable.png";
            } else {
                path = "/getPhoto?pathPhoto=" + car.getPhotoPath().get(0);
            }

        }
    %>
    <script>
        $(document).ready(function () {
            //check valid date in form
            //check make
            var elements = [$("#id_make"), $("#id_model"), $("#id_prise"), $("#id_mileage"), $("#id_capacity"), $("#id_comment")];
            var text_massage = $(".text_massage");
            var value;
            <%if(presentCar){%>
            value=true;
            <%}else {%>
            value=false
            <%}%>
            var make_valid=value,model_valid=value,prise_valid=value,mileage_valid=value,capacity_valid=value,comment_valid = value;
            var Massages = {
                f1: function () {
                    Service.focus_massege("make", 1);
                    text_massage[0].innerHTML = "Выберете одну из марок";
                },
                f2: function () {
                    Service.focus_massege('model', 1);
                    if (make_valid) {
                        text_massage[1].innerHTML = "Выберете одну из моделей!";
                    }
                    else {
                        text_massage[1].innerHTML = "Выберете корректно марку автомобиля!";
                    }
                },
                f3: function () {
                    Service.focus_massege("prise", 1);
                    text_massage[2].innerHTML = "Цена задается только цифрами без знаков!";
                },
                f4: function () {
                    Service.focus_massege('mileage', 1);
                    text_massage[3].innerHTML = "Пробег задается только цифрами без знаков!";
                },
                f5: function () {
                    Service.focus_massege("capacity", 1);
                    text_massage[4].innerHTML = "Обьем двигателя задается цифрой через точку! Пример (1.0).";
                },
                f6: function () {
                    Service.focus_massege("comment", 1);
                    text_massage[5].innerHTML = "Описание должно содержать не менее 15 символов!";
                }
            };
            //Check brand data
            elements[0].focus(function () {
                if (!make_valid) {
                    Massages.f1();
                }
            });
            elements[0].focusout(function () {
                if (make_valid) {
                    Service.focus_massege("make", 0);
                }
            });
            elements[0].change(function (e) {
                make_valid = Service.check_valid("make", elements[0].val() === firstValueInBrand);
                if (make_valid) {
                    model_valid = false;
                }
                if (!make_valid) {
                    text_massage[0].innerHTML = "Неправильно выбрвна марка!";
                }
            });
            //Check model data
            elements[1].focus(function () {
                if (!model_valid) {
                    Massages.f2();
                }
            });
            elements[1].focusout(function () {
                if (model_valid) {
                    Service.focus_massege('model', 0);
                }
            });
            elements[1].change(function () {
                model_valid = Service.check_valid('model', elements[1].val() === '');
                if (!model_valid) {
                    text_massage[1].innerHTML = "Неправильно выбрана модель автомобиля!";
                }
            });
            //check field prise on a numbers  alert(input.val().match('[0-9]+$'));
            elements[2].focus(function () {
                if (!prise_valid) {
                    Massages.f3();
                }
            });
            elements[2].focusout(function () {
                if (prise_valid) {
                    Service.focus_massege("prise", 0);
                }
            });
            elements[2].change(function () {
                var valid = $(this).val().match('[0-9]+$');
                prise_valid = Service.check_valid("prise", valid == null);
                if (!prise_valid) {
                    text_massage[2].innerHTML = "Цена задана не корректно повторите ввод!";
                }
            });
            //Check mileage data
            elements[3].focus(function () {
                if (!mileage_valid) {
                    Massages.f4();
                }
            });
            elements[3].focusout(function () {
                if (mileage_valid) {
                    Service.focus_massege("mileage", 0);
                }
            });
            elements[3].change(function () {
                var valid = $(this).val().match('[0-9]+$');
                mileage_valid = Service.check_valid('mileage', valid == null);
                if (!mileage_valid) {
                    text_massage[3].innerHTML = "пробег задан не корректно повторите ввод!";
                }
            });
            //Check engine capacity data
            elements[4].focus(function () {
                if (!capacity_valid) {
                    Massages.f5();
                }
            });
            elements[4].focusout(function () {
                if (capacity_valid) {
                    Service.focus_massege("capacity", 0);
                }
            });
            elements[4].change(function () {
                var v = /\d+\.+\d{1}/;
                capacity_valid = Service.check_valid("capacity", !v.test($(this).val()));
                if (!capacity_valid) {
                    text_massage[4].innerHTML = "Обьем двигателя задан не корректно повторите ввод.";
                }
            });
            //Check comment data
            elements[5].focus(function () {
                if (!comment_valid) {
                    Massages.f6();
                }
            });
            elements[5].focusout(function () {
                if (comment_valid) {
                    Service.focus_massege("comment", 0);
                }
            });
            elements[5].change(function () {
                comment_valid = Service.check_valid("comment", $(this).val().length < 15);
                if (!comment_valid) {
                    text_massage[5].innerHTML = "Коментарии должны быть более 15 символов";
                }
            });
            $("#form").submit(
                    function () {
                        var result = [make_valid, model_valid, prise_valid, capacity_valid, comment_valid, mileage_valid];
                        if (make_valid && model_valid && prise_valid && capacity_valid && comment_valid && mileage_valid) {
                            for(var x=0;x<formCantBeSend.length;x++){
                                if(!formCantBeSend[x]){
                                    alert("Подождите загрузку фотографий!")
                                    return false;
                                }
                            }
                        } else {
                            for (var i = 1; i <= result.length; i++) {
                                if (!result[i - 1]) {
                                    Massages['f' + i]();
                                    var elem = elements[i - 1];
                                    $("html, body").delay(200).animate({scrollTop: (elem.offset().top) - 200}, 1000);
                                    return false;
                                }
                            }
                        }
                    });
        });
        function delete_image_funct(count) {
            $('#modal_form' + count)
                    .css('display', 'block') // убираем у модального окна display: none;
                    .animate({opacity: 1, top: '50%'}, 200); // плавно прибавляем прозрачность одновременно со съезжанием вниз

            $('.modal_close').click(function () { // ловим клик по крестику или подложке
                $('#modal_form' + count)
                        .animate({opacity: 0, top: '45%'}, 200,  // плавно меняем прозрачность на 0 и одновременно двигаем окно вверх
                        function () { // после анимации
                            $(this).css('display', 'none'); // делаем ему display: none;
                        }
                );
                count = 0;
                return;
            });
            $('#modal_del_ok' + count).click(function () {
                        if (count == 0) {
                            return
                        }
                        ;
                        //убираем модальное окно
                        $('#modal_form' + count)
                                .animate({opacity: 0, top: '45%'}, 200,  // плавно меняем прозрачность на 0 и одновременно двигаем окно вверх
                                function () { // после анимации
                                    $(this).css('display', 'none'); // делаем ему display: none;
                                }
                        );
                        change_field_on_input_img(count - 1, 0);
                        //меняем фто  на изображение
                        change_img_atribute(count);
                        //Шлем запрос на сервер
                        <%if (presentCar){%>
                        var present_photo = $('#present_photo' + count);
                        if (present_photo.val() == 'true') {
                            var idPhoto = $("#idPhoto" + count).val();

//                            $('#class_with_photo' + count).append('<input id="present_photo' + count + '" type="hidden" value="false"  >')

                            $.get("/delete_photo", {count_of_photo: idPhoto, id_car:<%=car.getIdCar()%>})
                                    .done(function (data) {
                                    });
                            $('#present_photo' + count).val(false);
                        }

                        <%}%>
                        count = 0;
                    }
            );
        }
    </script>


</head>

<body>
<div id='wrapper'>
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
        <%}%>
    </header>
    <div id="help_div"></div>
    <div id="stick_menu">
        <nav>
            <ul class="menu">
                <li><a title="Мои автомобили" href="<%=Setting.getHost()+"/myAccount"%>">Мои автомобили</a></li>
                <li><a title="Обратная связь" href="<%=Setting.getHost()+"/feedback"%>">Обратная связь</a></li>
                <li><a href="<%=Setting.getHost()+"/about_us"%>">О нас</a></li>
                <li><a href="" id="go">Сообщить об ошибке</a></li>
            </ul>
        </nav>
    </div>
    <h1>${msg}</h1>


    <div id="layout">
        <div id="baner-left">
        </div>
        <%--<div id="baner-right">--%>
        <%--some baner rightiygvbbuuuuuuuu uuuuuuuuuuuu uuuuuu uuuuuuuuuuu uuuuu uuuuuuu7 777777777777 77777 77777777 77777777 7777777 7777777--%>
        <%--</div>--%>
        <div id="result">
            <div class="auto">

                <%--/////////////////////////////////////////////////////////////////////////////////////--%>
                <form id="form" action="addCarWithPhoto" method="post">
                    <div class="container">
                        <%if (presentCar) {%>
                        <h3 class="addCar">Изменить автомобиль:</h3>
                        <input type="hidden" id="id_car" value="<%= encoderId.encodId(car.getIdCar().toString())%>"
                               name="id_car">
                        <%} else {%>
                        <h3 class="addCar">Добавить автомобиль:</h3>
                        <%}%>
                        <input type="hidden" name="count_of_photo" value="8">

                        <div class="col-sm-6 form-group">
                            <h2>Марка</h2>
                            <select id="id_make" class="form-control" onchange="p_delete(this.value,'');" name="make">
                            </select>

                            <div id="massage_make" style="position: absolute;opacity:0;left: 52%; top: 29%;">
                                <p class="text_massage"></p>
                                <img src="/res/img/massage.png">
                            </div>
                        </div>

                        <h2>Модель</h2>

                        <div class="col-sm-6 form-group">
                            <select id="id_model" name="model">
                                <option value="" selected="selected">выберите марку</option>
                            </select></p>
                            <div id="massage_model" style="position: absolute;opacity:0; left: 52%; top: 39%;">
                                <p class="text_massage"></p>
                                <img src="/res/img/massage.png">
                            </div>
                        </div>

                        <h2>Цена, $ <br>
                            <%if (presentCar) {%>
                            <input id="id_prise" type="text" size="20" class="form-control" value="<%=car.getPrise()%>"
                                   required="required" name="prise" pattern="[0-9]+$"></h2>
                        <%} else {%>
                        <input id="id_prise" type="text" size="20" class="form-control" required="required" name="prise"
                               pattern="[ 0-9]+$"></h2>
                        <%}%>
                        <div id="massage_prise" style="position: absolute;opacity: 0; left: 52%; top: 47%;">
                            <p class="text_massage"></p>
                            <img src="/res/img/massage.png">
                        </div>
                        <h2>Пробег, км <br>
                            <%if (presentCar) {%>
                            <input id="id_mileage" type="text" size="20" class="form-control"
                                   value="<%=car.getMileage().replaceAll("[\\s]{1,}", "").trim()%>" required="required"
                                   name="mileage"
                                   pattern="[0-9]+$"></h2>
                        <%} else {%>
                        <input id="id_mileage" type="text" size="20" class="form-control" required="required"
                               name="mileage"
                               pattern="[0-9]+$"></h2>
                        <%}%>
                        <div id="massage_mileage" style="position: absolute;opacity: 0; left: 52%; top: 54%;">
                            <p class="text_massage"></p>
                            <img src="/res/img/massage.png">
                        </div>

                        <h2>Год выпуска</h2>

                        <select id="id_year_from" class="form-control" name="year_prov">

                        </select>


                        <h2>Тип двигателя</h2>
                        <select id="id_engine" class="form-control" name="engine">

                        </select>

                        <h2>Обьем двигателя, л (В формате 2.0)<br>
                            <%if (presentCar) {%>
                            <input id="id_capacity" type="text" value="<%=car.getEngineCapacity()%>" size="3"
                                   class="form-control"
                                   required="required" name="engine_capacity" pattern="\d+\.+\d{1}"></h2>
                        <%} else {%>
                        <input id="id_capacity" type="text" size="20" class="form-control" required="required"
                               name="engine_capacity"
                               pattern="\d+\.+\d{1}"></h2>
                        <%}%>
                        <div id="massage_capacity" style="position: absolute;opacity:0; left: 52%; top: 81%;">
                            <p class="text_massage"></p>
                            <img src="/res/img/massage.png">
                        </div>
                        <h2>Тип КПП</h2>

                        <select id="id_gearbox" class="form-control" name="gearbox">

                        </select>

                        <p>РЕГИОН<br>
                            <select id="id_region" class="form-control" name="region">

                            </select></p>

                        <h2>Комплектация: <br>
                            <%if (presentCar) {%>
                            <input type="text" size="20" class="form-control" maxlength="20" name="equipment"
                                   value="<%=car.getEquipment()%>"></h2>
                        <%} else {%>
                        <input type="text" size="20" class="form-control" maxlength="20" name="equipment"></h2>
                        <%}%>

                        <h2>Описание</h2><br>
                        <%if (presentCar) {%>
                    <textarea id="id_comment" name="comment" class="form-control" maxlength="380" required="required"
                              cols="40"
                              rows="7"><%=car.getDescription()%></textarea></h2>
                        <%} else {%>
                    <textarea id="id_comment" name="comment" class="form-control" maxlength="380" required="required"
                              cols="40"
                              rows="7"></textarea></h2>
                        <%}%>
                        <div id="massage_comment" style="opacity:0; position: absolute;left: 52%; top: 118%;">
                            <p class="text_massage"></p>
                            <img src="/res/img/massage.png">
                        </div>
                    </div>

                    <!-- <p>Добавить фото:</p> -->
                    <div id="form_cars_data">
                        <div class="photo">

                            <table>
                                <caption>Добавить фото:</caption>
                                <tr>
                                    <td>
                                        <%
                                            for (int i = 0; i < 8; i++) {
                                                boolean presentPhoto = false;
                                                Long idPhotoCar = 0L;
                                                String pathMainPhoto = "../res/img/add_photo_main.png";
                                                String path = "../res/img/add_photo.png";
                                                if (presentCar) {
                                                    List<PhotoPath> photoPaths = car.getPhotoPath();
                                                    if (i < car.getPhotoPath().size()) {
                                                        presentPhoto = true;
                                                        idPhotoCar = photoPaths.get(i).getIdPhoto();
                                                        if (i == 0) {
                                                            pathMainPhoto = "/getPhoto?pathPhoto=" + photoPaths.get(i) + "&Width=200&Height=200";
                                                        } else
                                                            path = "/getPhoto?pathPhoto=" + photoPaths.get(i) + "&Width=200&Height=200";
                                                    }
                                                }
                                        %>
                                        <div class="photoCar" id="class_with_photo<%=i+1%>" data-parameter="<%=i+1%>">
                                            <div class="modal_form" id="modal_form<%=i+1%>">
                                                <p style="position: absolute; top: -15%">
                                                    <h8>Вы действительно хотите удалить фото?</h8>
                                                    <br>
                                                    <button class="modal_close" type="button">Отменить</button>
                                                    <button data-parameter="<%=presentPhoto%>" id="modal_del_ok<%=i+1%>"
                                                            class="modal_delete" type="button">Удалить
                                                    </button>
                                                </p>
                                            </div>
                                            <input id="present_photo<%=i+1%>" type="hidden" value="<%=presentPhoto%>">
                                            <input id="idPhoto<%=i+1%>" type="hidden" value="<%=idPhotoCar%>">
                                            <input id="suusesful_download<%=i+1%>" type="hidden" value="true">

                                            <a hidden id="file<%=i+1%>"><input accept="image/jpeg" id="image_p<%=i+1%>"
                                                                               name="files[<%=i%>]"
                                                                               onchange="readURL(this,<%=i%>);"
                                                                               type="file" multiple/></a>

                                            <%if (i == 0) {%>
                                            <%--<p><%=pathMainPhoto%> </p>--%>
                                            <img id="car_photo<%=i+1%>" src="<%=pathMainPhoto%>" class="image_block"
                                                 alt=""/>
                                            <%} else {%>
                                            <img id="car_photo<%=i+1%>" src="<%=path%>" class="image_block" alt=""/>
                                            <%}%>
                                            <%--                          Progress bar                             --%>
                                            <div id="pinkcircle<%=i+1%>" style="display: none"
                                                 class="small  pink percircle animate download_level">
                                                <span id="percent<%=i+1%>">0%</span>
                                                <!--gt50-->
                                                <div class="slice">
                                                    <div class="bar" id="percent_rotation<%=i+1%>"
                                                         style="transform: rotate(0deg);"></div>
                                                    <div class="fill" id="percent_rot1"></div>
                                                </div>
                                            </div>

                                            <%--<progress class="progressbar" id="progressbar<%=i+1%>" value="0" max="100"></progress>--%>

                                            <div id="<%=i+1%>" class="photoCarDel"></div>
                                        </div>
                                        <%if (!presentPhoto) {%>
                                        <script>
                                            change_img_atribute('<%=i+1%>');
                                        </script>
                                        <%}%>
                                    </td>
                                    <%if ((i + 1) % 3 == 0) {%></tr>
                                <tr><%}%>
                                    <td>
                                        <%
                                            }
                                        %>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>


                    <br>
                    <%if (presentCar) {%>
                    <button class="button-main" type="submit">Изменить автомобиль</button>
                    <br>
                    <%} else {%>
                    <button class="button-main" type="submit">Добавить автомобиль</button>
                    <br>
                    <%
                        }

                    %>
                </form>

            </div>
        </div>
    </div>
    <footer><a href="mailto:autoport.kh.ua@gmail.com?subject=Solutions">autoport.kh.ua@gmail.com</a></footer>

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

