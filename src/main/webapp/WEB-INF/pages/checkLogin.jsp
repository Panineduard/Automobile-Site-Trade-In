<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html >
<head>
  <meta charset="UTF-8">
  <title>Вход в акаунт</title>

  <link rel="stylesheet" href="res/css/checkLogin.css">
</head>

<body>
<div class="body"></div>
<div class="wrapper">
  <div class="container">
    <h2>${msg}</h2>

      <c:url value="/j_spring_security_check" var="loginUrl" />
    <form class="form" action="${loginUrl}"  method="post">
      <input type="text" placeholder="Номер диллера" name="j_username">
      <input type="password" placeholder="Пароль" name="j_password">
      <button type="submit">Войти</button>
    </form>

  </div>


</div>




<form action="/">
  <button type="submit">На главную страницу</button>
</form>


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
