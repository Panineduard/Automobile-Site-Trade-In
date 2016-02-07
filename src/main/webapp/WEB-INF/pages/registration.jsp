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

    <style>
        /* NOTE: The styles were added inline because Prefixfree needs access to your styles and they must be inlined if they are on local disk! */
        @import url(http://fonts.googleapis.com/css?family=Exo:100,200,400);
        @import url(http://fonts.googleapis.com/css?family=Source+Sans+Pro:700,400,300);

        body{
            margin: 0;
            padding: 0;
            background: #fff;

            color: #fff;
            font-family: Arial;
            font-size: 12px;
        }

        .body{
            position: absolute;
            top: -20px;
            left: -20px;
            right: -40px;
            bottom: -40px;
            width: auto;
            height: auto;
            background-image: url(res/img/ukraine.jpg);
            background-size: cover;
            -webkit-filter: blur(5px);
            z-index: 0;
        }

        .grad{
            position: absolute;
            top: -20px;
            left: -20px;
            right: -40px;
            bottom: -40px;
            width: auto;
            height: auto;
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(0,0,0,0)), color-stop(100%,rgba(0,0,0,0.65))); /* Chrome,Safari4+ */
            z-index: 1;
            opacity: 0.7;
        }

        .header{
            position: absolute;
            top: calc(50% - 250px);
            left: calc(50% - 450px);
            z-index: 2;
        }

        .header div{
            float: left;
            color: #fff;
            font-family: 'Exo', sans-serif;
            font-size: 35px;
            font-weight: 200;
        }

        .header div span{
            color: #5379fa !important;
        }

        .login{
            position: absolute;
            top: calc(50% - 300px);
            left: calc(50% - 50px);
            height: 150px;
            width: 550px;
            padding: 10px;
            z-index: 2;
        }

        .login input[type=text]{
            width: 250px;
            height: 30px;
            background: transparent;
            border: 1px solid rgba(255,255,255,0.6);
            border-radius: 2px;
            color: indigo;
            font-family: 'Exo', sans-serif;
            font-size: 16px;
            font-weight: 400;
            padding: 4px;
        }
        .login input[type=email]{
            width: 250px;
            height: 30px;
            background: transparent;
            border: 1px solid rgba(255,255,255,0.6);
            border-radius: 2px;
            color: indigo;
            font-family: 'Exo', sans-serif;
            font-size: 16px;
            font-weight: 400;
            padding: 4px;
        }
        .login input[type=password]{
            width: 250px;
            height: 30px;
            background: transparent;
            border: 1px solid rgba(255,255,255,0.6);
            border-radius: 2px;
            color: #fff;
            font-family: 'Exo', sans-serif;
            font-size: 16px;
            font-weight: 400;
            padding: 4px;
            margin-top: 10px;
        }

        .login input[type=button]{
            width: 260px;
            height: 35px;
            background: #fff;
            border: 1px solid #fff;
            cursor: pointer;
            border-radius: 2px;
            color: #a18d6c;
            font-family: 'Exo', sans-serif;
            font-size: 16px;
            font-weight: 400;
            padding: 6px;
            margin-top: 10px;
        }

        .login input[type=button]:hover{
            opacity: 0.8;
        }

        .login input[type=button]:active{
            opacity: 0.6;
        }

        .login input[type=text]:focus{
            outline: none;
            border: 1px solid rgba(255,255,255,0.9);
        }
        .login input[type=email]:focus{
            outline: none;
            border: 1px solid rgba(255,255,255,0.9);
        }
        .login input[type=password]:focus{
            outline: none;
            border: 1px solid rgba(255,255,255,0.9);
        }

        .login input[type=button]:focus{
            outline: none;
        }

        ::-webkit-input-placeholder{
            color: rgba(255,255,255,0.6);
        }

        ::-moz-input-placeholder{
            color: rgba(255,255,255,0.6);
        }
    </style>


    <script src="res/js/prefixfree.min.js"></script>


</head>

<body>

<div class="body"></div>
<div class="grad"></div>
<div class="header">
    <div>Ввести <span>данные</span></div><br>
    <h2><br>${msg}</h2>
</div>
<br>

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
    <input type="text" placeholder="Номер диллера(Только цифры)" value="<%=numberDealer%>" name="numberDealer"><br>
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
        </div>
    </td>
    <td ><a href="javascript:;"
                        title="change captcha text"
                        onclick="document.getElementById('captcha_id').src = 'captcha.jpg?' + Math.random();  return false">
        <img src="res/img/refresh.png" width="30"  height="30" />
    </a></td>
    <input type="text" placeholder="Текст с картинки" name="captcha"><br>
    <input type="submit" value="Зарегистрироваться">
    <%--<h1> <%= session.getAttribute("my2")%>!!</h1>--%>
</div>
    </FORM>

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
















