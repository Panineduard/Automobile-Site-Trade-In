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
    ${msg}

    <form name="login_form" class="form" action="/login" onsubmit=" return validate_form ( );" method="post">
      <input type="text" placeholder="Номер диллера" name="user">
      <input type="password" placeholder="Пароль" name="password">

      <button type="submit">Войти</button>
      <%--<%--%>
      <%--String massege;--%>
      <%--if(session.getAttribute("my3")==null){massege="";}--%>
      <%--else massege=(String)session.getAttribute("my3");%>--%>
      <%--<h1 > <%=massege %></h1>--%>
    </form>

  </div>


</div>


<script src="res/js/index.js"></script>

<form action="/startPage">
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
