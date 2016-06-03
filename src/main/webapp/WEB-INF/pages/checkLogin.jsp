<%@ page import="com.setting.Setting" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html >
<head>
  <meta charset="UTF-8">
  <title>Вход в акаунт</title>
  <link rel="shortcut icon" href="/res/img/favicon.ico"/>
  <link rel="stylesheet" href="res/css/checkLogin.css">
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
  <li><a title="Мои автомобили" href="registration" method="get">Регистрация</a></li>


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
      <h2 style="text-align: center; right: -5%; position: relative; font-size: xx-large;">${msg}</h2>

      <c:url value="/j_spring_security_check" var="loginUrl" />
      <form class="form" action="${loginUrl}"  method="post">

        <fieldset class="register-group">

          <label>
            <input type="text" placeholder="Номер диллера" name="j_username">
          </label>

          <label>
            <input type="password" placeholder="Пароль" name="j_password">
          </label>

        </fieldset>


        <button class="btn-default" type="submit">Войти</button>

      </form>
      <a class="lost_password" href="/lost_password">Забыли пароль</a>
    </div>
  </div>
</div>

<footer>Подвал </footer>
</body>
<script type="text/javascript">

  function validate_form() {
    valid = true;

    if (document.login_form.user.value == "") {
      alert("Пустые поля не допускаются");
      return false;
    }
    if (document.login_form.user.password.value == "") {
      alert("Пустые поля не допускаются");
      return false;
    }

  }
</script>


</html>
