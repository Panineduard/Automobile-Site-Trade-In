<%--
  Created by IntelliJ IDEA.
  User: volkswagen1
  Date: 15.03.2016
  Time: 18:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

  <title> Автомобили с пробегом </title>
  <link rel="stylesheet" href="res/css/lost_password.css">
</head>

<body>
<header>

  <script type="text/javascript">

    function validate_form() {
      if (document.user_form.password.value != document.user_form.password_check.value) {
        alert("Проверьте правильность ввода пароля.");
        return false;
      }
    }

  </script>
  <h1><a class="header"title="На главную" href="">NAME OF OUR PROJECT</a></h1>
  <h2>Автомобили с пробегом <br>
    <Small>Только официальные дилеры</Small></h2>
  <!-- <h5>Результаты поиска: </h5><br>  -->
</header>
<ul id="menu">
  <li><a title="На главную" href="/">На главную</a></li>
  <li><a title="Мои автомобили" href="/registration">Регистрация</a></li>

</ul>


<div id="layout">

  <div id="result">
    <div class="auto">
      <p>Ведите адрес электронной почты который указан при регистрации</p>
      <form name = "user_form" action="/lost_password" method="post" onsubmit="return validate_form ( );">
        <p><label>E-mail: <input name="email" type="email" required></label></p>
        <p><label>Номер диллера<input name="dealers_number" type="text"></label></p>
        <p><label>Новый пароль<input name="password" type="password"></label></p>
        <p><label>Подтвердите пароль<input name="password_check" type="password"></label></p>
        <p><input type="submit" value= "Изменить пароль"></p>
      </form>
    </div>

  </div>


</div>

<footer>Подвал </footer>




</body>
</html>
